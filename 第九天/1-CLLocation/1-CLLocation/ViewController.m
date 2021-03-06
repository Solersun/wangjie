//
//  ViewController.m
//  1-CLLocation
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocation *location;

//定位管理器
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatLocationManager];
    [self countDistance];
}

/**
 *  创建定位管理器
 */
- (void)creatLocationManager{
    
//    _locationManager = [[CLLocationManager alloc] init];
//    _locationManager.delegate = self;
//    _locationManager.distanceFilter = 100;
//    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
//    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [_locationManager requestAlwaysAuthorization];
//    }
    
    //初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    //设置代理
    _locationManager.delegate = self;
    
    //1000米 定位一次
    _locationManager.distanceFilter = 10;
    
//    113.628474,34.764401
    //精度
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    //ios8 以后 在开始定位前 要申请定期权限
    //判断当前系统的版本号 如果大于ios8 才去申请权限
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        
        //申请定位权限 再申请权限前 必须在info.plist文件中配置
        // 一直定位
        // 需要在info.plist里增加这个key NSLocationAlwaysUsageDescription
        
        
        // 应用在启用的时候才允许定位
        // 需要在info.plist里增加这个key NSLocationWhenInUseUsageDescription
        
        [_locationManager requestWhenInUseAuthorization];
    }
    
    //ios8 以前用这个
    [_locationManager startUpdatingLocation];
    
    
//    [_locationManager startUpdatingLocation];
 

}


-(void)countDistance{
    
    CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:34.764401 longitude:113.628474];
    CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:34.784811 longitude:113.628474];

    //调用系统的方法
    CLLocationDistance distance = [loc1 distanceFromLocation:loc2];
    
    NSLog(@"%f",distance);
    

//    CLLocationDistance dise = [loc1 distanceFromLocation:loc1];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    //1.获取用户的位置
    CLLocation *location = [locations lastObject];
    //经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //纬度 latitude   经度 longitude
    NSLog(@"%f %f",coordinate.latitude,coordinate.longitude);


}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
//
//    CLLocation *location = [locations l
//
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
