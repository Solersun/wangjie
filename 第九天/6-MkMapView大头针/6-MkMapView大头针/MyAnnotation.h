//
//  MyAnnotation.h
//  6-MkMapView大头针
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *subtitle;

//
@property (nonatomic,strong) UIImage *leftImage;

@property (nonatomic,copy) NSString *leftIamgeUrlStr;


@property (nonatomic,strong) UIImage *pinImage;
@end
