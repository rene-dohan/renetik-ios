//
// Created by Rene Dohan on 12/23/19.
//

import Foundation
import UIKit
import RenetikObjc

public extension UIView {

    @discardableResult
    func from(left: CGFloat) -> Self {
        self.left = left;
        fixedLeft()
        return self
    }

    @discardableResult
    func from(_ view: UIView, left: CGFloat) -> Self { from(left: view.right + left) }

    @discardableResult
    func fromPrevious(left: CGFloat) -> Self {
        superview.isNil { fatalError("View expected to have previous sibling in superview") }.elseDo { superview in
            superview.subviews.previous(of: self).notNil { previous in from(previous, left: left) }
                    .elseDo { from(left: 0) }
        }
        return self
    }

    @discardableResult
    func from(top: CGFloat) -> Self {
        self.top = top;
        fixedTop()
        return self
    }

    @discardableResult
    func from(_ view: UIView, top: CGFloat) -> Self { from(top: view.bottom + top) }

    @discardableResult
    func fromPrevious(top: CGFloat) -> Self {
        superview.isNil { fatalError("View expected to have previous sibling in superview") }.elseDo { superview in
            superview.subviews.previous(of: self).notNil { previous in from(previous, top: top) }
                    .elseDo { from(top: 0) }
        }
        return self
    }

    @discardableResult
    func from(right: CGFloat) -> Self {
        self.fromRight = right;
        fixedRight()
        return self
    }

    @discardableResult
    func from(_ view: UIView, right: CGFloat) -> Self { from(right: view.leftFromRight + right) }

    @discardableResult
    func from(bottom: CGFloat) -> Self {
        self.fromBottom = bottom;
        fixedBottom()
        return self
    }

    @discardableResult
    func from(_ view: UIView, bottom: CGFloat) -> Self { from(bottom: view.topFromBottom + bottom) }

    @discardableResult
    func from(bottomRight: CGFloat) -> Self {
        from(bottom: bottomRight)
        from(right: bottomRight)
        return self
    }

    @discardableResult
    func from(left: CGFloat, top: CGFloat) -> Self {
        from(left: left)
        from(top: top)
        return self
    }

    @discardableResult
    func from(topLeft: CGFloat) -> Self {
        from(top: topLeft)
        from(left: topLeft)
        return self
    }

    @discardableResult
    func from(topRight: CGFloat) -> Self {
        from(top: topRight)
        from(right: topRight)
        return self
    }

    @discardableResult
    func from(left: CGFloat, bottom: CGFloat) -> Self {
        from(left: left)
        from(bottom: bottom)
        return self
    }

    @discardableResult
    func from(right: CGFloat, top: CGFloat) -> Self {
        from(right: right)
        from(top: top)
        return self
    }

    @discardableResult
    func from(left: CGFloat, top: CGFloat, width: CGFloat, height: CGFloat) -> Self {
        from(left: left, top: top)
        self.width(width, height: height)
        return self
    }

    @discardableResult
    func matchParentWidth(margin: CGFloat = 0) -> Self {
        from(left: margin).width(fromRight: margin).flexibleWidth()
    }

    @discardableResult
    func matchParentHeight(margin: CGFloat = 0) -> Self {
        from(top: margin).height(fromBottom: margin).flexibleHeight()
    }

    @discardableResult
    func matchParent(margin: CGFloat = 0) -> Self {
        matchParentWidth(margin: margin).matchParentHeight(margin: margin)
    }

    @discardableResult
    func matchParent(horizontalMargin: CGFloat = 0, verticalMargin: CGFloat = 0) -> Self {
        matchParentWidth(margin: horizontalMargin).matchParentHeight(margin: verticalMargin)
    }

    @discardableResult
    func width(fromRight: CGFloat, flexible: Bool = false) -> Self {
        assert(superview.notNil, "Needs to have superview")
        let right = superview!.width - fromRight
        widthBy(right: CSMath.unsign(right))
        if flexible {
            fixedLeft()
            flexibleWidth()
        }
        return self
    }

    @discardableResult
    func width(from view: UIView, right: CGFloat, flexible: Bool = false) -> Self {
        width(fromRight: view.leftFromRight + right, flexible: flexible)
    }

    @discardableResult
    func width(fromLeft: CGFloat, flexible: Bool = false) -> Self {
        width = CSMath.unsign(right - fromLeft)
        if flexible {
            fixedRight()
            flexibleWidth()
        }
        from(left: fromLeft)
        return self
    }

    @discardableResult
    func height(fromBottom: CGFloat, flexible: Bool = false) -> Self {
        assert(superview.notNil, "Needs to have superview")
        let bottom = superview!.height - fromBottom
        heightBy(bottom: CSMath.unsign(bottom))
        if flexible {
            fixedTop()
            flexibleHeight()
        }
        return self
    }

    @discardableResult
    func height(from view: UIView, bottom: CGFloat, flexible: Bool = false) -> Self {
        height(fromBottom: view.topFromBottom + bottom)
    }

    @discardableResult
    func height(fromTop: CGFloat, flexible: Bool = false) -> Self {
        height = CSMath.unsign(bottom - fromTop)
        from(top: fromTop)
        if flexible {
            fixedBottom()
            flexibleHeight()
        }
        return self
    }

    @discardableResult
    func widthBy(right: CGFloat) -> Self {
        width = CSMath.unsign(right - left)
        fixedRight()
        return self
    }

    @discardableResult
    func heightBy(bottom: CGFloat) -> Self {
        height = CSMath.unsign(bottom - top)
        fixedBottom()
        return self
    }

    @discardableResult
    func fixedBottom(height: CGFloat) -> Self {
        let bottom = fromBottom
        self.height = height
        fromBottom = bottom
        fixedBottom()
        return self
    }

    @discardableResult
    func fixedRight(width: CGFloat) -> Self {
        let right = fromRight
        self.width = width
        fromRight = right
        fixedRight()
        return self
    }
}