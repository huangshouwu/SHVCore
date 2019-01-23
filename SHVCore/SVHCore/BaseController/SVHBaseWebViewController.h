//
//  HSWBaseWebViewController.h
//  Lottery
//
//  Created by hsw on 15-4-23.
//  Copyright (c) 2015年 9188-MacPro1. All rights reserved.
//

@protocol HSWWebControllerDelegate;

@interface SVHBaseWebViewController : SVHBaseViewController<UIWebViewDelegate, UIActionSheetDelegate>{
@public
    UIWebView*         _webView;
}

@property (weak, nonatomic, readonly) UIWebView *webView;

@property (weak, nonatomic, readonly) NSURL *URL;

@property (copy,nonatomic)NSString* rootURLString;

@property (nonatomic, copy)     NSDictionary *parameters;//进入webController的时候传递的一些参数

/* 是否显示toolBar */
@property (nonatomic) BOOL      showToolBar;

@property (nonatomic, weak)   id<HSWWebControllerDelegate> delegate;

@property (nonatomic, strong ,readonly) UIBarButtonItem *activityItem;

- (void)openURL:(NSString*)urlString;

- (void)openRequest:(NSURLRequest*)request;

- (void)willStartLoadRequest:(NSURLRequest*)request;

- (void)reload;

@end

@protocol HSWWebControllerDelegate <NSObject>

@optional
- (BOOL)webController:(SVHBaseWebViewController *)controller webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
       navigationType:(UIWebViewNavigationType)navigationType;
- (void)webController:(SVHBaseWebViewController *)controller webViewDidStartLoad:(UIWebView *)webView;
- (void)webController:(SVHBaseWebViewController *)controller webViewDidFinishLoad:(UIWebView *)webView;
- (void)webController:(SVHBaseWebViewController *)controller webView:(UIWebView *)webView
 didFailLoadWithError:(NSError *)error;

@end
