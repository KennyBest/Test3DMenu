//
//  DetailViewController.m
//  Test3DMenu
//
//  Created by lining on 15/12/21.
//  Copyright © 2015年 lining. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@end

@implementation DetailViewController{
    UIImageView *_leftItemView;
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"menuItem" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //消除导航栏下面的一条细线
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    [self setNavigationLeftItem];
    //[self addObserver:self forKeyPath:@"menuItem" options:NSKeyValueObservingOptionNew context:nil];
     [self addObserver:self forKeyPath:@"menuItem" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setNavigationLeftItem {
    UIImageView *hamburgerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    hamburgerView.image = [UIImage imageNamed:@"Hamburger"];
    hamburgerView.contentMode = UIViewContentModeScaleAspectFit;
    hamburgerView.userInteractionEnabled = YES;
    _leftItemView = hamburgerView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showOrHideMenu)];
    [hamburgerView addGestureRecognizer:tap];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:hamburgerView];
}

- (void)showOrHideMenu {
    ViewController *containerVC = (ViewController *)self.navigationController.parentViewController;
    [containerVC handelMeunShowWithShow:YES animated:NO];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configCellFromSource:(NSDictionary *)dictionary {
    self.bgImgView.image = [UIImage imageNamed:dictionary[@"image"]];
    NSArray *colors = dictionary[@"colors"];
    float red = [colors[0] floatValue];
    float green = [colors[1] floatValue];
    float blue = [colors[2] floatValue];
    self.view.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"menuItem"]) {
        [self configCellFromSource:self.menuItem];
    }
}

- (void)rotateHambumgerView:(CGFloat)fraction {
    CGFloat angle = (double)fraction * M_PI_2;
    _leftItemView.transform = CGAffineTransformMakeRotation(angle);
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
