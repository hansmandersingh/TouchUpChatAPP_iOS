//
//  ShareAblesViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-05.
//

#import "ShareAblesViewController.h"

@interface ShareAblesViewController ()

@end

@implementation ShareAblesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)showActivityIndicator {
    self.ActivityIndicatorView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.ActivityIndicatorView];
    
    
    self.spinner.color = [UIColor blackColor];
    self.spinner.center = self.ActivityIndicatorView.center;
    [self.ActivityIndicatorView addSubview:self.spinner];
    [self.spinner startAnimating];
    
    self.labelUnderSpinner.text = @"Please wait fetching data from server";
    self.labelUnderSpinner.textColor = [UIColor blackColor];
    self.labelUnderSpinner.translatesAutoresizingMaskIntoConstraints = NO;
    [self.ActivityIndicatorView addSubview:self.labelUnderSpinner];
    
    [self.labelUnderSpinner.centerXAnchor constraintEqualToAnchor:self.ActivityIndicatorView.centerXAnchor].active = YES;
    [self.labelUnderSpinner.topAnchor constraintEqualToAnchor:self.spinner.bottomAnchor constant:10].active = YES;
}

-(void)hideActivityIndicator {
    [self.spinner stopAnimating];
    [self.labelUnderSpinner removeFromSuperview];
    [self.spinner removeFromSuperview];
    [self.ActivityIndicatorView removeFromSuperview];
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
