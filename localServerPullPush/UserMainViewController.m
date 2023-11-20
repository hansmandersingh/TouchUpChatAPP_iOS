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
    self.messages = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Off" style:UIBarButtonItemStyleDone target:self action:@selector(changeToLogOffView)];
    self.navigationItem.rightBarButtonItem = rightButton;

    [self initializationOfProperties];
    [self addSearchBarToView];
    self.messagesTable.delegate = self;
    self.messagesTable.dataSource = self;
    [self setupTableView];
    
    //adding refreshcontrol ui here yaay
    
    
    [self showActivityIndicator];
    
    [self startGettingMessages:self.loggedUserId completion: ^(NSError *error, BOOL success) {
        if(success) {
            [self hideActivityIndicator];
            //NSLog(@"%@",self.messages[0].messageReceived);
            [self->_messagesTable reloadData];
        } else {
            [self hideActivityIndicator];
            [self showCustomErrorHandler:@"Error Fetching Messages" withErrorHandler:self.customErrorHandler];
        }
    }];
    
    // Do any additional setup after loading the view.
}

-(void)startGettingMessages:(int)userId completion:(void(^)(NSError *error, BOOL success))callback {
    
    NSString *url_String = [NSString stringWithFormat:@"http://localhost:3001/messages?user_id=%d", userId];
    NSLog(@"%@",url_String);
    NSURL *url = [NSURL URLWithString:url_String];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    [[delegateFreeSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *err;
        if(!error){
            NSString *dataString = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            NSData *newData = [dataString dataUsingEncoding:NSUTF8StringEncoding];
            NSArray *allMessages = [NSJSONSerialization JSONObjectWithData:newData options:kNilOptions error:&err];
            for (id arr in allMessages) {
                UserMessage *userMessage = [[UserMessage alloc] initWithId:[arr[@"id"] intValue] fromuserId:[arr[@"message_from_id"] intValue] foruser:[arr[@"user_id"] intValue] withTextMessage:arr[@"user_message_received"]];
                [self.messages addObject:userMessage];
                
            }
            callback(nil, YES);
        } else {
            NSLog(@"%@", error);
            callback(nil, NO);
            return;
        }
    }]resume];
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
    self.customErrorHandler = [[UILabel alloc] init];
    self.refreshControl = [[UIRefreshControl alloc] init];
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


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"messagesCell";
    UITableViewCell *cell = [self.messagesTable dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.text = self.messages[indexPath.row].messageReceived;
        
    }
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

@end
