import LokiWalletLib
import LokiWalletCore
import LWLoki

extension Subaddresses {
    public func all() -> [Subaddress] {
        return getAll().compactMap { $0 as? Subaddress }
    }
}

public struct UpdateSubaddressesHandler: Handler {
    public func handle(action: SubaddressesActions, store: Store<ApplicationState>) -> AnyAction? {
        guard
            case .update = action,
            let lokiWallet = currentWallet as? LokiWallet else { return nil }
        return UpdateSubaddressesHistroyHandler()
            .handle(
                action: SubaddressesActions.updateFromSubaddresses(lokiWallet.subaddresses()),
                store: store
        )
    }
}

public struct UpdateSubaddressesHistroyHandler: Handler {
    public func handle(action: SubaddressesActions, store: Store<ApplicationState>) -> AnyAction? {
        guard case let .updateFromSubaddresses(subaddresses) = action else { return nil }
        subaddresses.refresh()
        return SubaddressesState.Action.changed(subaddresses.all())
    }
}

public struct AddNewSubaddressesHandler: AsyncHandler {
    public func handle(action: SubaddressesActions, store: Store<ApplicationState>, handler: @escaping (AnyAction?) -> Void) {
        guard
            case let .addNew(label, completionHandler) = action,
            let lokiWallet = currentWallet as? LokiWallet else { return handler(nil) }
        guard !label.isEmpty else { return handler(nil) }
        
        DispatchQueue.main.async {
            let subaddresses = lokiWallet.subaddresses()
            subaddresses.newSubaddress(withLabel: label)
            subaddresses.refresh()
            handler(
                SubaddressesState.Action.added(subaddresses.all())
            )
            completionHandler()
        }
    }
}
