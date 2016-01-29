//
//  JaneAnnotationView.h
//  6-MkMapView大头针
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "MyAnnotation.h"
@interface JaneAnnotationView : MKAnnotationView


//用类方法实现
+(instancetype)myAnnotationView:(MKMapView *)mapview;


-(void)configData:(MyAnnotation *)myAnnotation;

@end
