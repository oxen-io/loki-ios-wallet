import LokiWalletLib

public struct LokiWalletKeys: WalletKeys {
    public let spendKey: LokiWalletKeysPair
    public let viewKey: LokiWalletKeysPair
    
    public init(spendKey: LokiWalletKeysPair, viewKey: LokiWalletKeysPair) {
        self.spendKey = spendKey
        self.viewKey = viewKey
    }
}
