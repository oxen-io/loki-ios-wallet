import Foundation
import LokiWalletLib

public final class LokiTransactionHistory: TransactionHistory {
    public var transactions: [TransactionDescription] {
        return transactionHisory.getAll().map { TransactionDescription(lokiTransactionInfo: $0) }
    }
    public var count: Int {
        return Int(self.transactionHisory.count())
    }
    private(set) var transactionHisory: LokiWalletHistoryAdapter
    
    public init(lokiWalletHistoryAdapter: LokiWalletHistoryAdapter) {
        self.transactionHisory = lokiWalletHistoryAdapter
    }
    
    public func refresh() {
        self.transactionHisory.refresh()
    }
    
    public func newTransactions(afterIndex index: Int) -> [TransactionDescription] {
        guard index >=   0 else {
            return []
        }
        
        let endIndex = count - index
        var transactions = [TransactionDescription]()
        
        for i in index..<endIndex {
            transactions.append(TransactionDescription(lokiTransactionInfo: transactionHisory.transaction(Int32(i))))
        }
        
        return transactions
    }
}
