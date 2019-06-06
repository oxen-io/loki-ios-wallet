import LokiWalletLib
import LokiWalletCore
import LWLoki

public enum SubaddressesActions: HandlableAction {
    case update
    case updateFromSubaddresses(Subaddresses)
    case addNew(withLabel: String, handler: () -> Void)
}
