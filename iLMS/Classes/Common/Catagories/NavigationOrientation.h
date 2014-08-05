//
//  NavigationOrientation.h
//  DaveyWaveyProject


#import <UIKit/UIKit.h>

@interface UINavigationController(orientation)
#ifdef __IPHONE_6_0
- (NSUInteger)supportedInterfaceOrientations;
- (BOOL)shouldAutorotate;
#endif
@end