//
//  UserMessage.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-11.
//

#import "UserMessage.h"

@implementation UserMessage

- (instancetype)initWithId: (int) withId fromuserId:(int) senderUserId foruser:(int) forUserId withTextMessage:(NSString *)messageReceived
{
    self = [super init];
    if (self) {
        self.messageIdNumber = withId;
        self.messageFromUserId = senderUserId;
        self.messageForUserId = forUserId;
        self.messageReceived = messageReceived;
    }
    return self;
}

@end
