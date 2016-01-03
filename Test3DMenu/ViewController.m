//
//  ViewController.m
//  Test3DMenu
//
//  Created by lining on 15/12/21.
//  Copyright © 2015年 lining. All rights reserved.
//

#import "ViewController.h"

#import "DetailViewController.h"

@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;

@end

@implementation ViewController{
    DetailViewController *_detailVC;
    BOOL _isShown;
}

-(void)dealloc {
    [self removeObserver:self forKeyPath:@"menuItem" context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addObserver:self forKeyPath:@"menuItem" options:NSKeyValueObservingOptionNew context:nil];
    _isShown = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self handelMeunShowWithShow:_isShown animated:NO];
}

- (void)handelMeunShowWithShow:(BOOL)show animated:(BOOL)animated {
    _isShown = show;
    CGFloat menuWidth = CGRectGetWidth(self.menuContainerView.bounds);
    [self.scrollView setContentOffset:(show?CGPointMake(0, 0):CGPointMake(menuWidth, 0)) animated:animated];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"DetailViewControllerSegue"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        _detailVC = (DetailViewController *)navigationController.topViewController;
    }
}


#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat multiplier = 1.0 / CGRectGetWidth(self.menuContainerView.bounds);
    CGFloat offset = self.scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    
    self.menuContainerView.layer.transform = [self transformForFraction:fraction];
    self.menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    self.menuContainerView.alpha = fraction;
    
    [_detailVC rotateHambumgerView:fraction];
    
    self.scrollView.pagingEnabled = self.scrollView.contentOffset.x < (self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame));
    
    CGPoint menuOffset = CGPointMake(CGRectGetWidth(self.menuContainerView.bounds), 0);
    _isShown = !CGPointEqualToPoint(menuOffset, scrollView.contentOffset);
}
#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"menuItem"]) {
        _detailVC.menuItem = self.menuItem;
        [self handelMeunShowWithShow:NO animated:NO];
    }
}

#pragma mark - transform
- (CATransform3D)transformForFraction:(CGFloat)fraction {
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000.0;
    CGFloat angle = (double)(1.0 - fraction) * -M_PI_2;
    CGFloat Xoffset = CGRectGetWidth(self.menuContainerView.bounds) * 0.5;
    CATransform3D rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D translateTransform = CATransform3DMakeTranslation(Xoffset, 0.0, 0.0);
    return CATransform3DConcat(rotateTransform, translateTransform);
}
@end
