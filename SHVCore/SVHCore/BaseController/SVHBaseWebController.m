//
//  SVHBaseWebController.m
//  GreatBuildingMaster
//
//  Created by huang shervin on 2018/11/22.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import "SVHBaseWebController.h"

@interface SVHBaseWebController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) UIBarButtonItem *activityItem;

@end

@implementation SVHBaseWebController

- (void)dealloc{
    self.webView.UIDelegate = nil;
    self.webView.navigationDelegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    [self openURL:self.url];
}

- (UIBarButtonItem*)activityItem{
    if (!_activityItem) {
        UIActivityIndicatorView* spinner =
        [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
         UIActivityIndicatorViewStyleWhite];
        [spinner startAnimating];
        _activityItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    }
    return _activityItem;
}

- (WKWebViewConfiguration*)configuration{
    if (!_configuration) {
        _configuration = [[WKWebViewConfiguration alloc] init];
        // 设置偏好设置
        _configuration.preferences = [[WKPreferences alloc] init];
        _configuration.allowsInlineMediaPlayback = YES;
        _configuration.selectionGranularity = YES;
        
        // 默认认为YES
        _configuration.preferences.javaScriptEnabled = YES;
        // 在iOS上默认为NO，表示不能自动通过窗口打开
        _configuration.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        // web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建
        _configuration.processPool = [[WKProcessPool alloc] init];
        
    }
    return _configuration;
}

- (WKWebView*)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:self.configuration];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.allowsBackForwardNavigationGestures = YES;
    }
    return _webView;
}

- (void)openURL:(NSString*)url{
    if (url.length) {
        if ([url hasPrefix:@"http://"] || [url hasPrefix:@"https://"]) {
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
        }else {
            SVHLog(@"无效的url:%@",url);
        }
    }
}

- (void)reload{
    [self.webView reload];
}

#pragma WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.navigationItem.title = @"加载中...";
    if (!self.navigationItem.rightBarButtonItem) {
        [self.navigationItem setRightBarButtonItem:self.activityItem animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //执行JS方法获取导航栏标题
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        NSString* navTitle = [title stringByRemovingPercentEncoding];
        if (navTitle.length) {
            self.navigationItem.title = navTitle;
        }else {
            self.navigationItem.title = self.navTitle;
        }
    }];
    
    if (self.navigationItem.rightBarButtonItem == self.activityItem) {
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    }
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self webView:webView didFinishNavigation:navigation];
    SVHLog(@"%@",error);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [self webView:webView didFinishNavigation:navigation];
    SVHLog(@"%@",error);
}


@end
