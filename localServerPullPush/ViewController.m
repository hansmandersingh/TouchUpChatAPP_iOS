//
//  ViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-10-25.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Fetch here: ";
    
    NSString *url_String = @"http://localhost:3000/users";
    
    NSURL *url = [NSURL URLWithString:url_String];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSString *stringGot = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", response);
        }] resume] ;
    // Do any additional setup after loading the view.
}


@end
