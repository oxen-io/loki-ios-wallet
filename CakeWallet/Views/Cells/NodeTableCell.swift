import UIKit

final class NodeTableCell: FlexCell {
    let addressLabel: UILabel
    let indicatorView: UIView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        indicatorView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 10)))
        addressLabel = UILabel(fontSize: 16)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        super.configureView()
        selectionStyle = .none
        
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = Theme.current.tableCell.background
        backgroundColor = .clear
        indicatorView.layer.masksToBounds = false
        indicatorView.layer.cornerRadius = 5
        
        let lighter = Theme.current.tableCell.background.lighterColor(percent: 0.7);
        contentView.layer.applySketchShadow(color: lighter , alpha: 0.25, x: 10, y: 5, blur: 13, spread: 3)
    }
    
    override func configureConstraints() {
        contentView.flex
            .margin(UIEdgeInsets(top: 7, left: 20, bottom: 0, right: 20))
            .padding(0, 20, 0, 20)
            .height(50)
            .direction(.row)
            .justifyContent(.spaceBetween)
            .alignSelf(.center)
            .define { flex in
                flex.addItem(addressLabel)
                flex.addItem(indicatorView).height(10).width(10).alignSelf(.center)
        }
    }
    
    func configure(address: String, isAble: Bool, isCurrent: Bool) {
        addressLabel.text = address
        addressLabel.flex.markDirty()
        indicatorView.backgroundColor = isAble ? .greenMalachite : .red
        contentView.backgroundColor = isCurrent ? .lokiBlack40 : Theme.current.tableCell.background
        addressLabel.textColor = Theme.current.tableCell.text
        contentView.flex.layout()
    }
}

final class LangTableCell: FlexCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override func configureView() {
        super.configureView()
        selectionStyle = .none
        contentView.layer.masksToBounds = false
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = Theme.current.tableCell.background
        backgroundColor = .clear
        
        let lighter = Theme.current.tableCell.background.lighterColor(percent: 0.7);
        contentView.layer.applySketchShadow(color: lighter , alpha: 0.25, x: 10, y: 5, blur: 13, spread: 3)
        textLabel?.font = UIFont.systemFont(ofSize: 14) //fixme
    }
    
    override func configureConstraints() {
        guard let textLabel = self.textLabel else {
            return
        }
        
        contentView.flex
            .margin(UIEdgeInsets(top: 7, left: 20, bottom: 0, right: 20))
            .padding(0, 20, 0, 20)
            .height(50)
            .direction(.row)
            .justifyContent(.spaceBetween)
            .alignSelf(.center)
            .define { flex in
                flex.addItem(textLabel)
        }
    }
    
    func configure(lang: Languages, isCurrent: Bool) {
        textLabel?.text = lang.formatted()
        textLabel?.flex.markDirty()
        contentView.backgroundColor = isCurrent ? .lokiBlack40 : Theme.current.tableCell.background
        textLabel?.textColor = Theme.current.tableCell.text
        contentView.flex.layout()
    }
}
