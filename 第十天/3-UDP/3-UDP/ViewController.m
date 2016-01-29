//
//  ViewController.m
//  3-UDP
//
//  Created by qianfeng on 16/1/29.
//  Copyright © 2016年 Jane. All rights reserved.
//

#import "ViewController.h"
//tcp udp 通信的时候 socket 编程 套接字编程
//要IP地址 端口号
#import "GCDAsyncUdpSocket.h"

@interface ViewController ()<GCDAsyncUdpSocketDelegate>

@property (weak, nonatomic) IBOutlet UITextField *msgTF;
@property (weak, nonatomic) IBOutlet UITableView *tabview;
@property (nonatomic,strong) NSMutableArray *dataSource;


//通信的一个管道 Udp 可以 1对多 可以广播 局域网聊天
@property (nonatomic,strong) GCDAsyncUdpSocket *socket;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [NSMutableArray array];
    
    [self openUDPConnect];

}

//打开UDP连接
-(void)openUDPConnect{
    
    
    //1.代理 2. 代理执行的线程
    _socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    
    //绑定端口
    [_socket bindToPort:4333 error:nil];

    //广播 设置允许广播
    [_socket enableBroadcast:YES error:nil];

    
    //广播在哪里？ 有公用的 IP 地址 (保留的IP地址)
    
    [_socket joinMulticastGroup:@"224.0.0.2" error:nil];
    
    //启动接受线程
    //只接受一次
//    _socket receiveOnce:<#(NSError *__autoreleasing *)#>

    //开始接受别人的广播
    [_socket beginReceiving:nil];
}


-(void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self.dataSource addObject:str];
    [self.tabview reloadData];
    //让tableview 滑倒最下面

    [self.tabview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataSource.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Jane"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Jane"];
    }

    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //计算一下高度
    NSString *text = self.dataSource[indexPath.row];
    
    CGSize textsize = [text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 300)];
    return textsize.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMassage:(id)sender {
    
    //发送消息
    
    //字符串转二进制
    NSData *data = [_msgTF.text dataUsingEncoding:NSUTF8StringEncoding];
    
    //1.二进制数据 2.超时 -1不超时   3.标志 0
    [_socket sendData:data toHost:@"224.0.0.2" port:4333 withTimeout:-1 tag:0];
    
}

@end
