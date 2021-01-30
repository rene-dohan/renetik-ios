//
// Created by Rene Dohan on 1/25/20.
//

import UIKit
import RenetikObjc
import BlocksKit

public struct CSTextViewClearButtonAppearance {
    fileprivate let titleColor: UIColor?

    public init(titleColor: UIColor) {
        self.titleColor = titleColor
    }
}

public extension UITextView {

    class func construct(_ text: String) -> Self { construct().text(text) }

    func delegate(_ delegate: UITextViewDelegate) -> Self { self.delegate = delegate; return self }

    func scrollToCursorPosition() -> Self {
        later(seconds: 0.1) {
            if let start = self.selectedTextRange?.start {
                self.scrollRectToVisible(self.caretRect(for: start), animated: true)
            }
        }
        return self
    }

    @discardableResult
    func detectData(_ types: UIDataDetectorTypes = [.all]) -> Self {
        dataDetectorTypes = types
        if types.isEmpty { isSelectable = true }
        return self
    }

    @discardableResult
    func detect(data: UIDataDetectorTypes) -> Self { detectData(data) }

    @discardableResult
    func detect(_ data: UIDataDetectorTypes) -> Self { detectData(data) }

    @discardableResult
    override public func onTap(_ block: @escaping Func) -> Self {
        self.isEditable = false
        self.isSelectable = false
        super.onTap(block)
        return self
    }

//    TODO: This is wrong and TextView should be wrapped to view with clear button instead
//    @discardableResult
//    func withClear(_ parent: CSViewController, _ appearance: CSTextViewClearButtonAppearance? = nil) -> Self {
//        let button = UIButton(type: .system).construct().text("X").fontStyle(.body)
//                .visible(if: self.text.isSet).onClick { self.text = "" }
//        add(button).from(left: 5).resizeToFit().centeredHorizontal()
//
//        onTextChange(in: parent) { _ in button.visible(if: self.text.isSet) }
//        appearance?.titleColor?.then { color in button.textColor(color) }
//        return self
//    }

    @discardableResult
    public func text(_ value: String?) -> Self { invoke { self.text = value } }

    @discardableResult
    func onTextChange(in parent: CSViewController, _ function: @escaping (UITextView) -> Void) -> Self {
        parent.observe(notification: UITextView.textDidChangeNotification) { notification in
            if (notification.object as! NSObject) === self { function(self) }
        }
        return self
    }

    @discardableResult
    func heightToFit(lines numberOfLines: Int) -> Self {
        let currentWidth = width; let currentText = text; var linesText = "line"
        for i in 0..<numberOfLines - 1 {
            linesText += "\n line"
        }
        text(linesText).resizeToFit().text(currentText).width(currentWidth)
        return self
    }

    @discardableResult
    func asLabel() -> Self {
        textContainerInset = .zero
        contentInset = .zero
        isEditable = false
        isScrollEnabled = false
        backgroundColor = .clear
        contentInsetAdjustmentBehavior = .never
        textContainer.lineFragmentPadding = 0
        layoutManager.usesFontLeading = false
        return self
    }

    @discardableResult
    func text(align: NSTextAlignment) -> Self { invoke { self.textAlignment = align } }

    @discardableResult
    func font(_ font: UIFont) -> Self { invoke { self.font = font } }

    @discardableResult
    func font(size: CGFloat) -> Self { invoke { self.fontSize = size } }

    var fontSize: CGFloat {
        get { font!.fontDescriptor.pointSize }
        set { font = font!.withSize(newValue) }
    }

    @discardableResult
    func font(style: UIFont.TextStyle) -> Self { invoke { self.fontStyle = style } }

    var fontStyle: UIFont.TextStyle {
        get { font!.fontDescriptor.object(forKey: .textStyle) as! UIFont.TextStyle }
        set { font = UIFont.preferredFont(forTextStyle: newValue) }
    }

    @discardableResult
    public func text(prepend: String) -> Self { self.text("\(prepend)\(text ?? "")") }

    @discardableResult
    public func text(replace: String, with: String) -> Self { self.text(text.replace(all: replace, with: with)) }
}