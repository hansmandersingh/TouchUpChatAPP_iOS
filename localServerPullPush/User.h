//
//  User.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property int idNumber;
@property (nonatomic) NSString *user_name;
@property (nonatomic) NSString *user_password;

- (instancetype)initWith:(int)idNumber withName: (NSString *)user_name withPassword: (NSString *)user_password;

@end

NS_ASSUME_NONNULL_END
