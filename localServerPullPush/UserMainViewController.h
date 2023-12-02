//
//  UserMainViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-03.
//

#import "ViewController.h"
#import "ShareAblesViewController.h"
#import "UserMessage.h"
#import "UserMessageTableViewCell.h"
#import "AppDelegate.h"
#define appDelegate ((AppDelegate *) [UIApplication sharedApplication].delegate)

NS_ASSUME_NONNULL_BEGIN

@interface UserMainViewController : ShareAblesViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) UITableView *messagesTable;
@property (nonatomic) NSMutableArray<UserMessage *>* messages;
@property (nonatomic) int loggedUserId;
@property (nonatomic) UILabel *customErrorHandler;
@property (nonatomic) UIRefreshControl *refreshControl;

@end

NS_ASSUME_NONNULL_END
