//
//  MessageDetailViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-12-01.
//

#import "ViewController.h"
#import "UserMessage.h"
#import "User.h"
#import "UserMainViewController.h"
#import "UserMessageTableViewCell.h"
#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MessageDetailViewController : UIViewController

@property (nonatomic) UserMessage *message;
@property (nonatomic) UIScrollView *scrollView;

@end

NS_ASSUME_NONNULL_END
