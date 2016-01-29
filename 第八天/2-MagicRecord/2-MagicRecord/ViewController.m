//
//  ViewController.m
//  2-MagicRecord
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import "MagicalRecord.h"
#import "Person+CoreDataProperties.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  插入数据
 */
- (IBAction)insertData:(id)sender {
    //创建 一个 Entity
    Person *person = [Person MR_createEntity];
    person.name = @"鱼儿";
    person.age = @30;
    
    //保存数据 到 context
    //这个数据保存是同步的 （主线程操作）;
//    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
    
    //这个是异步的(在子线程操作的)
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL contextDidSave, NSError *error) {
        NSLog(@"保存成功");
    }];
    
    
}


/**
 *  删除数据
 */
- (IBAction)deleteData:(id)sender {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"age=%@",@30];
    //删除所有匹配谓词的数据
    [Person MR_deleteAllMatchingPredicate:predicate];
    //保存
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

/**
 *  更新操作（修改）
 */
- (IBAction)upData:(id)sender {
   
    //拿到数据才能更新
    NSArray *result = [Person MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"age > %@",@14]];
    //修改年龄为十三
    for (Person *person in result) {
        person.age = @15;
    }
    //保存
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}


- (IBAction)selectData:(id)sender {
    
    NSArray *result = [Person MR_findAll];
    //修改年龄为十三
    for (Person *person in result) {
        NSLog(@"name = %@ ,age = %@",person.name,person.age);
    }
    
    //查找 排序 查找所有的
    [Person MR_findAllSortedBy:@"age" ascending:YES];
    
    //根据条件查找 并排序
//    [Person MR_findAllSortedBy:<#(NSString *)#> ascending:<#(BOOL)#> withPredicate:<#(NSPredicate *)#>]
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
