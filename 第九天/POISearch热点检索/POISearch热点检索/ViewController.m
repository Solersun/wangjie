//
//  ViewController.m
//  POISearch热点检索
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface ViewController ()<MKMapViewDelegate>
@property (nonatomic,strong) MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationmanager;

@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatLocation];
    [self creatDataSource];
    [self creatMapView];
    [self creatbtn];
}

- (void)creatDataSource{

    _dataSource = [NSMutableArray array];
    
    [_dataSource addObject:@"餐厅"];
    [_dataSource addObject:@"地铁站"];
    [_dataSource addObject:@"银行"];
    [_dataSource addObject:@"网吧"];
    [_dataSource addObject:@"酒店"];
    [_dataSource addObject:@"商场"];

}


-(void)creatLocation{
    
    _locationmanager = [[CLLocationManager alloc] init];
//    _locationmanager.distanceFilter = 10;
//    _locationmanager.desiredAccuracy = 10
    if ([_locationmanager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [_locationmanager requestAlwaysAuthorization];
    }
    
    [_locationmanager startUpdatingLocation];

}

- (void)creatMapView{

    
    _mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = 1;

    _mapView.mapType = MKMapTypeStandard;

}

//更新用户位置
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
    NSLog(@"跟新用具位置");
    
}


-(void)creatbtn{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem ];
    btn.frame = CGRectMake(10,30,100,50);
    [btn setTitle:@"附近列表" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(poi) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}


-(void)poi{

    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"附近" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [_dataSource enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击了%@",obj);
            [self search:obj];
        }];
        
        [alter addAction:action];
    }];

    [self presentViewController:alter animated:YES completion:^{
        
    }];


}

//在这个方法里搜索 附近的商店 POI检索 热点检索
-(void)search:(NSString *)obj{
    //搜索前删除地图上有的的大头针; 
    [_mapView removeAnnotations:_mapView.annotations];
    
    //创建搜索的请求
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    //设置搜索的关键字
    request.naturalLanguageQuery = obj;
    
    //搜索的范围，用户附近 设置跨度
    request.region = MKCoordinateRegionMake(_mapView.userLocation.coordinate,MKCoordinateSpanMake(0.02, 0.02));
//    request.region = _mapView.region;
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response.mapItems);
        
        //一个循环
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            MyAnnotation *anc = [[MyAnnotation alloc] init];
            
            anc.coordinate = obj.placemark.location.coordinate;
            
            anc.title = obj.name;
            anc.subtitle = obj.phoneNumber;
            
            [_mapView addAnnotation:anc];
            
        }];
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
