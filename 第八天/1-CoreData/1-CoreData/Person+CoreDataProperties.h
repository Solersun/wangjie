//
//  Person+CoreDataProperties.h
//  1-CoreData
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *age;

@end

NS_ASSUME_NONNULL_END
