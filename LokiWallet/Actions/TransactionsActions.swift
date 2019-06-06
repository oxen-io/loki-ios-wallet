import LokiWalletLib
import LokiWalletCore

public enum TransactionsActions: HandlableAction {
    case calculateEstimatedFee(withPriority: TransactionPriority)
    case updateTransactions([TransactionDescription])
    case updateTransactionHistory(TransactionHistory)
    case forceUpdateTransactions
}
