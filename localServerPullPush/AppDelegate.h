//
//  AppDelegate.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic) NSMutableArray<User *> *usersArray;

@end

