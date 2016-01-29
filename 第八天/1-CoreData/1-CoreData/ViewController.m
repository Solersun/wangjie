//
//  ViewController.m
//  1-CoreData
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
//导入头文件
#import <CoreData/CoreData.h>
#import "Person+CoreDataProperties.h"
@interface ViewController ()
//声明属性 数据库 coredata 上下文 方便使用
@property (nonatomic,strong) NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createContext];
    [self insertData];
    [self selectData];
//    [self deleteDate];
}

/**
 *  创建CoreData 上下文Context
 */
-(void)createContext{

    //1.找到模型url （NSbundle 找）
    //2.初始化模型 NSManagedObjectModel *model=....
    //3.添加数据库支持  NSPersistentStoreCoordinator
    //4.找个路径存放他
    //5.拼接全路径
    //6.找到该路径 NSURL fileUrlWith。。。。
    //7.家协调器 NSPersistentStore
    //8.创建上下文
    
    //1.先从bundle中加载模型文件 （可以再创建项目是自动生成 也可以自动创建）
    //找到模型的url
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    //初始化模型文件
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    docs = [docs stringByAppendingPathComponent:@"coredata.sqlite"];
    
    NSURL *sqlUrl = [NSURL fileURLWithPath:docs];
    
    
    NSError *error = nil;
    //添加协调器
    //1.类型 NSSQLiteStoreType
    //2.config nil
    //3.url  路径
    //4.options nil
    //5.错误信息 用error存储
    NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqlUrl options:nil error:&error];
    if (error) {
        NSLog(@"创建数据库失败了");
        //oc抛出异常
     
        [NSException raise:@"添加失败" format:@"%@",[error localizedDescription]];
    }else{
        NSLog(@"创建数据库成功了");
           NSLog(@"%@",NSHomeDirectory());
    }
    
    
    //创建COredata的上下文
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    context.persistentStoreCoordinator = psc;
    self.context = context;
}


/**
 *  怎加数据
 */
- (void)insertData {

    //数据模型 NSManagedObject
    //用来描述模型 NSEntityDescription
    //第一个参数是实体名称
    //第二个是上下文
    Person *obj = [NSEntityDescription  insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_context];
    //给插入得数据赋值 KVC 键值编码
//    [obj setValue:@"猪猪" forKey:@"name"];
//    [obj setValue:@11 forKey:@"age"];

    obj.name = @"猪猪";
    obj.age = @18;
    NSError *error = nil;
    //context save 必须保存下
    if([_context save:&error]){
        NSLog(@"插入成功");
    }else{
        NSLog(@"%@",error);
    }
}


/**
 *  查询数据
 */
-(void)selectData{
    
    //1.FatchRequest
    //2.设置实体
    //3.设置条件
    
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //查询的条件 和要查询的实体
    
    //1.查询实体
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    
    //查询条件 谓词
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",@"猪猪"];
    
    request.predicate = predicate;
    
    //获取结果
    NSError *error = nil;
    NSArray *resl = [_context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    }else{
    
//        NSLog(@"%@",resl);
        //类似forin 枚举器
        [resl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"name=%@  age=%@",[obj valueForKey:@"name"],[obj valueForKey:@"age"]);
        }];
    }
    


}

/**
 *  删除数据
 */
-(void)deleteDate{

    //先查询
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    request.entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:_context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@",@"name",@"小明"];
    request.predicate = predicate;
    NSArray *result = [_context executeFetchRequest:request error:nil];
    //删除
    for (Person *item in result) {
        [_context deleteObject:item];
    }
    //删除完后要保存
    if([_context save:nil]){
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
    
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
