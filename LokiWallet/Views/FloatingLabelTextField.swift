import UIKit
import SkyFloatingLabelTextField

final class FloatingLabelTextField: SkyFloatingLabelTextField {
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    private let padding: UIEdgeInsets
    
    convenience init(placeholder: String, isOptional: Bool = false) {
        self.init(placeholder: placeholder, title: placeholder, isOptional: isOptional)
    }
    
    init(placeholder: String, title: String, isOptional: Bool = false, padding: UIEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)) {
        self.padding = padding
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.title = title
        configureView()
        
        if isOptional {
            addOptional()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        super.configureView()
        font = UIFont.systemFont(ofSize: 14)
        
        placeholderColor = Theme.current.labelField.titleColor
        lineColor = Theme.current.labelField.titleColor
        lineHeight = 2
        
        titleColor = Theme.current.labelField.titleColor
        textColor = Theme.current.labelField.textColor
        tintColor = Theme.current.labelField.textColor
        
        selectedTitleColor = Theme.current.labelField.selectedTitleColor
        selectedLineColor = Theme.current.labelField.selectedTitleColor
    }
    
    private func addOptional() {
        let label = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 15)))
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = Theme.current.labelField.titleColor
        label.text = NSLocalizedString("optional", comment: "")
        rightView = label
        rightViewMode = .unlessEditing
    }
}
