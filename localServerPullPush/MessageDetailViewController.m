//
//  MessageDetailViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-12-01.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    //nav bar initialization here
    UITextView *navCenterTitile = [[UITextView alloc] init];
    navCenterTitile.text = appDelegate.usersArray[self.message.messageFromUserId].user_name;
    navCenterTitile.font = [UIFont boldSystemFontOfSize:20];
    [navCenterTitile setContentMode:UIViewContentModeScaleAspectFill];
    
    self.navigationItem.titleView = navCenterTitile;
    
    //scrollview starts here for messages
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor cyanColor];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.scrollView];
    //scrollview constraints
    [self.scrollView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10].active = YES;
    [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:10].active = YES;
    [self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
}


@end
