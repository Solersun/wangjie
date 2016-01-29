//
//  DataBaseManager.h
//  2-FMDB
//
//  Created by qianfeng on 16/1/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>
//把Student当做一个类
@class StudentModel;
/**
 *  数据库管理类
 */
@interface DataBaseManager : NSObject

/**
 *  获得数据库单例
 */
+(instancetype)shareManager;



@end
