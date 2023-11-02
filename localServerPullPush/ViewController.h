//
//  ViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface ViewController : UIViewController

@property (nonatomic) NSMutableArray<User *> *usersArray;
@property (nonatomic) BOOL didFinishFetching;
@property (nonatomic) UILabel *usernameLabel;
@property (nonatomic) UITextField *loginUsernameField;
@property (nonatomic) UILabel *passwordLabel;
@property (nonatomic) UITextField *loginPasswordField;
@property (nonatomic) UIButton *loginButton;

@end

