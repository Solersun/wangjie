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
@interface ViewController ()<MKMapViewDelegate>
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
        
        //在屏幕上画出起点到终点的路线
        
        //1.发起导航的请求
        MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
        
        request.source = staritem;
        request.destination = enditem;
        
        MKDirections *dict = [[MKDirections alloc] initWithRequest:request];
        //计算导航结果
        [dict calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
            //response.routes 路线是个数组
            if (response.routes.count == 0 ||error) {
                NSLog(@"没找到路线");
                return ;
            }
            
            [response.routes enumerateObjectsUsingBlock:^(MKRoute * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                //得到一条路线
                MKPolyline *line = obj.polyline;
                
                //地图上话一条路线
                [_mapView addOverlay:line];
                
            }];
            
            
            
        }];
        
    }];
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
 
    MKPolylineRenderer *render = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    render.strokeColor = [UIColor redColor];
//    render.lineWidth = ;
    return render;
    
}


@end
