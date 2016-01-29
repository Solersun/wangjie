//
//  Detail.m
//  3-UIImagePicker
//
//  Created by qianfeng on 16/1/27.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "Detail.h"
#import "Student+CoreDataProperties.h"
#import "MagicalRecord.h"
@interface Detail ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    UIImagePickerController *pick;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTf;
@property (weak, nonatomic) IBOutlet UITextField *ageTf;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation Detail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageView)];
    self.iconImageView.userInteractionEnabled =YES;

    [self.iconImageView addGestureRecognizer:tap];
    self.iconImageView.backgroundColor = [UIColor lightGrayColor];
    [self creatRight];
}

-(void)creatRight{

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightPress)];
}

- (void)rightPress{
    
    Student *stu = [Student MR_createEntity];
    stu.name = _nameTf.text;
    stu.age = @(_ageTf.text.integerValue);
    UIImage *image = _iconImageView.image;
    //图片转二进制
    stu.iconImageData = UIImagePNGRepresentation(image);
    //第二种图片转二进制
    //1.图片 2.压缩质量
//    UIImageJPEGRepresentation(image, 0.5);
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    //传值个上一个几面
    if (_block) {
        self.block();
    }
    [self dismissViewControllerAnimated:YES completion:^{
       
    }];
}


-(void)tapImageView{
    
    pick = [[UIImagePickerController alloc] init];
        //设置代理
    pick.delegate = self;
//    UIImagePickerControllerSourceTypePhotoLibrary, 图片资源
//    UIImagePickerControllerSourceTypeCamera, 相机
//    UIImagePickerControllerSourceTypeSavedPhotosAlbum 相册
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:pick animated:YES completion:nil];
    
}


//选择一张图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //info 存的图片信息
    NSLog(@"%@",info);
    UIImage *image =info[UIImagePickerControllerOriginalImage];
    
    _iconImageView.image = image;
    [pick dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

//取消选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
 
    
    [pick dismissViewControllerAnimated:YES completion:^{
        
    }];
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
