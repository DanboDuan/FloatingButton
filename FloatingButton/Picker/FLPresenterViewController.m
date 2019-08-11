//
//  FLPresenterViewController.m
//  FloatingButton
//
//  Created by bob on 2019/7/3.
//

#import "FLPresenterViewController.h"
#import "FLPicker.h"
#import "UIColor+Hex.h"
#import "UIView+Frame.h"

#define FLPickerBlue                    [UIColor fl_colorWithRGB:0x4d64fd]
#define BDPickerBackground              [UIColor fl_colorWithRGB:0xf7f7f7]

#define BDPickerTopViewHeight  200.0

static NSString * const ReuseIdentifier = @"FLPresenterViewController_cell_";

@interface FLPresenterViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSString *> *feedList;

@end

@implementation FLPresenterViewController

- (void)loadView {
    [super loadView];
    self.view.backgroundColor = FLPickerBlue;
    CGFloat width = self.view.width;
    CGFloat height = self.view.height;

    UIView *imageContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, BDPickerTopViewHeight)];
    UIImage *image = [FLPicker sharedInstance].pickedImage;

    CGFloat ratio = MIN((BDPickerTopViewHeight - 20)/image.size.height, (width - 20)/image.size.width);
    CGFloat imageWidth =  ratio * image.size.width;
    CGFloat imageHeight =  ratio * image.size.height;
    CGFloat top = (BDPickerTopViewHeight - imageHeight)/2;
    CGFloat left = (width - imageWidth)/2;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(left, top, imageWidth, imageHeight)];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = image;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    imageView.layer.borderWidth = 1;
    imageView.clipsToBounds = YES;

    [imageContainer addSubview:imageView];
    imageContainer.backgroundColor = BDPickerBackground;
    [self.view addSubview:imageContainer];

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, BDPickerTopViewHeight, width, height - BDPickerTopViewHeight) style:(UITableViewStylePlain)];
    tableView.backgroundColor = BDPickerBackground;
    tableView.dataSource = self;
    tableView.delegate = self;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    self.feedList = [FLPicker sharedInstance].infoList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Debug Infomation";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(clickLeft)];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    CGSize imgSize = self.navigationController.navigationBar.frame.size;
    [self.navigationController.navigationBar setBackgroundImage:[FLPickerBlue fl_imageWithSize:imgSize] forBarMetrics:(UIBarMetricsDefault)];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[FLPicker sharedInstance] stopPicker];
}

#pragma mark action

- (void)clickLeft {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.feedList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *model = [self.feedList objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [UITableViewCell new];
    }
    cell.textLabel.text = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)dealloc {
    [[FLPicker sharedInstance] startPicker];
}

@end
