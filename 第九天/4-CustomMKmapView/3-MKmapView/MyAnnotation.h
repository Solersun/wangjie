//
//  MyAnnotation.h
//  3-MKmapView
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject <MKAnnotation>

//经纬度 是必选的协议属性
@property (nonatomic,assign)CLLocationCoordinate2D coordinate;

//可选的属性
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;

@end
