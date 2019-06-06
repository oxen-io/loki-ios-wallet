import Foundation
import LokiWalletLib

extension TransactionDescription {
    public init(lokiTransactionInfo: LokiTransactionInfoAdapter) {
        self.init(
            id: lokiTransactionInfo.hash(),
            date: Date(timeIntervalSince1970: lokiTransactionInfo.timestamp()),
            totalAmount: LokiAmount(value: lokiTransactionInfo.amount()),
            fee: LokiAmount(value: lokiTransactionInfo.fee()),
            direction: lokiTransactionInfo.direction() != 0 ? .outcoming : .incoming,
            priority: .default,
            status: .ok,
            isPending: lokiTransactionInfo.blockHeight() <= 0,
            height: lokiTransactionInfo.blockHeight(),
            paymentId: lokiTransactionInfo.paymentId()
        )
    }
}
