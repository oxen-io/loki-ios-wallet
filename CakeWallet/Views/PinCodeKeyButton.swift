import UIKit

final class PinCodeKeyButton: UIButton {
    override var isHighlighted: Bool {
        set { }
        get { return super.isHighlighted }
    }
    var pinCode: PinCodeKeyboardKey
    
    init(pinCode: PinCodeKeyboardKey) {
        self.pinCode = pinCode
        super.init(frame: .zero)
        
        if .del == pinCode {
            let image = UIImage(named: "delete_icon")?.withRenderingMode(.alwaysTemplate)
            setImage(image, for: .normal)
            tintColor = Theme.current.pinKeyReversed.text
        } else {
            setTitle(pinCode.string(), for: .normal)
        }
        
        configureView()
    }
    
    //    init(title: String) {
    //        super.init(frame: .zero)
    //
    //        configureView()
    //    }
    
    //    init(image: UIImage?) {
    //        super.init(frame: .zero)
    //        setImage(image, for: .normal)
    //        configureView()
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureView() {
        showsTouchWhenHighlighted = false
        contentHorizontalAlignment = .center
        setTitleColor(Theme.current.pinKey.text, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 25)
        backgroundColor = Theme.current.pinKey.background
        setShadow(color: Theme.current.pinKey.shadow)
    }
    
    func setShadow(color: UIColor) {
        layer.applySketchShadow(color: color, alpha: 0.35, x: 0, y: 8, blur: 8, spread: -11)
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        layer.cornerRadius = frame.size.width * 0.4
    }
}
