//
//  Created by Rene Dohan on 12/26/12.
//

#import <UIKit/UIKit.h>

@implementation UIDevice (CSExtension)

+ (void)setOrientation:(UIDeviceOrientation)orientation {
    [UIDevice.currentDevice setValue:@(orientation) forKey:@"orientation"];
    [UIViewController attemptRotationToDeviceOrientation];
}

+ (UIDeviceOrientation)orientation {
    return UIDevice.currentDevice.orientation;
}

+ (UIInterfaceOrientation)statusBarOrientation  {
    return UIApplication.sharedApplication.statusBarOrientation;
}

+ (BOOL)isPortrait {
    if(self.currentDevice.orientation == UIDeviceOrientationUnknown) return UIScreen.mainScreen.bounds.size.width < UIScreen.mainScreen.bounds.size.height;
    return UIDeviceOrientationIsPortrait(self.currentDevice.orientation);
}

+ (BOOL)isLandscape {
    return !self.isPortrait;
}

+ (BOOL)isThinScreen {
    return self.iPhone && self.isPortrait;
}

+ (BOOL)isShortScreen {
	return self.iPhone && self.isLandscape;
}

+ (BOOL)isTallScreen {
	return !self.isShortScreen;
}

+ (BOOL)isWideScreen {
    return !self.isThinScreen;
//	self.isWideScreenIOS8;
}

+ (BOOL)iPhone {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;
}

+ (BOOL)iPad {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

+ (BOOL)isWideScreenIOS8 {
    return fabs((double)UIScreen.mainScreen.nativeBounds.size.height - (double)1136) < DBL_EPSILON;
}

+ (float)systemVersion {
    return self.currentDevice.systemVersion.floatValue;
}

+ (BOOL)isIOS10 {
    return self.systemVersion >= 10;
}

+ (BOOL)isIOS11 {
    return self.systemVersion >= 11;
}

@end
