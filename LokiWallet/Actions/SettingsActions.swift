import LokiWalletLib
import LokiWalletCore

public enum SettingsActions: HandlableAction {
    case setPin(pin: String, length: PinLength)
    case changeAutoSwitchNodes(isOn: Bool)
    case changeBiometricAuthentication(isAllowed: Bool, handler: (Bool) -> Void)
    case changeTransactionPriority(TransactionPriority)
    case changeCurrentFiat(currency: FiatCurrency)
    case changeCurrentNode(to: NodeDescription)
}
