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
    [_mapview setRegion:MKCoordinateRegionMake(_mapview.userLocation.coordinate, MKCoordinateSpanMake(0.05, 0.05)) animated:YES];
     [self addAnnotation];
}

-(void)addAnnotation{
    MyAnnotation *an1 = [[MyAnnotation alloc] init];
    an1.coordinate = CLLocationCoordinate2DMake(34.765401, 113.625474);
    an1.title = @"鱼儿宾馆";
    an1.subtitle = @"有福利哦";
    [_mapview addAnnotation:an1];
    
}


//点击屏幕加
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    [super touchesBegan:touches withEvent:event];
//    
//    //找到触摸的点
//    CGPoint point = [[touches anyObject] locationInView:self.view];
//    
//    //把点转为地图的经纬度
//    CLLocationCoordinate2D coordination = [_mapview convertPoint:point toCoordinateFromView:self.view];
//    MyAnnotation *an = [[MyAnnotation alloc] init];
//    an.coordinate = coordination;
//    [_mapview addAnnotation:an];
//    
//}


-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    //判断一下 是系统的蓝色的大头真 还是自己定义的大头针
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //是系统的
        //返回nil 就默认 使用系统的大头针 并默认其看不见
        
        return nil;
    }else{
        
        NSLog(@"就是我们自定义的大头针");
        MKPinAnnotationView *pinAnnotation =(MKPinAnnotationView *)[_mapview dequeueReusableAnnotationViewWithIdentifier:@"anvid"];
        //如果没找到就去创建
        if (!pinAnnotation) {
            pinAnnotation = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"anvid"];
            
        }
        
        //设置大头针视图
        
        pinAnnotation.pinTintColor = [UIColor cyanColor];
        
        //可以设置弹框是否可以弹出
        pinAnnotation.canShowCallout = NO;
        
        //可以设置大头针 性天儿降
        pinAnnotation.animatesDrop = NO;
        
        return pinAnnotation;
        
    }
}



/**
 *  当大头针添加到地图是 会调用此方法
 */
-(void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views{
    //若果要做动画要在这里面添加
    
    for (MKAnnotationView *view in views) {
        //判断是不是系统的大头针
        if (![view.annotation isKindOfClass:[MKUserLocation class]]) {
            //如果不是系统的大头针
            //拿到最终的大头针
            CGRect endFrame = view.frame;
            //改变他的Y坐标
            view.frame = CGRectMake(endFrame.origin.x, 0, endFrame.size.width, endFrame.size.height);
            [UIView animateWithDuration:0.5 animations:^{
                view.frame = endFrame;
            }];
        }
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
