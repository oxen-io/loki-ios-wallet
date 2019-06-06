import UIKit
import LokiWalletLib

final class RestoreViewController: BaseViewController<RecoverView> {
    weak var signUpFlow: SignUpFlow?
    let type: WalletType
    
    init(signUpFlow: SignUpFlow, type: WalletType = .loki) {
        self.signUpFlow = signUpFlow
        self.type = type
        super.init()
    }
    
    override func configureBinds() {
        title = NSLocalizedString("restore", comment: "")
        contentView.titleLabel.text = NSLocalizedString("restore_your_wallet", comment: "")
        contentView.descriptionLabel.text = NSLocalizedString("restore_selection_text", comment: "")
        contentView.fromKeysButton.addTarget(self, action: #selector(fromKeys), for: .touchUpInside)
        contentView.fromSeedButton.addTarget(self, action: #selector(fromSeed), for: .touchUpInside)
        switch type {
        case .loki:
            contentView.cryptoIconImageView.image = UIImage(named: "loki_logo")
        case .bitcoin:
            break
        }
    }
    
    @objc
    private func fromSeed() {
        signUpFlow?.change(route: .restoreFromSeed)
    }
    
    @objc
    private func fromKeys() {
        signUpFlow?.change(route: .restoreFromKeys)
    }
}
