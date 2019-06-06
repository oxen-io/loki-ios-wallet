import UIKit

class SecondaryButton: Button {
    override func configureView() {
        super.configureView()
        backgroundColor = Theme.current.secondaryButton.background
        layer.applySketchShadow(color: Theme.current.secondaryButton.shadow, alpha: 0.34, x: 0, y: 10, blur: 20, spread: -10)
    }
}
