//
//  MenuItemCell.h
//  Test3DMenu
//
//  Created by lining on 15/12/21.
//  Copyright © 2015年 lining. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuImgView;
- (void)configCellFromSource:(NSDictionary *)dictionary;
@end
