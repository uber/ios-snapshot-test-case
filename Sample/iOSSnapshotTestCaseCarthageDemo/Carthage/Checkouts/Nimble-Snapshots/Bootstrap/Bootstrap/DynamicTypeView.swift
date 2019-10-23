import Foundation
import UIKit

public final class DynamicTypeView: UIView {
    public let label: UILabel

    override public init(frame: CGRect) {
        label = UILabel()
        super.init(frame: frame)

        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false

        label.font = .preferredFont(forTextStyle: .body)
        label.text = "Example"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        addSubview(label)

        setNeedsUpdateConstraints()

        #if swift(>=4.2)
        let notName = UIContentSizeCategory.didChangeNotification
        #else
        let notName = NSNotification.Name.UIContentSizeCategoryDidChange
        #endif

        NotificationCenter.default.addObserver(self, selector: #selector(updateFonts),
                                               name: notName,
                                               object: nil)
    }

    private var createdConstraints = false
    override public func updateConstraints() {
        if !createdConstraints {
            label.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        }

        super.updateConstraints()
    }

    @objc
    func updateFonts(_ notification: Notification) {
        #if swift(>=4.2)
        let newValueKey = UIContentSizeCategory.newValueUserInfoKey
        #else
        let newValueKey = UIContentSizeCategoryNewValueKey
        #endif

        guard let category = notification.userInfo?[newValueKey] as? String else {
            return
        }

        label.font = .preferredFont(forTextStyle: .body)
        label.text = category.replacingOccurrences(of: "UICTContentSizeCategory", with: "")
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
