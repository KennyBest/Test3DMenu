//
//  DetailViewController.h
//  Test3DMenu
//
//  Created by lining on 15/12/21.
//  Copyright © 2015年 lining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic,strong) NSDictionary *menuItem;

- (void)rotateHambumgerView:(CGFloat)fraction;
@end
