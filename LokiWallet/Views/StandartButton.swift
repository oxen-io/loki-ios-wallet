import UIKit

final class StandartButton: Button {
    override func configureView() {
        super.configureView()
        backgroundColor = Theme.current.tertiaryButton.background
        setTitleColor(Theme.current.tertiaryButton.text, for: .normal)
        layer.applySketchShadow(color: Theme.current.tertiaryButton.shadow, alpha: 0.34, x: 0, y: 10, blur: 20, spread: -10)
    }
}
