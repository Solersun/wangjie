//
//  MyAnnotation.h
//  POISearch热点检索
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface MyAnnotation : NSObject <MKAnnotation>


@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
