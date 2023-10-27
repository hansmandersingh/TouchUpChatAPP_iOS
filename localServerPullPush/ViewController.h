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

@end

