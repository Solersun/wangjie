//
//  DataBaseManager.m
//  2-FMDB
//
//  Created by qianfeng on 16/1/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"
#import "StudentModel.h"

@interface DataBaseManager ()

//数据库
@property (nonatomic,strong) FMDatabase *dbBase;
//数据库地址
@property (nonatomic,strong) NSString *dbPath;

@end

@implementation DataBaseManager



+(instancetype)shareManager{
    /*
    //非线程安全的
    static  DataBaseManager *manager = nil;
    if (manager ==nil) {
        manager = [[DataBaseManager alloc] init];
    }
    return manager;
     */
    
    //线程安全的单例
    static DataBaseManager *manager = nil;
    
    //只执行一次
    static dispatch_once_t  token;
    
    dispatch_once(&token, ^{
        NSLog(@"只会执行一次");
        manager = [[DataBaseManager alloc] init];
        
    });
    
    
    
    return manager;
}


-(instancetype)init{

    if (self == [super init]) {
        
        //初始化数据库
        //dbpath
        //沙河地址
        
        NSString *libray = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
        
        _dbPath = [libray stringByAppendingPathComponent:@"my.sqlite"];
        _dbBase = [FMDatabase databaseWithPath:_dbPath];
        
        //如果数据库打开 创建表
        if ([_dbBase open]) {
            
            NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL,s_age INTERGER,s_name TEXT,s_sex INTERGER,s_score INTERGER)";
            if ([_dbBase executeUpdate:sql]) {
                NSLog(@"创表成功");
                
            }else{
                NSLog(@"创表失败");
            }
            
        }
        
    }
    return self;
}


/**
 *  插入数据
 */
-(void)insertStudent:(StudentModel *)stu{

}

/**
 *  删除数据
 */
-(void)deleteStudent:(StudentModel *)stu{

}

/**
 *  修改数据
 */
-(void)updateStudent:(StudentModel *)stu{
    
}

/**
 *  查找数据
 */
-(StudentModel *)selectStudentByID:(NSInteger)stuID{

    return  nil;
}

/**
 *  查找数据 按年龄
 */
-(NSArray *)selectStudentByage:(NSInteger)age{
    return nil;
}

/**
 *  查找数据 按年龄 和条数
 */
-(NSArray *)selectStudentByage:(NSInteger)age AndLimit:(NSInteger)limit{

    return  nil;
}






@end
