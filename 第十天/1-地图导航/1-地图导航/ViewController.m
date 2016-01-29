//
//  ViewController.m
//  1-地图导航
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textTF;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationmanager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 1;
    [self creatLocation];
}

-(void)creatLocation{
    
    _locationmanager = [[CLLocationManager alloc] init];
    if ([_locationmanager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationmanager requestAlwaysAuthorization];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btn:(id)sender {
    
    //地理编码CLgeocorder 根据文本会的径维度
    CLGeocoder *corder = [[CLGeocoder alloc]init];
    [corder geocodeAddressString:_textTF.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
       
        if (placemarks.count == 0 ||error )return;
        
        
        //起点坐标
        _mapView.userLocation.coordinate;
        
        //重点坐标
        CLPlacemark *pm =  [placemarks lastObject];
        
        
        MKMapItem *staritem = [MKMapItem mapItemForCurrentLocation];
                               
        MKMapItem *enditem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithPlacemark:pm]];
        
        
        
        //1.数组 起点 终点 的mapitem
        //2.导航的条件 步行 驾车
        [MKMapItem  openMapsWithItems:@[staritem,enditem] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:@YES}];
        
    }];
    
}

@end
