//
// Created by Rene Dohan on 13/01/15.
// Copyright (c) 2015 creative_studio. All rights reserved.
//

@import UIKit;
@import BlocksKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (CSExtension)

+ (UIBarButtonItem *)createWithImage:(UIImage *)image onClick:(void (^)(id sender))action;

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item onClick:(void (^)(id sender))action;

+ (UIBarButtonItem *)createWithTitle:(NSString *)title onClick:(void (^)(id sender))action;

+ (UIBarButtonItem *)createSoloTitle:(NSString *)title;

+ (UIBarButtonItem *)createWithTitle:(NSString *)title :(UIBarButtonItemStyle)style :(id)target :(SEL)action;

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item :(id)target :(SEL)action;

+ (UIBarButtonItem *)createWithItem:(UIBarButtonSystemItem)item;

+ (UIBarButtonItem *)createFlexSpaceItem;

+ (UIImage *)imageFromSystemBarButton:(UIBarButtonSystemItem)systemItem :(UIColor *)color;

- (void)setTarget:(id)target forAction:(SEL)action;

@end

NS_ASSUME_NONNULL_END
