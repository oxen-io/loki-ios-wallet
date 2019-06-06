import UIKit

final class PrimaryButton: Button {
    override func configureView() {
        super.configureView()
        layer.applySketchShadow(color: Theme.current.primaryButton.shadow, alpha: 0.34, x: 0, y: 10, blur: 20, spread: -10)
    }
}
