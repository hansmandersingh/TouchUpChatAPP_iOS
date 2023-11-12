//
//  UserMessage.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserMessage : NSObject

@property int messageIdNumber;
@property int messageFromUserId;
@property int messageForUserId;
@property (nonatomic) NSString *messageReceived;

- (instancetype)initWithId: (int) withId fromuserId:(int) senderUserId foruser:(int) forUserId withTextMessage:(NSString *)messageReceived;

@end

NS_ASSUME_NONNULL_END
