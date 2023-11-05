//
//  UserMainViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-03.
//

#import "UserMainViewController.h"

@interface UserMainViewController ()<UISearchBarDelegate>

@end

@implementation UserMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.view.backgroundColor = [UIColor blackColor];
    } else {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    self.title = @"Messages";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Off" style:UIBarButtonItemStyleDone target:self action:@selector(changeToLogOffView)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initializationOfProperties];
    [self addSearchBarToView];
    
    
    // Do any additional setup after loading the view.
}

-(void)changeToLogOffView{
    ViewController *loginVC = [ViewController new];
    [self.navigationController setViewControllers:@[loginVC] animated:YES];
}

-(void) initializationOfProperties{
    self.searchBar = [[UISearchBar alloc] init];
    
}

-(void) addSearchBarToView {
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search";
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.searchBar];
    
    [self.searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10].active = YES;
    [self.searchBar.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.searchBar.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
