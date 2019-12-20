//
//  Created by Rene Dohan on 12/26/12.
//


@import UIKit;

@interface UIDevice (CSExtension)

+ (void)setOrientation:(UIDeviceOrientation)orientation;

+ (UIDeviceOrientation)orientation;

+ (BOOL)iPhone;

+ (BOOL)iPad;

+ (float)systemVersion;

+ (BOOL)isIOS10;

+ (BOOL)isIOS11;

@end