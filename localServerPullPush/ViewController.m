//
//  ViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Welcome Users";
    self.usersArray = [[NSMutableArray alloc] init];
    
    [self fetchUsersAndFillUserArray:^(NSError *error, BOOL success) {
        if(success) {
            NSLog(@"%@",self.usersArray);
        } else {
            NSLog(@"Something fed up");
        }
    }];

    // Do any additional setup after loading the view.
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
