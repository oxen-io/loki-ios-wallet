import Foundation

public enum WalletType {
    case loki, bitcoin
    
    public var currency: CryptoCurrency {
        switch self {
        case .loki:
            return .loki
        case .bitcoin:
            return .bitcoin
        }
    }
    
    public func string() -> String {
        switch self {
        case .bitcoin:
            return "Bitcoin"
        case .loki:
            return "Loki"
        }
    }
}
