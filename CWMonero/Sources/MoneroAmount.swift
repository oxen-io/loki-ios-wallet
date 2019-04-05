import CakeWalletLib

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}

public struct MoneroAmount: Amount {
    public let currency: Currency = CryptoCurrency.loki
    public let value: UInt64
    private let numberFormatter: NumberFormatter = {
       let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = true
        return formatter
    }()
    
    public init(value: UInt64) {
        self.value = value
    }
    
    public init(from string: String) {
        var _string = string
        let splitResult = string.split(separator: ".")
        
        if splitResult.count > 1 {
            let afterDot = splitResult[1]

            if afterDot.count > 12 {
                _string = "0." + String(String(afterDot)[0..<13])
            } else {
                _string = string
            }
        }
        
        value = MoneroAmountParser.amount(from: _string)
    }
    
    public func formatted() -> String {
        return formatted(pretty: false)
    }
    
    public func formatted(pretty: Bool) -> String {
        guard
            let formattedValue = MoneroAmountParser.formatValue(value),
            let _value = Double(formattedValue),
            _value != 0 else {
                return "0.00"
        }

        if pretty,
            let formatted = numberFormatter.string(from: _value as NSNumber) {
            return formatted
        }
        
        return String(_value)
    }
}
