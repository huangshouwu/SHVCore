//
//  SVHBaseWebController.h
//  GreatBuildingMaster
//
//  Created by huang shervin on 2018/11/22.
//  Copyright © 2018年 huang shervin. All rights reserved.
//

#import <SVHCore/SVHCore.h>
#import "SVHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SVHBaseWebController : SVHBaseViewController

@property (nonatomic,strong)WKWebView* webView;
@property (nonatomic,strong)WKWebViewConfiguration* configuration;
@property (nonatomic,copy)NSString* url;
@property (nonatomic,copy)NSString* navTitle;

- (void)reload;

@end

@protocol SVHBaseWebControllerProtocal <NSObject>

@optional
- (void)controller:(SVHBaseWebController*)controller webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
- (void)controller:(SVHBaseWebController*)controller webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;
- (void)controller:(SVHBaseWebController*)controller webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error;
- (void)controller:(SVHBaseWebController*)controller webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
