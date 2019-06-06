import Foundation
import LokiWalletLib

public struct LokiPendingTransaction: PendingTransaction {
    public var description: PendingTransactionDescription {
        let status: TransactionStatus
        
        switch lokiPendingTransactionAdapter.status() {
        case 0:
            status = .ok
        default:
            status = .error(lokiPendingTransactionAdapter.errorString())
        }
        
        return PendingTransactionDescription(
            id: lokiPendingTransactionAdapter.txid()?.first as? String ?? "",
            status: status,
            amount: LokiAmount(value: lokiPendingTransactionAdapter.amount()),
            fee: LokiAmount(value: lokiPendingTransactionAdapter.fee()))
    }
    
    private let lokiPendingTransactionAdapter: LokiPendingTransactionAdapter
    
    public var id: String? {
        guard
            let nsstring = lokiPendingTransactionAdapter.txid()?.first as? NSString,
            let data = nsstring.data(using: String.Encoding.utf8.rawValue),
            let res = String(data: data, encoding: .utf8) else {
                return nil
        }
       
        return res
    }
    
    public init(lokiPendingTransactionAdapter: LokiPendingTransactionAdapter) {
        self.lokiPendingTransactionAdapter = lokiPendingTransactionAdapter
    }
    
    public func commit(_ handler: @escaping (LokiWalletLib.Result<Void>) -> Void) {
        do {
            try self.lokiPendingTransactionAdapter.commit()
            handler(.success(()))
        } catch {
            handler(.failed(error))
        }
        
    }
}
