//
//  UserMessageTableViewCell.h
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-25.
//

#import <UIKit/UIKit.h>
#import "UserMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserMessageTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *messageText;
@property (nonatomic, strong) UILabel *descriptionText;
@property (nonatomic, strong) UIImageView *avatarImage;

@end

NS_ASSUME_NONNULL_END
