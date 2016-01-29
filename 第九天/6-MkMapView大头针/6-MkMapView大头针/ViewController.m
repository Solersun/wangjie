//
//  ViewController.m
//  6-MkMapView大头针
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
#import "JaneAnnotationView.h"
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mybtn;
@property (strong, nonatomic)  MKMapView *mapView;
//定位管理器 ios8 以后
@property (nonatomic,strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatManager];
    [self creatMapView];
    

    
}
- (IBAction)addAnnotation:(id)sender {
    
    //点击按钮添加大头针
    
    MyAnnotation *an1 = [[MyAnnotation alloc] init];
    an1.coordinate = CLLocationCoordinate2DMake(34.774401, 113.638474);
    an1.title = @"鱼儿大保健";
    an1.subtitle = @"阿伟快来";
    
    an1.leftImage = [UIImage imageNamed:@"location"];
    an1.pinImage = [UIImage imageNamed:@"location"];
    
    [_mapView addAnnotation:an1];
    
}


-(void)creatManager{
    
    _locationManager =[[CLLocationManager alloc] init];
    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationManager requestAlwaysAuthorization];
    }

}

- (void)creatMapView{
    
    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    
    //显示用户所在位置 并设置跟踪
    _mapView.showsUserLocation = YES;
    
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [self.view sendSubviewToBack:_mapView];

}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
            return nil;
        }
    //创建大头针
    JaneAnnotationView *anview = [JaneAnnotationView myAnnotationView:mapView];
    
    [anview configData:annotation];
    return anview;

}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
//    
//    if ([annotation isKindOfClass:[MKUserLocation class]]) {
//        return nil;
//    }
//    
//    MKAnnotationView *myAnnotation = [mapView dequeueReusableAnnotationViewWithIdentifier:@"Jane"];
//    
//    if (!myAnnotation) {
//        myAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Jane"];
//    }
//    
//    //提供可供定义的视图 左右视图
//    
////    myAnnotation.leftCalloutAccessoryView ;
////    myAnnotation.rightCalloutAccessoryView;
//    //这个事大头针的图片
////    myAnnotation.image;
//    
//    //左边的图片
//    UIButton *btnleft = [UIButton buttonWithType:UIButtonTypeContactAdd];
//    myAnnotation.leftCalloutAccessoryView = btnleft;
//    
//    myAnnotation.annotation = annotation;
//    //image
//    myAnnotation.image = [UIImage imageNamed:@"location"];
//    
//    //右边的图片
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"location"]];
//    myAnnotation.rightCalloutAccessoryView = imageView;
//    
//    
//    myAnnotation.canShowCallout = YES;
//    
//    return myAnnotation;
//    
//
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
