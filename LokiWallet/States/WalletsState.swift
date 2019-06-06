import LokiWalletCore
import LokiWalletLib

public struct WalletsState: StateType {
    public enum Action: AnyAction {
        case fetchedWallets([WalletIndex])
    }
    
    public let wallets: [WalletIndex]
    
    public init(wallets: [WalletIndex]) {
        self.wallets = wallets
    }
    
    public func reduce(_ action: WalletsState.Action) -> WalletsState {
        switch action {
        case let .fetchedWallets(wallets):
            return WalletsState(wallets: wallets)
        }
    }
}
