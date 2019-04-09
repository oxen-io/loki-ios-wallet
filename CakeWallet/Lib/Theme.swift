import UIKit

enum Theme: String {
    case def, night
    
    static var current: Theme {
        if
            let rawValue = UserDefaults.standard.string(forKey: Configurations.DefaultsKeys.currentTheme),
            let theme = Theme(rawValue: rawValue) {
            return theme
        }
        
        return .def
    }
    
    var bar: BarColorScheme {
        let darkened = UIColor.lokiBlack80.darkerColor(percent: 0.3)
        return BarColorScheme(barTint: darkened, tint: .lokiGreen, text: .white)
    }
    
    var container: ContainerColorScheme {
        switch self {
        case .def:
            return ContainerColorScheme(background: .lokiBlack80)
        case .night:
            return ContainerColorScheme(background: .wildDarkBlue)
        }
    }
    
    var primaryButton: ButtonColorScheme {
        switch self {
        case .def:
            return ButtonColorScheme(background: .lokiGreen, text: .white, shadow: .lokiGreenDark)
        case .night:
            return ButtonColorScheme(background: .whiteSmoke, text: .lokiGreen, shadow: .lokiGreenDark)
        }
    }
    
    var secondaryButton: ButtonColorScheme {
        switch self {
        case .def:
            return ButtonColorScheme(background: .wildDarkBlue, text: .white, shadow: .wildDarkBlueShadow)
        case .night:
            return ButtonColorScheme(background: .whiteSmoke, text: .wildDarkBlue, shadow: .lokiGreenDark)
        }
    }
    
    var tertiaryButton: ButtonColorScheme {
        return ButtonColorScheme(background: .lokiBlack60, text: .white, shadow: .lokiBlack50)
    }
    
    var pin: PinIndicatorScheme {
        return PinIndicatorScheme(background: .lokiBlack40, value: .lokiGreen, shadow: .lokiBlack40)
    }
    
    var pinKey: PinKeyScheme {
        return PinKeyScheme(background: .wildDarkBlue, text: .white, shadow: .wildDarkBlueShadow)
    }
    
    var pinKeyReversed: PinKeyScheme {
        return PinKeyScheme(background: .lokiBlack40, text: .white, shadow: .lokiBlack40)
    }
    
    var card: CardScheme {
        return CardScheme(background: .lokiBlack60, shadow: .lokiBlack90)
    }
    
    var text: UIColor {
        switch self {
        case .def:
            return .white
        case .night:
            return .whiteSmoke
        }
    }
    
    var lightText: UIColor {
        switch self {
        case .def:
            return .wildDarkBlue
        case .night:
            return .whiteSmoke
        }
    }
    
    var progressBar: ProgressBarScheme {
        return ProgressBarScheme(value: .greenMalachite, background: .lokiBlack40)
    }
    
    var tableCell: CellColorScheme {
        let lighter = UIColor.lokiBlack60.lighterColor(percent: 0.3)
        return CellColorScheme(background: .lokiBlack60, selected: lighter, text: .white, tint: .lokiGreen)
    }
    
    var labelField: LabelFieldScheme {
        return LabelFieldScheme(textColor: .white, titleColor: .wildDarkBlue, selectedTitleColor: .white)
    }
}
