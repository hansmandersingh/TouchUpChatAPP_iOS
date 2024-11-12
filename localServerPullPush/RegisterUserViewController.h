//
//  RegisterUserViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2024-11-12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterUserViewController : UIViewController

@property (nonatomic) UITextView* username;
@property (nonatomic) UITextField* usernameField;
@property (nonatomic) UITextView* password;
@property (nonatomic) UITextField* passwordField;
@property (nonatomic) UIButton* submit;

@end

NS_ASSUME_NONNULL_END
