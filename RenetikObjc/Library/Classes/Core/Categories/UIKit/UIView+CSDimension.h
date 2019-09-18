//
// Created by Rene Dohan on 17/07/18.
//

@import UIKit;

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CSDimension)

@property (readonly) CGSize size;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

- (CGSize) calculateSizeFromSubviews;

- (CGFloat) calculateHeightToFitWidth;

- (instancetype)size:(CGSize)size;

- (instancetype)frame:(CGRect)rect;

- (instancetype)setSize:(CGSize) size
    NS_SWIFT_NAME(set(size:));

- (instancetype)width:(CGFloat)width height:(CGFloat)height;

- (instancetype)sizeBySquare:(CGFloat) square
    NS_SWIFT_NAME(sizeBy(square:));

- (instancetype)width:(CGFloat)value;

- (instancetype)widthAsHeight;

- (instancetype)height:(CGFloat)height;

- (instancetype)hideByHeightIf:(BOOL)hide;

- (instancetype)heightAsWidth;

- (instancetype)addWidth:(CGFloat) value
    NS_SWIFT_NAME(add(width:));

- (instancetype)addHeight:(CGFloat) value
    NS_SWIFT_NAME(add(height:));

- (instancetype)sizeFit;

- (instancetype)sizeHeightToFit;

- (instancetype)fitSubviews;

- (instancetype)resizeByPadding:(CGFloat) padding
    NS_SWIFT_NAME(resizeBy(padding:));

- (instancetype)addLeft:(CGFloat) value
    NS_SWIFT_NAME(add(left:));

- (instancetype)addTop:(CGFloat) value
    NS_SWIFT_NAME(add(top:));

- (instancetype)addRight:(CGFloat) value
    NS_SWIFT_NAME(add(right:));

- (instancetype)addBottom:(CGFloat) value
    NS_SWIFT_NAME(add(bottom:));

@end

NS_ASSUME_NONNULL_END
