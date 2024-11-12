//
//  RegisterUserViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2024-11-12.
//

#import "RegisterUserViewController.h"

@interface RegisterUserViewController ()

@end

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Register";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadSubmitForm];
}

-(void)initializePropeties {
    self.username = [[UITextView alloc] init];
    self.usernameField = [[UITextField alloc] init];
    self.password = [[UITextView alloc] init];
    self.passwordField = [[UITextField alloc] init];
    self.submit = [UIButton init];
}

-(void)loadSubmitForm {
    
}

@end
