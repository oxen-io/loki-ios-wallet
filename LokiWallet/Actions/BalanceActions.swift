import LokiWalletLib
import LokiWalletCore

public enum BalanceActions: HandlableAction {
    case updateFiatPrice
    case updateFiatBalance(price: Double)
}
