//
//  ViewController.m
//  3-MKmapView
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface ViewController ()<MKMapViewDelegate>

//地图视图
@property (nonatomic,strong) MKMapView *mapview;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self creatLoctionManager];
    [self creatMapView];
    [self backUserLocation];
    [self addAnnotation];
}

- (void)creatLoctionManager{
    
    _locationManager = [[CLLocationManager alloc] init];
    
    
    // 一直定位
    // 需要在info.plist里增加这个key NSLocationAlwaysUsageDescription
    
    // 应用在启用的时候才允许定位
    // 需要在info.plist里增加这个key NSLocationWhenInUseUsageDescription
    
    //除了判断版本好 还有种方法
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
       
        [_locationManager requestAlwaysAuthorization];
    
    }
    

}

- (void)creatMapView{

    //创建一张视图 并 添加
    _mapview = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_mapview];
    _mapview.delegate = self;
//    MKMapTypeStandard = 0, 标准地图
//    MKMapTypeSatellite, 卫星地图
//    MKMapTypeHybrid, 混合 1，0
//    MKMapTypeSatelliteFlyover
//    MKMapTypeHybridFlyover
    
    _mapview.mapType = 0;
    _mapview.showsUserLocation = YES;
    
    
//    MKUserTrackingModeNone = 0, 不跟踪
//    MKUserTrackingModeFollow, 跟踪
//    MKUserTrackingModeFollowWithHeading,
    _mapview.userTrackingMode = MKUserTrackingModeFollow;
    
    


}

//定位到用户位置是 回到用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {


    
     CLLocation *location = userLocation.location;
    
    //反地里编码
    CLGeocoder *reverseGeocoder = [[CLGeocoder alloc] init];
    
    [reverseGeocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 ||error)return ;
    
        
        CLPlacemark *pm = [placemarks lastObject];
        //userLocation 用户的位置 就是小圆点
        if(pm.locality){
        userLocation.title = pm.locality;
        }else{
            userLocation.title = pm.administrativeArea;
        }
//           userLocation.subtitle = pm.addressDictionary[@"Thoroughfare"];
        userLocation.subtitle = pm.name;
    }];
    
   
}



/**
 *  增加按钮返回用户所在位置
 */
-(void)backUserLocation{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem ];
    btn.frame = CGRectMake(10,30,100,50);
    [btn setTitle:@"🐷" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
}

- (void)back{
    [_mapview setRegion:MKCoordinateRegionMake(_mapview.userLocation.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
}


    MyAnnotation *an1 = [[MyAnnotation alloc] init];
    an1.coordinate = CLLocationCoordinate2DMake(34.765401, 113.625474);
    an1.title = @"鱼儿宾馆";
    an1.subtitle = @"有福利哦";
    [_mapview addAnnotation:an1];
}


//点击屏幕加
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    //找到触摸的点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    //把点转为地图的经纬度
    CLLocationCoordinate2D coordination = [_mapview convertPoint:point toCoordinateFromView:self.view];
    MyAnnotation *an = [[MyAnnotation alloc] init];
    an.coordinate = coordination;
    [_mapview addAnnotation:an];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
