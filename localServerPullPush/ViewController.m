//
//  ViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import "ViewController.h"
#import "User.h"
#import "UserMainViewController.h"

@interface ViewController ()<UITextFieldDelegate> {
    int direction;
    int shakes;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationDoneHere];
    
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.title = @"Touch Up";
    self.usersArray = [[NSMutableArray alloc] init];
    
    [self showActivityIndicator];
    [self fetchUsersAndFillUserArray:^(NSError *error, BOOL success) {
        if(success) {
            [self hideActivityIndicator];
            
            [self loginInfoPage];
            
            [self.loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
            //need to add functionality here
        } else {
            [self hideActivityIndicator];
            UIAlertAction *alertCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *alertReload = [UIAlertAction actionWithTitle:@"Reload" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self viewDidLoad];
            }];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error fetching data" message:@"Something fed up" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:alertReload];
            [alertController addAction:alertCancel];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }];

    // Do any additional setup after loading the view.
}

-(void)login {
    //shaker works here with just on shake
    direction = 1;
    shakes = 0;
    // this checks for login stuff
    if (self.usersArray.count != 0 && ![self.loginUsernameField.text isEqual:@""] && ![self.loginPasswordField.text isEqual:@""]) {
        //NSLog(@"%@", self.loginUsernameField.text);
        User *loggedInUser;
        for(User *user in self.usersArray) {
            if([user.user_name isEqualToString:self.loginUsernameField.text] && [user.user_password isEqualToString:self.loginPasswordField.text]) {
                loggedInUser = [[User alloc] initWith:user.idNumber withName:user.user_name withPassword:user.user_password];
                break;
            }
        }
        if(loggedInUser) {
            UserMainViewController *userViewController = [[UserMainViewController alloc] init];
            [self.loginPasswordField setText:@""];
            [self.loginUsernameField setText:@""];
            [self.navigationController setViewControllers:@[userViewController] animated:YES];
            
        } else {
            [self shake:self.loginUsernameField];
            [self shake:self.loginPasswordField];
            [self showCustomErrorHandler:@"User not found"];
        }
    }else if ([self.loginUsernameField.text isEqual:@""] && [self.loginPasswordField.text isEqual:@""]) {
        [self shake:self.loginUsernameField];
        [self shake:self.loginPasswordField];
        [self showCustomErrorHandler:@"Please enter Username and password"];
    } else {
        [self shake:self.loginUsernameField];
        [self shake:self.loginPasswordField];
        [self showCustomErrorHandler:@"Error fetching users from server"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

-(void)shake:(UIView *)theOneYouWannaShake
{
  [UIView animateWithDuration:0.03 animations:^
                                  {
      theOneYouWannaShake.transform = CGAffineTransformMakeTranslation(5*self->direction, 0);
                                  }
                                  completion:^(BOOL finished)
                                  {
      if(self->shakes >= 10)
                                    {
                                      theOneYouWannaShake.transform = CGAffineTransformIdentity;
                                      return;
                                    }
      self->shakes++;
      self->direction = self->direction * -1;
                                    [self shake:theOneYouWannaShake];
                                  }];
}

-(void)loginInfoPage {
    self.usernameLabel.text = @"Username";
    self.usernameLabel.textAlignment = NSTextAlignmentLeft;
    self.usernameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.usernameLabel];
    
    self.passwordLabel.text = @"Password";
    self.passwordLabel.textAlignment = NSTextAlignmentLeft;
    self.passwordLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordLabel];
    
    self.loginUsernameField.placeholder = @"Enter your username:";
    self.loginUsernameField.borderStyle = UITextBorderStyleRoundedRect;
    self.loginUsernameField.delegate = self;
    [self.loginUsernameField setReturnKeyType:UIReturnKeyDone];
    self.loginUsernameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginUsernameField];
    
    self.loginPasswordField.placeholder = @"Enter your password:";
    self.loginPasswordField.borderStyle = UITextBorderStyleRoundedRect;
    [self.loginPasswordField setSecureTextEntry:YES];
    self.loginPasswordField.delegate = self;
    [self.loginPasswordField setReturnKeyType:UIReturnKeyDone];
    self.loginPasswordField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginPasswordField];
    
    [self.loginButton setTitle:@"  Login  " forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton.titleLabel setFont:[UIFont systemFontOfSize:23]];
    self.loginButton.backgroundColor = [UIColor systemBlueColor];
    self.loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginButton];
    
    [self.usernameLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20].active = YES;
    [self.usernameLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.usernameLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    
    [self.loginUsernameField.topAnchor constraintEqualToAnchor:self.usernameLabel.bottomAnchor constant:10].active = YES;
    [self.loginUsernameField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.loginUsernameField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    
    [self.passwordLabel.topAnchor constraintEqualToAnchor:self.loginUsernameField.bottomAnchor constant:20].active = YES;
    [self.passwordLabel.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.passwordLabel.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    
    [self.loginPasswordField.topAnchor constraintEqualToAnchor:self.passwordLabel.bottomAnchor constant:10].active = YES;
    [self.loginPasswordField.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.loginPasswordField.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    
    [self.loginButton.topAnchor constraintEqualToAnchor:self.loginPasswordField.bottomAnchor constant:20].active = YES;
    [self.loginButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    
}

-(void)showCustomErrorHandler:(NSString *) errorString {
    [self.customErrorHandler setText:errorString];
    [self.customErrorHandler setBackgroundColor:[UIColor systemRedColor]];
    [self.customErrorHandler setTextColor:[UIColor blackColor]];
    [self.customErrorHandler setTextAlignment:NSTextAlignmentCenter];
    self.customErrorHandler.translatesAutoresizingMaskIntoConstraints = NO;
    CATransition *transition = [CATransition animation];
    transition.duration = 1.0;
    transition.type = kCATransitionReveal; //choose your animation
    [self.customErrorHandler.layer addAnimation:transition forKey:nil];
    [self.view addSubview:self.customErrorHandler];
    
    [self.customErrorHandler.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor].active = YES;
    [self.customErrorHandler.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor].active = YES;
    [self.customErrorHandler.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor].active = YES;
    [self.customErrorHandler.heightAnchor constraintEqualToConstant:30].active = YES;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self.customErrorHandler removeFromSuperview];
    });
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    switch (self.traitCollection.userInterfaceStyle) {
        case UIUserInterfaceStyleDark:
            self.view.backgroundColor = [UIColor blackColor];
            break;
        case UIUserInterfaceStyleLight:
            self.view.backgroundColor = [UIColor whiteColor];
            break;
            
        default:
            break;
    }
}

-(void)initializationDoneHere {
    self.ActivityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.labelUnderSpinner = [[UILabel alloc] init];
    self.usernameLabel = [[UILabel alloc] init];
    self.passwordLabel = [[UILabel alloc] init];
    self.loginUsernameField = [[UITextField alloc] init];
    self.loginPasswordField = [[UITextField alloc] init];
    self.loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.customErrorHandler = [[UILabel alloc] init];
}

-(void)showUserAuthorization {
    //Login and register func for views
    
    
}



-(void) fetchUsersAndFillUserArray:(void (^)(NSError *error, BOOL success))callback {
    NSString *url_String = @"http://localhost:3000/users";
    
    NSURL *url = [NSURL URLWithString:url_String];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: config delegate: nil delegateQueue: [NSOperationQueue mainQueue]];

    [[delegateFreeSession  dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        if (!error) {
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *newData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *allUsers = [NSJSONSerialization JSONObjectWithData:newData options:kNilOptions error:&err];
            
            for(id arr in allUsers) {
                User *user = [[User alloc] initWith:[arr[@"id"] intValue] withName:arr[@"user_name"] withPassword:arr[@"user_password"]];
                [self.usersArray addObject:user];
            }
            callback(nil, YES);
            //NSLog(@"%@", error);
        } else {
            NSLog(@"%@",error);
            callback(error, NO);
            return;
        }
        
        }] resume] ;
}


@end
