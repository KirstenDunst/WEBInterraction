//
//  WKWEBViewController.m
//  WEBInteraction
//
//  Created by CSX on 2017/3/29.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "WKWEBViewController.h"
#import <WebKit/WebKit.h>

typedef enum :NSInteger{
    buttonTag = 10,
    clearBtnTag = 20,
}tags;

@interface WKWEBViewController ()<WKScriptMessageHandler>

@property(nonatomic , strong) WKWebView *wkWebView;

@end

@implementation WKWEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18;
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height/2) configuration:config];
    [self.view addSubview:self.wkWebView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.wkWebView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    
    WKUserContentController *userCC = config.userContentController;
    //JS调用OC 添加处理脚本
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"showName"];
    [userCC addScriptMessageHandler:self name:@"showSendMsg"];
    
    [self createButton];
}
- (void)createButton{
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height/2, self.view.frame.size.width, self.view.frame.size.height/2)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    UIButton *myCreateBut = [UIButton buttonWithType:UIButtonTypeSystem];
    myCreateBut.frame = CGRectMake(20, 20, 60, 40);
    myCreateBut.tag = clearBtnTag;
    [myCreateBut setBackgroundColor:[UIColor greenColor]];
    [myCreateBut setTitle:@"Clear" forState:UIControlStateNormal];
    [myCreateBut addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:myCreateBut];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 0, 200, 40);
    label.text = @"小红：18870707070";
    label.textAlignment = 1;
    [bgView addSubview:label];
    
    NSArray *arr = @[@"小黄的手机号",@"打电话给小黄",@"给小黄发短信"].copy;
    for (int i = 0; i<3; i++) {
        UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeSystem];
        myCreateButton.frame = CGRectMake(self.view.frame.size.width-170, 70+50*i, 150, 40);
        myCreateButton.tag = buttonTag+i;
        [myCreateButton setBackgroundColor:[UIColor greenColor]];
        [myCreateButton setTitle:arr[i] forState:UIControlStateNormal];
        [myCreateButton addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:myCreateButton];
    }
    
    
    
}

- (void)buttonChoose:(UIButton *)sender{
    if (!self.wkWebView.loading) {
        switch (sender.tag-buttonTag) {
            case 0:
            {
                [self.wkWebView evaluateJavaScript:@"alertMobile()" completionHandler:^(id _Nullable response, NSError * _Nullable error) {
                    //TODO
                    NSLog(@"%@ %@",response,error);
                }];
            }
                break;
            case 1:
            {
                [self.wkWebView evaluateJavaScript:@"alertName('小红')" completionHandler:nil];
            }
                break;
            case 2:
            {
                [self.wkWebView evaluateJavaScript:@"alertSendMsg('18870707070','周末爬山真是件愉快的事情')" completionHandler:nil];
            }
                break;
            case 10:
            {
                [self.wkWebView evaluateJavaScript:@"clear()" completionHandler:nil];
            }
                break;
                
                
            default:
                
                break;
        }
        
    } else {
        NSLog(@"the view is currently loading content");
    }
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"选择：%@",NSStringFromSelector(_cmd));
    NSLog(@"消息的body实质：%@",message.body);
    NSLog(@">>>>>>>>>>>>%@",message);
    if ([message.name isEqualToString:@"showMobile"]) {
        [self showMsg:@"我是下面的小红 手机号是:18870707070"];
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        NSString *info = [NSString stringWithFormat:@"你好 %@, 很高兴见到你",message.body];
        [self showMsg:info];
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        NSArray *array = message.body;
        NSString *info = [NSString stringWithFormat:@"这是我的手机号: %@, %@ !!",array.firstObject,array.lastObject];
        [self showMsg:info];
    }
}

- (void)showMsg:(NSString *)msg {
    [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil] show];
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
