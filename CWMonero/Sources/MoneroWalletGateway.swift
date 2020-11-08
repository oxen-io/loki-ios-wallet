import UIKit
import CakeWalletLib
import CakeWalletCore

public final class MoneroWalletGateway: WalletGateway {
    public static var path: String {
        return ""
    }
    
    public static var type: WalletType {
        return .loki
    }
    
    public static func fetchWalletsList() -> [WalletIndex] {
        guard
            let docsUrl = FileManager.default.walletDirectory,
            let walletsDirs = try? FileManager.default.contentsOfDirectory(atPath: docsUrl.path) else {
                return []
        }
        
        let wallets = walletsDirs.map { name -> String? in
            var isDir = ObjCBool(false)
            let url = docsUrl.appendingPathComponent(name)
            FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir)
            
            return isDir.boolValue ? name : nil
            }.compactMap({ $0 })
        
        return wallets.map { name -> WalletIndex? in
            guard name != ".shared-ringdb" else {
                return nil
            }
            
            return WalletIndex(name: name, type: .loki)
            }.compactMap({ $0 })
    }
    
    public init() {}
    
    public func create(withName name: String, andPassword password: String) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.generate(withPath: self.makeURL(for: name).path, andPassword: password)
        try moneroAdapter.save()
        let walletConfig = WalletConfig(isRecovery: false, date: Date(), url: self.makeConfigURL(for: name))
        try walletConfig.save()
        return MoneroWallet(moneroAdapter: moneroAdapter, config: walletConfig)
    }
    
    public func load(withName name: String, andPassword password: String) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        let path = self.makeURL(for: name).path
        try moneroAdapter.loadWallet(withPath: path, andPassword: password)
        let walletConfig: WalletConfig
        
        do {
            walletConfig = try WalletConfig.load(from: self.makeConfigURL(for: name))
        } catch {
            if !FileManager.default.fileExists(atPath: self.makeConfigURL(for: name).path) {
                walletConfig = WalletConfig(isRecovery: false, date: Date(), url: self.makeConfigURL(for: name))
                try walletConfig.save()
            } else {
                throw error
            }
        }
        
        return MoneroWallet(moneroAdapter: moneroAdapter, config: walletConfig)
    }
    
    public func recoveryWallet(withName name: String, andSeed seed: String, password: String, restoreHeight: UInt64) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.recovery(at: self.makeURL(for: name).path, mnemonic: seed, andPassword: password, restoreHeight: restoreHeight)
//        try moneroAdapter.setPassword(password)
//        moneroAdapter.setRefreshFromBlockHeight(restoreHeight)
//        moneroAdapter.setIsRecovery(true)
//        try moneroAdapter.save()
        let walletConfig = WalletConfig(isRecovery: true, date: Date(), url: self.makeConfigURL(for: name))
        try walletConfig.save()
        return MoneroWallet(moneroAdapter: moneroAdapter, config: walletConfig, restoreHeight: restoreHeight)
    }
    
    public func recoveryWallet(withName name: String, publicKey: String, viewKey: String, spendKey: String, password: String, restoreHeight: UInt64) throws -> Wallet {
        let moneroAdapter = MoneroWalletAdapter()!
        try moneroAdapter.recoveryFromKey(at: self.makeURL(for: name).path, withPublicKey: publicKey, andPassowrd: password, andViewKey: viewKey, andSpendKey: spendKey, withRestoreHeight: restoreHeight)
//        try moneroAdapter.setPassword(password)
//        moneroAdapter.setRefreshFromBlockHeight(restoreHeight)
//        moneroAdapter.setIsRecovery(true)
//        try moneroAdapter.save()
        let walletConfig = WalletConfig(isRecovery: true, date: Date(), url: self.makeConfigURL(for: name))
        try walletConfig.save()
        return MoneroWallet(moneroAdapter: moneroAdapter, config: walletConfig, restoreHeight: restoreHeight)
    }
    
    public func remove(withName name: String) throws {
        let walletDir = try FileManager.default.walletDirectory(for: name)
        try FileManager.default.removeItem(atPath: walletDir.path)
    }
    
    public func fetchSeed(for wallet: WalletIndex) throws -> String {
        return try KeychainStorageImpl.standart.fetch(forKey: .seed(wallet))
    }
    
    public func isExist(withName name: String) -> Bool {
        guard let _ = try? FileManager.default.walletDirectory(for: name) else {
            return false
        }
        
        return true
    }
    
    public func removeCacheFile(for name: String) throws {
        let docDir = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let cachePath = String(format: "%@/%@", name, name)
        let url = docDir.appendingPathComponent(cachePath)
        try FileManager.default.removeItem(atPath:  url.path)
    }
}

private let estimatedSizeOfDefaultTransaction = UInt64(2000)
private var cachedFees: [TransactionPriority: Amount] = [:]

extension MoneroWalletGateway {
    public func calculateEstimatedFee(forPriority priority: TransactionPriority, withNode node: NodeDescription, handler: ((Result<Amount>) -> Void)?) {
        //fixme
//        workQueue.async {
            if let fee = cachedFees[priority] {
                handler?(.success(fee))
                return
            }

            self.fetchFees(withNode: node, forPriority: priority) { result in
                switch result {
                case let .success((feePerOut, feePerByte)):
                    let feeValue = UInt64(2) * feePerOut + estimatedSizeOfDefaultTransaction * feePerByte
                    let fee = MoneroAmount(value: feeValue)
                    cachedFees[priority] = fee
                    handler?(.success(fee))
                case let .failed(error):
                    handler?(.failed(error))
                }
            }
//        }
    }

    private func fetchFees(withNode node: NodeDescription, forPriority priority: TransactionPriority, handler: ((Result<(UInt64, UInt64)>) -> Void)?) {
        let urlString = String(format: "http://%@/json_rpc", node.uri).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let requestBody = [
            "jsonrpc": "2.0",
            "id": "0",
            "method": "get_fee_estimate"
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
            request.httpBody = jsonData
        } catch {
            handler?(.failed(error))
        }

        let connection = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                if let error = error {
                    handler?(.failed(error))
                    return
                }

                guard let data = data else {
                    handler?(.success((0, 0)))
                    return
                }

                if
                    let decoded = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let result = decoded["result"] as? [String: Any],
                    let per_out = result[priority == .slow ? "fee_per_output" : "blink_fee_per_output"] as? UInt64,
                    let per_byte = result[priority == .slow ? "fee_per_byte" : "blink_fee_per_byte"] as? UInt64 {
                    handler?(.success((per_out, per_byte)))
                } else {
                    handler?(.success((0, 0)))
                }
            } catch {
                handler?(.failed(error))
            }
        }

        connection.resume()
    }
}
