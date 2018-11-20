//
//  GJTBaseViewController.m
//  Liaodao
//
//  Created by hsw on 2018/3/27.
//  Copyright © 2018年 LiaodaoSports. All rights reserved.
//

#import "GJTBaseViewController.h"
#import "GJTUIViewAdditions.h"
#import "UIViewController+BackButtonItem.h"
#import "GJTBaseMacros.h"
#import "GJTCommonTool.h"

@interface GJTBaseViewController ()<UIGestureRecognizerDelegate>{
    UITapGestureRecognizer* _gesture;
    BOOL _isPoping;
}

@end

@implementation GJTBaseViewController

- (void)dealloc{
    [self removeObservers];
    if (_gesture) {
        [self.view removeGestureRecognizer:_gesture];
    }
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.enabelPopGestureRecognizer = YES;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.enabelPopGestureRecognizer = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetViewFrame:NO];
    [self addTapGesture];
    [self addObservers];
//    self.navigationController.navigationBar.titleTextAttributes = [GJTAppConfig navigationBarTextAttribute];
//    self.view.backgroundColor = [GJTAppConfig backgroundColor];
    [self showBackItem];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // ios右滑返回处理
    if (self.enabelPopGestureRecognizer && [self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // ios右滑返回处理
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]){
        self.navigationController.interactivePopGestureRecognizer.enabled = self.enabelPopGestureRecognizer;
    }
}

- (void)resetViewFrame:(BOOL)isRoot{
    if (isRoot) {
        self.view.height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - GJTStatusBarHeight - CGRectGetHeight(self.navigationController.navigationBar.frame) - GJTTabBarHeight;
    }else {
        self.view.height = CGRectGetHeight([[UIScreen mainScreen] bounds]) - GJTStatusBarHeight - CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
}

- (void)addTapGesture{
    if (!_gesture) {
        _gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        _gesture.delegate = self;
        [self.view addGestureRecognizer:_gesture];
    }
}

- (void)remoeTapGesure{
    if (_gesture) {
         [self.view removeGestureRecognizer:_gesture];
    }
}

-(void)hideKeyboard {
    [self.view endEditing:YES];
}

- (void)addObservers{
    [self addKeyboardObserver];
}

- (void)removeObservers{
    [self removeKeyboardObserver];
}

- (void)addKeyboardObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardFrameDidChange:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)removeKeyboardObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification*)notification{
    NSValue* keyboardboundsValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSValue* keybardAnimatedValue = [[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    [keyboardboundsValue getValue:&_keyboardBounds];
    [keybardAnimatedValue getValue:&_keybardAnmiatedTimeinterval];
}

- (void)keyboardDidShow:(NSNotification*)notification{
    
}

- (void)keyboardWillHide:(NSNotification*)notification{
    
}

- (void)keyboardDidHide:(NSNotification*)notification{
    
}

- (void)keyboardFrameDidChange:(NSNotification *)notification{
    
}

#pragma mark UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (gestureRecognizer == _gesture) {
        UIView* baseCellView = [touch.view ancestorOrSelfWithClass:[UITableViewCell class]];
        UIView* baseCollectionView = [touch.view ancestorOrSelfWithClass:[UICollectionViewCell class]];
        UIView* baseControlView = [touch.view ancestorOrSelfWithClass:[UIControl class]];
        if ([touch.view isKindOfClass:[UIButton class]]){
            return NO;
        }else if ([touch.view isKindOfClass:[UIImageView class]]){
            return NO;
        }else if (baseCollectionView != nil){
            return NO;
        }else if (baseControlView != nil){
            return NO;
        }else if (baseCellView != nil){
            return NO;
        }else if ([touch.view isKindOfClass:[UIScrollView class]]){
            return YES;
        }else if (touch.view == self.view){
            return YES;
        } else{
            UIView* baseTableView = [touch.view ancestorOrSelfWithClass:[UITableView class]];
            UIView* baseScrollView = [touch.view ancestorOrSelfWithClass:[UIScrollView class]];
            if (baseTableView || baseScrollView) {
                return YES;
            }else {
                return NO;
            }
        }
    }else {
        return NO;
    }
}

@end
