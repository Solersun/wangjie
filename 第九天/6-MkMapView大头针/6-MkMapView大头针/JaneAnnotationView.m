//
//  JaneAnnotationView.m
//  6-MkMapView大头针
//
//  Created by qianfeng on 16/1/28.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "JaneAnnotationView.h"

@implementation JaneAnnotationView

+(instancetype)myAnnotationView:(MKMapView *)mapview{
    
    //检查复用队列有无可用视图
    
    JaneAnnotationView *anview = (JaneAnnotationView *)[mapview dequeueReusableAnnotationViewWithIdentifier:@"JANE"];
    
    if (!anview) {
        
        anview = [[JaneAnnotationView alloc] initWithAnnotation:nil  reuseIdentifier:@"Jane"];
        
        
        anview.canShowCallout = YES;

        //在这里可以自定义 左右视图 格式固定的视图 在这定义

    }

    return anview;
}


-(void)configData:(MyAnnotation *)myAnnotation{

    self.annotation = myAnnotation;
    
    self.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:myAnnotation.leftImage];
    
    self.image = myAnnotation.pinImage;
    
    //需要自定义视图 图片不固定 比如说店铺的照片
}

@end
