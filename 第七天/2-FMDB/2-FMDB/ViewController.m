//
//  ViewController.m
//  2-FMDB
//
//  Created by qianfeng on 16/1/26.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
#include "DataBaseManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DataBaseManager *manager = [DataBaseManager shareManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
