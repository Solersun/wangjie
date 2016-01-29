//
//  FoodDetail.m
//  2-分割视图
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "FoodDetail.h"

@interface FoodDetail ()

@end

@implementation FoodDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"菜系" style:UIBarButtonItemStylePlain target:self action:@selector(rightItem:)];
}

-(void)rightItem:(UIBarButtonItem *)btnItem{
    
    //iPad上另一个转悠分系统空间 不能再手机上用
    //容器 视图控制器
    Food *popVIew = [[Food alloc] init];
    UIPopoverController *pop = [[UIPopoverController alloc] initWithContentViewController:popVIew];
    
    popVIew.delegate = self;
    pop.popoverContentSize = CGSizeMake(200, 300);
    [pop presentPopoverFromBarButtonItem:btnItem permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}



-(void)didSelectRow:(NSInteger)row{
    
    self.title = [NSString stringWithFormat:@"第%ld道菜",row];

}




//是否影藏视图控制器
-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation {
    return NO;
}


//视图将要显示
-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {

    self.navigationItem.leftBarButtonItem = nil;

}

//将要隐藏
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {

    self.navigationItem.leftBarButtonItem =barButtonItem;
    barButtonItem.title = @"菜系";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
