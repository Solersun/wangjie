//
//  Food.h
//  2-分割视图
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FoodDelegate <NSObject>

-(void)didSelectRow:(NSInteger)row;

@end

@interface Food : UITableViewController

//设置代理
@property (nonatomic,weak)id<FoodDelegate>delegate;

@end
