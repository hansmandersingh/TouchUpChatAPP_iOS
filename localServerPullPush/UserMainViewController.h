//
//  UserMainViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-03.
//

#import "ViewController.h"
#import "ShareAblesViewController.h"
#import "UserMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserMainViewController : ShareAblesViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) UITableView *messagesTable;
@property (nonatomic) NSMutableArray<UserMessage *>* messages;
@property (nonatomic) int loggedUserId;

@end

NS_ASSUME_NONNULL_END
