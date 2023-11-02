//
//  ViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()<UITextFieldDelegate> {
    int direction;
    int shakes;
}

@property (nonatomic) UIView *ActivityIndicatorView;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) UILabel *labelUnderSpinner;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializationDoneHere];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    // this checks for login stuff
    if (self.usersArray.count != 0) {
        User *loggedInUser;
        for(User *user in self.usersArray) {
            if([user.user_name isEqualToString:self.loginUsernameField.text] && [user.user_password isEqualToString:self.loginPasswordField.text]) {
                NSLog(@"%@",user.user_name);
                NSLog(@"%@",user.user_password);
                loggedInUser = [[User alloc] initWith:user.idNumber withName:user.user_name withPassword:user.user_password];
                break;
            }
        }
        if(loggedInUser) {
            NSLog(@"%@",loggedInUser.user_name);
        } else {
            direction = 1;
            shakes = 0;
            [self shake:self.loginUsernameField];
            [self shake:self.loginPasswordField];
            NSLog(@"nothin");
        }
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
}

-(void)showUserAuthorization {
    //Login and register func for views
    
    
}

-(void)showActivityIndicator {
    self.ActivityIndicatorView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.ActivityIndicatorView];
    
    
    self.spinner.color = [UIColor blackColor];
    self.spinner.center = self.ActivityIndicatorView.center;
    [self.ActivityIndicatorView addSubview:self.spinner];
    [self.spinner startAnimating];
    
    self.labelUnderSpinner.text = @"Please wait fetching users from server";
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
