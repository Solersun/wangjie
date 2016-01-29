//
//  Detail.h
//  3-UIImagePicker
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^blockRefresh)();

@interface Detail : UIViewController

@property (nonatomic,copy)blockRefresh block;

-(void)setBlock:(blockRefresh)block;
@end
