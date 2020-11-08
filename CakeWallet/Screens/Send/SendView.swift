import UIKit
import FlexLayout

final class SendView: BaseScrollFlexViewWithBottomSection {
    let cardView: CardView
    let addressView: AddressView
    let cryptoAmountTextField: FloatingLabelTextField
    let currenciesRowViev: UIView
    let currenciesContainer: UIView
    let estimatedFeeTitleLabel: UILabel
    let estimatedFeeValueLabel: UILabel
    let estimatedFeeContriner: UIView
    let estimatedDescriptionLabel: UILabel
    let sendButton: UIButton
    let walletContainer: UIView
    let walletNameLabel: UILabel
    let cryptoAmountValueLabel: UILabel
    let cryptoAmountTitleLabel: UILabel
    let sendAllButton: Button
    let cryptoAmonutContainer: UIView
    
    required init() {
        cardView = CardView()
        addressView = AddressView()
        cryptoAmountTextField = FloatingLabelTextField(placeholder: "CRT")
        currenciesRowViev = UIView()
        currenciesContainer = UIView()
        estimatedFeeTitleLabel = UILabel(fontSize: 14)
        estimatedFeeValueLabel = UILabel(fontSize: 14)
        estimatedFeeContriner = UIView()
        estimatedDescriptionLabel = UILabel.withLightText(fontSize: 12)
        sendButton = PrimaryButton(title: NSLocalizedString("send", comment: ""))
        walletContainer = CardView()
        walletNameLabel = UILabel.withLightText(fontSize: 14)
        cryptoAmountValueLabel = UILabel(fontSize: 24)
        cryptoAmountTitleLabel = UILabel(fontSize: 12)
        sendAllButton = SecondaryButton(title: NSLocalizedString("all", comment: ""))
        cryptoAmonutContainer = UIView()
        super.init()
    }
    
    override func configureView() {
        super.configureView()
//        isOpaque = true
//        backgroundColor = .clear
        addressView.textView.delegate = self
//        rootFlexContainer.backgroundColor = .clear
        estimatedFeeValueLabel.numberOfLines = 0
        estimatedFeeValueLabel.textAlignment = .right
        cryptoAmountTitleLabel.textColor = .lokiGreen
        cryptoAmountTitleLabel.textAlignment = .right
        cryptoAmountValueLabel.textAlignment = .right
        cryptoAmountTextField.keyboardType = .decimalPad
    }
    
    override func configureConstraints() {
        cryptoAmonutContainer.flex.define { flex in
            flex.addItem(cryptoAmountTitleLabel)
            flex.addItem(cryptoAmountValueLabel)
        }
        
        walletContainer.flex.direction(.row).padding(20).justifyContent(.spaceBetween).define { flex in
            flex.addItem(walletNameLabel).height(20)
            flex.addItem(cryptoAmonutContainer)
        }
        
        currenciesContainer.flex.direction(.row).justifyContent(.spaceBetween).define { flex in
            flex.addItem(cryptoAmountTextField).grow(1)
            flex.addItem(sendAllButton).height(40).marginLeft(10)
        }
        
        estimatedFeeContriner.flex.direction(.row).justifyContent(.spaceBetween).alignItems(.start).define { flex in
            flex.addItem(estimatedFeeTitleLabel)
            flex.addItem(estimatedFeeValueLabel)
        }
        
        cardView.flex.alignItems(.center).padding(20, 20, 30, 20).define { flex in
            flex.addItem(addressView).width(100%)
            flex.addItem(currenciesContainer).marginTop(20).width(100%).height(50)
            flex.addItem(estimatedFeeContriner).marginTop(20).width(100%)
            flex.addItem(estimatedDescriptionLabel).marginTop(20).width(100%)
        }
        
        rootFlexContainer.flex.padding(20, 0, 20, 0).define { flex in
            flex.addItem(walletContainer)
            flex.addItem(cardView).marginTop(20)
        }
        
        bottomSectionView.flex.define { flex in
            flex.addItem(sendButton).height(56)
        }
    }
}
