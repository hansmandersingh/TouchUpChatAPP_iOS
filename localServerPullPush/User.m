//
//  User.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-26.
//

#import "User.h"

@implementation User

- (instancetype)initWith:(int)idNumber withName: (NSString *)user_name withPassword: (NSString *)user_password withAvatar: (NSString *)user_avatar
{
    self = [super init];
    if (self) {
        self.idNumber = idNumber;
        self.user_name = user_name;
        self.user_password = user_password;
        self.user_avatar = user_avatar;
    }
    return self;
}

@end
