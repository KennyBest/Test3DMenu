//
//  MenuItemCell.m
//  Test3DMenu
//
//  Created by lining on 15/12/21.
//  Copyright © 2015年 lining. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)configCellFromSource:(NSDictionary *)dictionary {
    self.menuImgView.image = [UIImage imageNamed:dictionary[@"image"]];
    NSArray *colors = dictionary[@"colors"];
    float red = [colors[0] floatValue];
    float green = [colors[1] floatValue];
    float blue = [colors[2] floatValue];
    self.backgroundColor = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}
@end
