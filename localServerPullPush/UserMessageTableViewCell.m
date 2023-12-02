//
//  UserMessageTableViewCell.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-25.
//

#import "UserMessageTableViewCell.h"

@implementation UserMessageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self) {
        [self initializationDoneHere];
        [self setConstraintsHere];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initializationDoneHere {
    self.messageText = [[UILabel alloc] init];
    self.descriptionText = [[UILabel alloc] init];
            
    [self addSubview:self.messageText];
    [self addSubview:self.descriptionText];
    self.descriptionText.translatesAutoresizingMaskIntoConstraints = NO;
    self.messageText.translatesAutoresizingMaskIntoConstraints = NO;
}

-(void)setConstraintsHere {
    [self.messageText.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.messageText.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.messageText.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.descriptionText.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10].active = YES;
    [self.descriptionText.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10].active = YES;
    [self.descriptionText.topAnchor constraintEqualToAnchor:self.messageText.bottomAnchor constant:5].active = YES;
    [self.bottomAnchor constraintEqualToAnchor:self.descriptionText.bottomAnchor constant:10].active = YES;
}

@end
