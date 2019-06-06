import LokiWalletLib
import LokiWalletCore

public enum BlockchainActions: HandlableAction {
    case fetchBlockchainHeight
    case checkConnection
}
