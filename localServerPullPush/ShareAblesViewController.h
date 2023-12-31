//
//  ShareAblesViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-05.
//

#import <UIKit/UIKit.h>
#import "User.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShareAblesViewController : UIViewController

@property (nonatomic) UIView *ActivityIndicatorView;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) UILabel *labelUnderSpinner;

-(void)showActivityIndicator;
-(void)hideActivityIndicator;
-(void)presentActionVCForFailedFetch;
-(void)showCustomErrorHandler:(NSString *) errorString withErrorHandler: (UILabel *) customErrorHandler;

@end

NS_ASSUME_NONNULL_END
