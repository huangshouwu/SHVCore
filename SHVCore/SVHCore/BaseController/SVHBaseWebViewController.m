//
//  HSWBaseWebViewController.m
//  Lottery
//
//  Created by hsw on 15-4-23.
//  Copyright (c) 2015年 9188-MacPro1. All rights reserved.
//

#import "SVHBaseWebViewController.h"

static NSString * const NOEEOutsideChain = @"outsideChain=1";
@interface SVHBaseWebViewController (){
        
    UIBarButtonItem*  _backButton;
    UIBarButtonItem*  _forwardButton;
    UIBarButtonItem*  _refreshButton;
    UIBarButtonItem*  _stopButton;
    UIBarButtonItem*  _actionButton;
    UIBarButtonItem*  _activityItem;
    
    NSURL*            _loadingURL;
    
    UIActionSheet*    _actionSheet;
}

@property (nonatomic,strong)UIToolbar *toolbar;

@end

@implementation SVHBaseWebViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        self.showToolBar = NO;
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)backAction {
    [self.webView goBack];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)forwardAction {
    [self.webView goForward];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshAction {
    [self.webView reload];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)stopAction {
    [self.webView stopLoading];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)shareAction {
    if (nil == _actionSheet) {
        _actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                     destructiveButtonTitle:nil
                                          otherButtonTitles:@"在Safari中打开",
                        nil];
        [_actionSheet showInView:self.view];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController

- (CGFloat)toolbarHeight{
    if (self.showToolBar) {
        return 44.0f;
    }else {
        return 0.0f;
    }
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
//    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, NOEEBottomSafeMargin, 0);
}

- (UIWebView*)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - [self toolbarHeight] - NOEEBottomSafeMargin)];
        _webView.delegate = self;
//        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth
//        | UIViewAutoresizingFlexibleHeight;
        
//        _webView.backgroundColor = [UIColor whiteColor];
//        _webView.scrollView.backgroundColor = [UIColor whiteColor];
        
        if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f) {
            if ([_webView.scrollView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
                if (@available(iOS 11.0, *)) {
                    _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
                }
            }
        }
        
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (UIToolbar*)toolbar{
    if (!_toolbar) {
        
        _backButton =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backIcon.png"]
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(backAction)];
        _backButton.tag = 2;
        _backButton.enabled = NO;
        _forwardButton =
        [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"forwardIcon.png"]
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(forwardAction)];
        _forwardButton.tag = 1;
        _forwardButton.enabled = NO;
        _refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                          UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction)];
        _refreshButton.tag = 3;
        _stopButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                       UIBarButtonSystemItemStop target:self action:@selector(stopAction)];
        _stopButton.tag = 3;
        _actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                         UIBarButtonSystemItemAction target:self action:@selector(shareAction)];
        
        UIBarItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                             UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        _toolbar = [[UIToolbar alloc] initWithFrame:
                    CGRectMake(0, self.view.height - [self toolbarHeight],
                               self.view.width, [self toolbarHeight])];
        _toolbar.autoresizingMask =
        UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _toolbar.tintColor = NOEE_RGBCOLOR(109, 132, 162);
        _toolbar.items = [NSArray arrayWithObjects:
                          _backButton,
                          space,
                          _forwardButton,
                          space,
                          _refreshButton,
                          space,
                          _actionButton,
                          nil];
    }
    return _toolbar;
}

- (void)loadView{
    [super loadView];
    [self.view addSubview:self.webView];
    
    if (self.showToolBar) {
        [self.view addSubview:self.toolbar];
    }
    
    UIActivityIndicatorView* spinner =
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
      UIActivityIndicatorViewStyleWhite];
    [spinner startAnimating];
    _activityItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [super viewDidUnload];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [self.view.window makeKeyWindow];
    [super viewWillDisappear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark -
#pragma mark UIWebViewDelegate

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request
 navigationType:(UIWebViewNavigationType)navigationType {
    if ([_delegate respondsToSelector:
         @selector(webController:webView:shouldStartLoadWithRequest:navigationType:)] &&
        ![_delegate webController:self webView:webView
       shouldStartLoadWithRequest:request navigationType:navigationType]) {
            return NO;
        }
    
    _loadingURL = request.URL;
    [self reloadToolbarItemState];
    return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidStartLoad:(UIWebView*)webView {
    if ([_delegate respondsToSelector:@selector(webController:webViewDidStartLoad:)]) {
        [_delegate webController:self webViewDidStartLoad:webView];
    }
    
    self.navigationItem.title = @"加载中...";
    if (!self.navigationItem.rightBarButtonItem) {
        [self.navigationItem setRightBarButtonItem:_activityItem animated:YES];
    }
    [self replaceToolbarItemWithTag:3 withItem:_stopButton];
    [self reloadToolbarItemState];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webViewDidFinishLoad:(UIWebView*)webView {
    if ([_delegate respondsToSelector:@selector(webController:webViewDidFinishLoad:)]) {
        [_delegate webController:self webViewDidFinishLoad:webView];
    }
    
    _loadingURL = nil;
    self.navigationItem.title = nil;//[_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (self.navigationItem.rightBarButtonItem == _activityItem) {
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
    }
    [self replaceToolbarItemWithTag:3 withItem:_refreshButton];
    
    [self reloadToolbarItemState];
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)webView:(UIWebView*)webView didFailLoadWithError:(NSError*)error {
    if ([_delegate respondsToSelector:@selector(webController:webView:didFailLoadWithError:)]) {
        [_delegate webController:self webView:webView didFailLoadWithError:error];
    }
    
    
    [self webViewDidFinishLoad:webView];
}


///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)reloadToolbarItemState{
    if (self.showToolBar) {
        _backButton.enabled = [self.webView canGoBack];
        _forwardButton.enabled = [self.webView canGoForward];
    }
}

- (void)replaceToolbarItemWithTag:(NSInteger)tag withItem:(UIBarButtonItem*)item {
    if (self.showToolBar) {
        NSInteger buttonIndex = 0;
        for (UIBarButtonItem* button in self.toolbar.items) {
            if (button.tag == tag) {
                NSMutableArray* newItems = [NSMutableArray arrayWithArray:self.toolbar.items];
                [newItems replaceObjectAtIndex:buttonIndex withObject:item];
                self.toolbar.items = newItems;
                break;
            }
            ++buttonIndex;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIActionSheetDelegate


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[UIApplication sharedApplication] openURL:self.URL];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSURL*)URL {
    return _loadingURL ? _loadingURL : self.webView.request.URL;
}

- (void)reload{
    if (self.rootURLString.length) {
        [self openURL:self.webView.request.URL.absoluteString];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)openURL:(NSString*)urlString {
    self.rootURLString = urlString;
    /** 重设请求链接的https 头 */
    urlString = NOEEResetTransferMathed(urlString);
    NSURL *url = [NSURL URLWithString:NOEEResetURL(urlString,NO)];
    /* 使客户端与h5互通,将token信息设置进cookie */
    setTokenToCookies(url);
    
    //  链接中含有外链则记录cookie,自动登陆
    if (contentString(urlString, NOEEOutsideChain)) {
        NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        if (url.absoluteString.length) {
            NSHTTPCookie *cookie1 = createCookieWithDomain(url.host, url.path,urlString, nil);
            [cookieStorage setCookie:cookie1];
        }
    }
    
    NSURLRequest* request = [NSMutableURLRequest requestWithURL:url];//[NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0f];//[NSMutableURLRequest requestWithURL:url];
    [self openRequest:request];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)openRequest:(NSURLRequest*)request {
    [self view];
    [self willStartLoadRequest:request];
    self.rootURLString = request.URL.absoluteString;
    [self addUAToWebViewUserAgent:self.webView];
    [self.webView loadRequest:request];
}

- (void)addUAToWebViewUserAgent:(UIWebView*)webView{
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newUagent = [NSString stringWithFormat:@"%@;ios_app",secretAgent];
    NSDictionary *dictionary = [[NSDictionary alloc]
                                initWithObjectsAndKeys:newUagent, @"User-Agent",newUagent,@"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)willStartLoadRequest:(NSURLRequest*)request{
    
}

@end
