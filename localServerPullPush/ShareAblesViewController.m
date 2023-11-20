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

-(void)presentActionVCForFailedFetch {
    UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *alertReload = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self viewDidLoad];
    }];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error fetching data" message:@"Something fed up" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:alertReload];
    [alertController addAction:alertCancel];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)showCustomErrorHandler:(NSString *) errorString withErrorHandler: (UILabel *) customErrorHandler {
    [customErrorHandler setText:errorString];
    [customErrorHandler setBackgroundColor:[UIColor systemRedColor]];
    [customErrorHandler setTextColor:[UIColor blackColor]];
    [customErrorHandler setTextAlignment:NSTextAlignmentCenter];
    customErrorHandler.translatesAutoresizingMaskIntoConstraints = NO;
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.type = kCATransitionReveal; //choose your animation
    [customErrorHandler.layer addAnimation:transition forKey:nil];
    [self.view addSubview:customErrorHandler];
    
    [customErrorHandler.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [customErrorHandler.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [customErrorHandler.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [customErrorHandler.heightAnchor constraintEqualToConstant:30].active = YES;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [customErrorHandler removeFromSuperview];
    });
}
@end
