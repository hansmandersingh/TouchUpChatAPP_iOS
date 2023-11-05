//
//  UserMainViewController.m
//  localServerPullPush
//
//  Created by Hansmander Singh on 2023-11-03.
//

#import "UserMainViewController.h"

@interface UserMainViewController ()<UISearchBarDelegate> {
    NSArray *messages;
}

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
    messages = @[@"hello", @"How"];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Off" style:UIBarButtonItemStyleDone target:self action:@selector(changeToLogOffView)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initializationOfProperties];
    [self addSearchBarToView];
    self.messagesTable.delegate = self;
    self.messagesTable.dataSource = self;
    [self setupTableView];
    [self showActivityIndicator];
    [self hideActivityIndicator];
    
    // Do any additional setup after loading the view.
}

-(void)setupTableView {
    self.messagesTable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.messagesTable];
    
    [self.messagesTable.topAnchor constraintEqualToAnchor:self.searchBar.bottomAnchor constant:10].active = YES;
    [self.messagesTable.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor constant:10].active = YES;
    [self.messagesTable.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor constant:-10].active = YES;
    [self.messagesTable.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-10].active = YES;
}

-(void)changeToLogOffView{
    ViewController *loginVC = [ViewController new];
    [self.navigationController setViewControllers:@[loginVC] animated:YES];
}

-(void) initializationOfProperties{
    self.searchBar = [[UISearchBar alloc] init];
    self.messagesTable = [[UITableView alloc] init];
    self.ActivityIndicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
    self.labelUnderSpinner = [[UILabel alloc] init];
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

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"messagesCell";
    UITableViewCell *cell = [self.messagesTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = [messages objectAtIndex:indexPath.item];
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

@end
