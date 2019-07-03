//
//  CSHideNavigationBarByScrollingController.swift
//  Renetik
//
//  Created by Rene Dohan on 7/3/19.
//

import RenetikObjc

@objc public class CSHideNavigationByScrollController: CSChildViewLessController {
    var scrollView: UIScrollView!
    var navigationBarHidden = false

    @discardableResult
    @objc public func construct(
        _ parent: CSMainController, _ scrollView: UIScrollView) -> Self {
        super.construct(parent)
        self.scrollView = scrollView
        return self
    }

    public override func onViewVisibilityChanged(_ visible: Bool) {
        navigationBarHidden = navigation.navigationBar.isHidden
    }

    public override func onViewDismissing() {
        super.onViewDismissing()
        showNavigationBar()
    }
	
	public override func onViewWillTransition(toSizeCompletion size: CGSize, _ context: UIViewControllerTransitionCoordinatorContext) {
		if navigationBarHidden {
			UIView.animate(0.3) {
				navigation.navigationBar.bottom = UIApplication.statusBarHeight()
				navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
			}
		}
	}
	
	public override func onViewWillTransition(to
		size: CGSize, _ coordinator: UIViewControllerTransitionCoordinator) {
		
	}

    @objc public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isAtTop {
            showNavigationBar()
        } else if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0 {
            hideNavigationBar()
        } else {
            showNavigationBar()
        }
    }

    @objc public func hideNavigationBar() {
        if navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.bottom = UIApplication.statusBarHeight()
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fadeOut(0.7)
        navigationBarHidden = true
    }

    @objc public func showNavigationBar() {
        if !navigationBarHidden { return }
        UIView.animate(0.5) {
            navigation.navigationBar.top = UIApplication.shared.statusBarFrame.height
            navigation.last!.view.top(toHeight: navigation.navigationBar.bottom)
        }
        navigation.navigationBar.fade(in: 0.7)
        navigationBarHidden = false
    }
}
