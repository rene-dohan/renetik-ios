//
// Created by Rene Dohan on 1/29/20.
//

import UIKit
import RenetikObjc

public extension UIView {

    var width: CGFloat {
        get { frame.size.width }
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    @discardableResult
    func width(_ value: CGFloat) -> Self { invoke { self.width = value } }

    @discardableResult
    func width(as view: UIView) -> Self { width(view.width) }

    var height: CGFloat {
        get { frame.size.height }
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    @discardableResult
    func height(_ value: CGFloat) -> Self { self.height = value; return self }

    @discardableResult
    func heightAsPrevious() -> Self {
        assert(superview.notNil, "Needs to have superview")
        let previous = superview!.findPrevious(of: self)
        assert(previous.notNil, "Needs to have previous visible")
        height(previous!.height)
        return self
    }

    @discardableResult
    func widthAsHeight() -> Self { invoke { width = height } }

    @discardableResult
    func heightAsWidth() -> Self { invoke { height = width } }

    @discardableResult
    func defaultSize() -> Self { width(UIScreen.width, height: UIScreen.height) }

    public var availableHeight: CGFloat { height - navigation.navigationBar.bottom }

    @discardableResult
    public func heightByLastSubview(padding: CGFloat = 0, minimum: CGFloat = 0) -> Self {
        let lastSubviewBottom = (content?.subviews.last?.bottom ?? subviews.last?.bottom)
        return height(lastSubviewBottom?.get { $0 + padding } ?? minimum)
    }

    @discardableResult
    public func heightByLastVisibleSubview(padding: CGFloat = 0, minimum: CGFloat = 0) -> Self {
        let lastSubviewBottom = (content?.lastVisibleSubview?.bottom ?? lastVisibleSubview?.bottom)
        return height(lastSubviewBottom?.get { $0 + padding } ?? minimum)
    }

    @discardableResult
    func size(_ size: CGFloat) -> Self { width(size, height: size) }

    @discardableResult
    func size(_ size: CGSize) -> Self { invoke { self.size = size } }

    @discardableResult
    func size(_ width: CGFloat, _ height: CGFloat) -> Self { self.width(width, height: height) }

    var size: CGSize {
        get { frame.size }
        set(size) { frame = CGRect(x: frame.x, y: frame.y, width: size.width, height: size.height) }
    }

    @discardableResult
    func resizeToFitSubviews() -> Self {
        var x = width, y = height, rect = CGRect.zero
        subviews.forEach { subview in
            rect = rect.union(subview.frame)
            x = subview.frame.x < x ? subview.frame.x : x
            y = subview.frame.y < y ? subview.frame.y : y
        }
        var masks = saveAndClearSubviewsAutoresizingMasks()
        subviews.each { $0.frame = $0.frame.offsetBy(dx: -x, dy: -y) }
        rect.size.width -= x; rect.size.height -= y
        frame.size = rect.size
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    func sizeThatFitsSubviews() -> CGSize {
        var rect = CGRect.zero
        subviews.each { view in rect = rect.union(view.frame) }
        return rect.size
    }

    @discardableResult
    func frame(_ rect: CGRect) -> Self { invoke { self.frame = rect } }

    @discardableResult
    func width(_ width: CGFloat, height: CGFloat) -> Self {
        size(CGSize(width: width, height: height))
        return self
    }

    @discardableResult
    func add(left value: CGFloat) -> Self {
        left -= value
        if left < 0 { left = 0 }
        width += value
        return self
    }

    @discardableResult
    func add(top value: CGFloat) -> Self {
        top -= value
        if top < 0 { top = 0 }
        height += value
        return self
    }

    @discardableResult
    func add(right value: CGFloat) -> Self {
        width += value
        return self
    }

    @discardableResult
    func add(bottom value: CGFloat) -> Self { invoke { self.height += value } }

    @discardableResult
    func add(width value: CGFloat) -> Self { invoke { self.width += value } }

    @discardableResult
    func add(height value: CGFloat) -> Self { invoke { self.height += value } }

    @discardableResult
    func add(width: CGFloat, height: CGFloat) -> Self {
        invoke { self.width += width; self.height += height }
    }

    @discardableResult
    func remove(width value: CGFloat) -> Self { invoke { self.width -= value } }

    @discardableResult
    func remove(height value: CGFloat) -> Self { invoke { self.height -= value } }

    @discardableResult
    func resize(padding: CGFloat) -> Self {
        if isFixedLeft() {
            add(right: padding)
        } else {
            add(left: padding)
        }
        if isFixedTop() {
            add(bottom: padding)
        } else {
            add(top: padding)
        }
        if isFixedRight() {
            add(left: padding)
        } else {
            add(right: padding)
        }
        if isFixedBottom() {
            add(top: padding)
        } else {
            add(bottom: padding)
        }
        return self
    }

    @discardableResult
    @objc open func resizeToFit() -> Self {
        if content.notNil {
            content!.resizeToFit()
            let masks = saveAndClearSubviewsAutoresizingMasks()
            size(content!.size)
            restoreSubviewsAutoresizing(masks: masks)
        } else {
            size(sizeThatFits(.zero))
        }
        return self
    }

    @discardableResult
    @objc open func resizeToFit(padding: CGFloat = 0) -> Self {
        resizeToFit().resize(padding: padding)
    }

    @discardableResult
    @objc open func widthToFit() -> Self { width(widthThatFits()) }

    @discardableResult
    @objc open func widthToFitSubviews() -> Self { width(sizeThatFitsSubviews().width) }

//     heightThatFitsSubviews cannot be used because this needs to shift subviews too
    @discardableResult
    @objc open func heightToFit() -> Self {
        if content.notNil {
            content!.heightToFit()
            let masks = saveAndClearSubviewsAutoresizingMasks()
            height(content!.height)
            restoreSubviewsAutoresizing(masks: masks)
        } else {
            height(heightThatFits())
        }
        return self
    }

    @discardableResult
    @objc open func heightThatFitsSubviews() -> CGFloat {
        var y = height
        var rect = CGRect.zero
        subviews.forEach { subview in
            rect = rect.union(subview.frame)
            y = subview.frame.y < y ? subview.frame.y : y
        }
        rect.height -= y
        return rect.height
    }

    @discardableResult
    @objc open func heightToFitSubviews() -> Self {
        var y = height
        var rect = CGRect.zero
        for subview in subviews {
            if subview.isHidden { continue }
            rect = rect.union(subview.frame)
            y = subview.frame.y < y ? subview.frame.y : y
        }
        if rect.isEmpty { height(rect.height); return self }
        var masks = saveAndClearSubviewsAutoresizingMasks()
        subviews.each { $0.frame = $0.frame.offsetBy(dx: 0, dy: -y) }
        rect.height -= y
        height(rect.height)
        restoreSubviewsAutoresizing(masks: masks)
        return self
    }

    func saveAndClearSubviewsAutoresizingMasks() -> [UIView.AutoresizingMask] {
        var masks = [UIView.AutoresizingMask]()
        for subview in subviews {
            masks.add(subview.autoresizingMask)
            subview.autoresizingMask = []
        }
        return masks
    }

    func restoreSubviewsAutoresizing(masks: [UIView.AutoresizingMask]) {
        for (index, subview) in subviews.enumerated() {
            subview.autoresizingMask = masks[index]
        }
    }

    @objc open func widthThatFits() -> CGFloat {
        assert(height > 0, "Height has to be set to calculate width")
        return sizeThatFits(CGSize(width: width, height: .infinity)).height
    }

    @objc open func heightThatFits() -> CGFloat {
        assert(width > 0, "Width has to be set to calculate height")
        return sizeThatFits(CGSize(width: width, height: .infinity)).height
    }

    func hideByHeight(if condition: Bool) -> Self { invoke { if condition { self.height = 0 } } }
}