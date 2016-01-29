//
//  TableViewCell.m
//  3-UIImagePicker
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}




- (void)config:(Student *)stu{
    self.iconImageView.image = [UIImage imageWithData:stu.iconImageData];
    self.nameLable.text = stu.name;
    self.ageLable.text = [stu.age stringValue];

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
