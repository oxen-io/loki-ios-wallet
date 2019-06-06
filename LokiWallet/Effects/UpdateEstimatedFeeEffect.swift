import Foundation
import LokiWalletLib
import LokiWalletCore

public final class UpdateEstimatedFeeEffect: Effect {
    public init() {}
    public func effect(_ store: Store<ApplicationState>, action: SettingsState.Action) -> AnyAction? {
        guard case let .changeTransactionPriority(priority) = action else {
            return action
        }
        
        store.dispatch(
            TransactionsActions.calculateEstimatedFee(
                withPriority: priority
            )
        )
        
        return action
    }
}
