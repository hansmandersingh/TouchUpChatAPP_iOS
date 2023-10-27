//
//  ViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@property (nonatomic) UIView *ActivityIndicatorView;
@property (nonatomic) UIActivityIndicatorView *spinner;
@property (nonatomic) UILabel *labelUnderSpinner;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.ActivityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.labelUnderSpinner = [[UILabel alloc] init];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Welcome Users";
    self.usersArray = [[NSMutableArray alloc] init];
    
    [self showActivityIndicator];
    [self fetchUsersAndFillUserArray:^(NSError *error, BOOL success) {
        if(success) {
            NSLog(@"%@",self.usersArray);
            [self hideActivityIndicator];
        } else {
            NSLog(@"Something fed up");
        }
    }];

    // Do any additional setup after loading the view.
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
            [self loadDataNow];
            callback(nil, YES);
            //NSLog(@"%@", error);
        } else {
            NSLog(@"%@",error);
            callback(error, NO);
            return;
        }
        
        }] resume] ;
}

-(void) loadDataNow {
    self.didFinishFetching = YES;
}



@end
