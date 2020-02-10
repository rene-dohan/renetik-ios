//
// Created by Rene on 2018-11-22.
// Copyright (c) 2018 Renetik Software. All rights reserved.
//

import UIKit
import RenetikObjc
import BlocksKit

public extension UIView {

    @discardableResult
    func visible(if condition: Bool) -> Self {
        self.visible = condition
        return self
    }

    func invoke(animated: Bool, duration: TimeInterval = 0.3, operation: @escaping () -> Void) {
        if animated { UIView.animate(withDuration: duration, animations: operation) } else { operation() }
    }

    func asBottomSeparator(_ height: CGFloat = 0.5) -> Self {
        self.height(height).from(bottom: 0).matchParentWidth()
                .flexibleTop().fixedBottom().background(.darkGray)
    }

    @discardableResult
    @objc func onClick(_ block: @escaping () -> Void) -> Self {
        onTap { block() }
        return self
    }

    @discardableResult
    @objc func onTap(_ block: @escaping () -> Void) -> Self {
        isUserInteractionEnabled = true
        bk_(whenTapped: { block() })
        return self
    }
}