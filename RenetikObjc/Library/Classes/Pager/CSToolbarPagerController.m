////
//// Created by Rene Dohan on 26/10/15.
//// Copyright (c) 2015 creative_studio. All rights reserved.
////
//
//@import ChameleonFramework;
//
//#import "CSLang.h"
//#import "NSArray+CSExtension.h"
//#import "NSMutableArray+CSExtension.h"
//#import "UIView+CSExtension.h"
//#import "UIViewController+CSExtension.h"
//#import "UIScrollView+CSExtension.h"
//#import "UINavigationController+CSExtension.h"
//#import "CSToolbarPagerController.h"
//#import "CSToolbarPage.h"
//#import "UIView+CSPosition.h"
//#import "UIView+CSDimension.h"
//#import "UIView+CSContainer.h"
//#import "UIView+CSLayout.h"
//#import "UIBarButtonItem+CSExtension.h"
//#import "UIColor+CSExtension.h"
//
//@implementation CSToolbarPagerController {
//    CSMainController *_parentController;
//    UIScrollView *_scrollView;
//    UIView *_contentView;
//}
//
//+ (id)appearance {
//    return [MZAppearance appearanceForClass :[self class]];
//}
//
//- (instancetype)construct :(CSMainController *)parent
//                          :(NSArray<CSMainController <CSToolbarPage> *> *)controllers
//                          :(UIToolbar *)toolbar :(UIScrollView *)scrollView {
//    [super construct :parent];
//    _parentController = parent;
//    _controllers = controllers;
//    _toolBar = toolbar;
//    _scrollView = scrollView;
//    _scrollView.delegate = self;
//    _scrollView.pagingEnabled = YES;
//    _scrollView.scrollsToTop = NO;
//    _scrollView.directionalLockEnabled = YES;
//    _contentView = [UIView withColor :UIColor.clearColor frame :_scrollView.bounds];
//    [[_scrollView add :_contentView] matchParent];
//    return self;
//}
//
//- (void)onViewDidLoad{
//	super.onViewDidLoad;
//	 [self.class.appearance applyInvocationTo :self];
//}
//
//- (void)onUpdateLayout {
//	super.onUpdateLayout;
//	if (_controllers)
//		invoke(^{
//			[self reload :_controllers];
//		});
//}
//
//- (void)scrollViewDidEndDecelerating :(UIScrollView *)view {
//    [self onPageChange :(NSUInteger)lround(_scrollView.contentOffset.x / (_scrollView.contentSize.width / _controllers.count))];
//    [self showSelectEffect];
//}
//
//- (void)reload :(nonnull NSArray<CSMainController <CSToolbarPage> *> *)controllers {
//    if (controllers.empty) return;
//    for (UIViewController *controller in _controllers) [_parentController dismissChildController :controller];
//    _controllers = controllers;
//    [self loadBar];
//    _scrollView.contentSize = CGSizeMake(_contentView.width = _controllers.count * _scrollView.width, 0);
//    for (CSMainController *controller in _controllers) {
//        [_contentView horizontalLineAdd :controller.view];
//        [_parentController showChildController :controller :_contentView];
//        [[controller.view size :_scrollView.size] setNeedsUpdateConstraints];
//    }
//    [self selectButton :_currentIndex];
//}
//
//- (void)loadBar {
//    NSMutableArray<UIBarButtonItem *> *items = NSMutableArray.new;
//    [items put :[UIBarButtonItem createWithItem :UIBarButtonSystemItemFlexibleSpace :nil :nil]]
//    .tag = -1;
//    for (uint pageIndex = 0; pageIndex < _controllers.count; ++pageIndex) {
//        UIBarButtonItem *item = [_controllers[pageIndex] tabItem];
//        [item setTarget :self forAction :@selector(onItemClick:)];
//        item.tag = pageIndex;
//        item.tintColor = self.normalItemColor;
//        [items put :item];
//        [items put :[UIBarButtonItem createWithItem :UIBarButtonSystemItemFlexibleSpace :nil :nil]]
//        .tag = -1;
//    }
//    [_toolBar setItems :items];
//}
//
//- (void)onItemClick :(UIBarButtonItem *)item {
//    [self selectButton :(NSUInteger)item.tag];
//}
//
//- (void)selectButton :(NSUInteger)pageIndex {
//    [self onPageChange :pageIndex];
//    [self showPage];
//    [self showSelectEffect];
//}
//
//- (void)onPageChange :(NSUInteger)pageIndex {
//    self.currentController.showing = NO;
//    _currentIndex = pageIndex;
//    self.currentController.showing = YES;
//    [_parentController updateBarItemsAndMenu];
//}
//
//- (void)showPage {
//    [_scrollView scrollToPage :_currentIndex of :_controllers.count];
//}
//
//- (void)showSelectEffect {
//    for (UIBarButtonItem *item in _toolBar.items) {
//        if (item.tag == -1) continue;
//        if (item.tag == _currentIndex) item.tintColor = self.selectedItemColor;
//        else item.tintColor = self.normalItemColor;
//    }
//}
//
//- (UIColor *)selectedItemColor {
//    if (_selectedItemColor) return _selectedItemColor;
//    return FlatBlueDark;
//}
//
//- (UIColor *)normalItemColor {
//    if (_normalItemColor) return _normalItemColor;
//    return [FlatBlueDark addAlpha :0.8];
//}
//
//- (CSMainController <CSToolbarPage> *)currentController {
//    return _controllers[_currentIndex];
//}
//
//@end