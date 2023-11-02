//
//  NotificationViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-02.
//

#import "NotificationViewController.h"

@interface NotificationViewController ()

@property(weak,nonatomic) UIView *contentView;
@property (weak, nonatomic) UILabel *notificationTitleLabel;

@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.contentView.layer.cornerRadius = 3.0;

    self.notificationTitleLabel.text = self.titleText;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
