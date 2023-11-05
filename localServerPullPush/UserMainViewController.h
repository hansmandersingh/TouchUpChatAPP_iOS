//
//  UserMainViewController.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-03.
//

#import "ViewController.h"
#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserMainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) UISearchBar *searchBar;
@property (nonatomic) UITableView *messagesTable;

@end

NS_ASSUME_NONNULL_END
