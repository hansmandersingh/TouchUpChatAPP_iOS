//
//  ShareAbleViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-05.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN


@interface ShareAbleViewController : UIViewController

@property (nonatomic) UIView *ActivityIndicatorView;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) UILabel *labelUnderSpinner;

-(void)showActivityIndicator;

@end

NS_ASSUME_NONNULL_END
