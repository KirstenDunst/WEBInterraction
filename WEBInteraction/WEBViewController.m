//
//  ViewController.m
//  WEBInteraction
//
//  Created by CSX on 2017/3/29.
//  Copyright © 2017年 宗盛商业. All rights reserved.
//

#import "WEBViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>



@interface WEBViewController ()<UIWebViewDelegate>
{
    UIWebView *web;
}
@end

@implementation WEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    /*
     NSURLRequestCachePolicy 缓存策略
     
     1> NSURLRequestUseProtocolCachePolicy = 0, 默认的缓存策略， 如果缓存不存在，直接从服务端获取。如果缓存存在，会根据response中的Cache-Control字段判断下一步操作，如: Cache-Control字段为must-revalidata, 则询问服务端该数据是否有更新，无更新的话直接返回给用户缓存数据，若已更新，则请求服务端.
     
     2> NSURLRequestReloadIgnoringLocalCacheData = 1, 忽略本地缓存数据，直接请求服务端.
     
     3> NSURLRequestIgnoringLocalAndRemoteCacheData = 4, 忽略本地缓存，代理服务器以及其他中介，直接请求源服务端.
     
     4> NSURLRequestReloadIgnoringCacheData = NSURLRequestReloadIgnoringLocalCacheData
     
     5> NSURLRequestReturnCacheDataElseLoad = 2, 有缓存就使用，不管其有效性(即忽略Cache-Control字段), 无则请求服务端.
     
     6> NSURLRequestReturnCacheDataDontLoad = 3, 死活加载本地缓存. 没有就失败. (确定当前无网络时使用)
     
     7> NSURLRequestReloadRevalidatingCacheData = 5, 缓存数据必须得得到服务端确认有效才使用(貌似是NSURLRequestUseProtocolCachePolicy中的一种情况)
     
     Tips: URL Loading System默认只支持如下5中协议: 其中只有http://和https://才有缓存策略.
     (1) http://
     (2) https://
     (3) ftp://
     (4) file://
     (5) data://
     */
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com/"] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10]];
    web.delegate = self;
    [self.view addSubview:web];
    
    UIButton *myCreateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    myCreateButton.frame = CGRectMake(self.view.frame.size.width-80, self.view.frame.size.width-80, 60, 60);
    myCreateButton.layer.cornerRadius = 30;
    myCreateButton.clipsToBounds = YES;
    [myCreateButton setBackgroundColor:[UIColor grayColor]];
    [myCreateButton setTitle:@"Back" forState:UIControlStateNormal];
    [myCreateButton addTarget:self action:@selector(buttonChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:myCreateButton];
}
- (void)buttonChoose:(UIButton *)sender{
    [web goBack];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //将要加载的页面的请求
    NSString *url = [[[request URL] absoluteString] stringByRemovingPercentEncoding];;
    NSLog(@"将要加载页面的网页处理url:%@",url);
    
    
    
    
    
    
    //判断是否是单击 (获取它加载的网页上面的事件，比如单击了图片，单击了按钮等等)
    /*
     UIWebViewNavigationTypeLinkClicked，用户触击了一个链接
     UIWebViewNavigationTypeFormSubmitted，用户提交了一个表单
     UIWebViewNavigationTypeBackForward，用户触击前进或返回按钮
     UIWebViewNavigationTypeReload，用户触击重新加载的按钮
     UIWebViewNavigationTypeFormResubmitted，用户重复提交表单
     UIWebViewNavigationTypeOther，发生其它行为
     */
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        NSURL *url = [request URL];
        if([[UIApplication sharedApplication]canOpenURL:url])
        {
            [[UIApplication sharedApplication]openURL:url options:@{} completionHandler:^(BOOL success) {
            }];
        }
        return NO;
    }
    
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    //这里处理开始加载网页时的处理
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    // 这里处理加载结束的时候处理的方式。
    //可以用来处理界面加载大小计算
//    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"document.body.clientWidth"];
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    context[@"passValue"] = ^{
        
        NSArray *arg = [JSContext currentArguments];
        for (id obj in arg) {
            NSLog(@"%@", obj);
        }
    };
    
    
    

    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //加载失败的时候走的是处理方法
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
