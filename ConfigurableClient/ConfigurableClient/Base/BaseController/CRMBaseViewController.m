//
//  CRMBaseViewController.m
//  CRMSystemClient
//
//  Created by tongda ju on 2017/5/10.
//  Copyright © 2017年 juTongDa. All rights reserved.
//

#import "CRMBaseViewController.h"
#import "MBProgressHUD.h"
#import <IQKeyboardManager.h>
@interface CRMBaseViewController ()<UIAlertViewDelegate,UIGestureRecognizerDelegate>
{
    NSInteger _navigationStackCount;
    MBProgressHUD *_hud;
    MBProgressHUD *_completehud;
    
    void (^_alertHandleBlock)(NSInteger);
}
@property (nonatomic, strong) UIView * nodataView;

@end

@implementation CRMBaseViewController
@synthesize tableView=_tableView;
@synthesize dataSource=_dataSource;
@synthesize isRootController=_isRootController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= HH_MAIN_BG_COLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.extendedLayoutIncludesOpaqueBars=YES;
    self.navigationController.interactivePopGestureRecognizer.delegate =self;
    self.hideBackItemWhenRoot=YES;
    //设置为文字
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";

    [self resetBackItem];
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_navigationStackCount == self.navigationController.viewControllers.count) {
        [self viewWillPop];
    }
    _navigationStackCount = self.navigationController.viewControllers.count;
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.navigationController.viewControllers.count < _navigationStackCount) {
        [self viewDidPop];
    }
}
- (void)viewWillPop{
    //父类方法
}
- (void)viewDidPop {
    //父类方法
    
}
-(void)popOrDismissViewController{
    
}
-(void)popToViewControllerAtClass:(Class)aClass{
    
}
-(void)popToViewControllerAtIndex:(NSInteger)index{
    
}

#pragma mark -  navigationBar item

- (void)resetBackItem{
    if (!self.isRootController) {
        UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_item_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemTouchAction:)];
        self.navigationItem.leftBarButtonItem=item;
    }else{
        if (!self.hideBackItemWhenRoot) {
            UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_item_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backItemTouchAction:)];
            self.navigationItem.leftBarButtonItem=item;
            
        }
    }
}

- (void)backItemTouchAction:(id)sender{
    if (self.isModalAppear) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - getter
- (UITableView *)tableView{
    if (_tableView==nil) {
        _tableView=[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    return _tableView;
}
- (NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
-(BOOL)isRootController{
    if (self.navigationController.viewControllers.count>0) {
        _isRootController=(self.navigationController.viewControllers.firstObject==self);
    }
    return _isRootController;
}
#pragma mark - Override Super method
- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    if ([viewControllerToPresent isMemberOfClass:[CRMBaseViewController class]]) {
        ((CRMBaseViewController *)viewControllerToPresent).isModalAppear=YES;
    }else if ([viewControllerToPresent isMemberOfClass:[UINavigationController class]]){
        if ([((UINavigationController *)viewControllerToPresent).viewControllers.firstObject isMemberOfClass:[CRMBaseViewController class]]) {
            ((CRMBaseViewController *)((UINavigationController *)viewControllerToPresent).viewControllers.firstObject).isModalAppear=YES;
        }
    }
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}

#pragma mark - UIAlertView
/*!
 *  弹出一个系统自带alertView
 */
//- (void)showAlertTitle:(NSString *)title
//               message:(NSString *)msg
//                handle:(void (^)(NSInteger index))clickButtonAtIndex
//                cancle:(NSString *)cancle
//                others:(NSString *)others,...{
//    HHAlertView *alert=[HHAlertView alloc];
//    [alert initWithTitle:title
//                 message:msg
//              showTarget:self
//                  handle:clickButtonAtIndex
//                  cancle:cancle
//                  others:others,nil];
//    id eachObject;
//    va_list args;
//    va_start(args, others);
//    while ((eachObject=va_arg(args, id))) {
//        if (eachObject) {
//            [alert addButtonTitle:eachObject];
//        }
//    }
//    va_end(args);
//    
//}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 取消,确定
 */
- (void)showAlertMessage:(NSString *)msg
                  handle:(void (^)(NSInteger index))clickButtonAtIndex{
    [self showAlertTitle:@"提示" message:msg handle:clickButtonAtIndex cancle:@"取消" others:@"确定", nil];
}
/*!
 *  弹出一个简洁化系统alertView
 *  @title 提示
 *  @buttons 确定
 */
- (void)showNormalAlertMessage:(NSString *)msg
                        handle:(void (^)(NSInteger index))clickButtonAtIndex{
    [self showAlertTitle:@"提示" message:msg handle:clickButtonAtIndex cancle:nil others:@"确定", nil];
}

#pragma mark - MBProgressHUD

/*!
 *  显示一个带有文字和菊花的HUD,需要手动hide
 */
- (void)showHUDText:(NSString *)text{
    if (_hud==nil) {
        _hud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    _hud.removeFromSuperViewOnHide=YES;
    _hud.labelText=text;
    [self.view addSubview:_hud];
    [_hud show:YES];
}
/*!
 *  显示一个不带菊花的提示性HUD,自动hide
 *  如果迭代多个则按队列出现和影藏
 */
- (void)showToastHUD:(NSString *)text complete:(void (^)())complete{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabelText=text;
    hud.detailsLabelFont=[UIFont systemFontOfSize:15.0];
    hud.opacity=0.8;
    hud.margin = 15.f;
    [hud hide:YES afterDelay:1];
    hud.completionBlock=^(){
        if (complete) {
            complete();
        }
    };
    
    
}
- (void)showSuccessToast:(NSString *)text complete:(void (^)())complete{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText=text;
    hud.detailsLabelFont=[UIFont systemFontOfSize:15.0];
    hud.opacity=0.8;
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    
    UIImageView *cusview=[[UIImageView alloc] init];
    cusview.image=[UIImage imageNamed:@"smile_aio_default"];
    cusview.frame=CGRectMake(0, 0, 69, 69);
    hud.customView=cusview;
    [hud hide:YES afterDelay:2];
    
    hud.completionBlock=^(){
        if (complete) {
            complete();
        }
    };
    
    
    
}
- (void)showFailToast:(NSString *)text complete:(void (^)())complete{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeCustomView;
    hud.detailsLabelText=text;
    hud.detailsLabelFont=[UIFont systemFontOfSize:15.0];
    hud.opacity=0.8;
    hud.margin = 15.f;
    hud.removeFromSuperViewOnHide = YES;
    
    UIImageView *cusview=[[UIImageView alloc] init];
    cusview.image=[UIImage imageNamed:@"smile_aio_default_failed"];
    cusview.frame=CGRectMake(0, 0, 69, 69);
    hud.customView=cusview;
    [hud hide:YES afterDelay:2];
    
    hud.completionBlock=^(){
        if (complete) {
            complete();
        }
    };
}
/*!
 *  影藏HUD,适用于不能自动影藏的HUD
 */
- (void)hideHUD{
    [_hud hide:YES];
}


- (void)dealloc{
//    HHLog(@"%@",self);
    NSLog(@"%@ delloc",NSStringFromClass([self class]));

}
#pragma mark - touch
- (void)addLeftBarItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector {
    UIBarButtonItem *leftBarItem=[[UIBarButtonItem alloc] initWithImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:selector];
    
    self.navigationItem.leftBarButtonItem = leftBarItem;
}
- (void)addRightBarItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector {
    ;
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc] initWithImage: [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:target action:selector];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}
- (void)addRightTwoBarItemWithImage:(UIImage *)image image2:(UIImage *)image2 target:(id)target target2:(id)target2 action:(SEL)selector action2:(SEL)selector2{

    UIView * viewBackInNavi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    viewBackInNavi.backgroundColor=[UIColor clearColor];
    viewBackInNavi.userInteractionEnabled=YES;
    //右一
    UIButton *myRightRePaintBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    [myRightRePaintBtn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [myRightRePaintBtn setBackgroundColor:[UIColor clearColor]];
    [myRightRePaintBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [myRightRePaintBtn setImage:image forState:UIControlStateNormal];
    [myRightRePaintBtn setTitle:[NSString stringWithFormat:@" %@",NSLocalizedString(@"local_paintAgain", nil)] forState:UIControlStateNormal];
    myRightRePaintBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [viewBackInNavi addSubview:myRightRePaintBtn];
    
    //右二
    UIButton *myRightSubmitBtn=[[UIButton alloc]initWithFrame:CGRectMake(35, 0, 22, 22)];
    [myRightSubmitBtn addTarget:target2 action:selector2 forControlEvents:UIControlEventTouchUpInside];
    [myRightSubmitBtn setBackgroundColor:[UIColor clearColor]];
    [myRightSubmitBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [myRightSubmitBtn setImage:image2 forState:UIControlStateNormal];
    [myRightSubmitBtn setTitle:[NSString stringWithFormat:@" %@",NSLocalizedString(@"local_card", nil)] forState:UIControlStateNormal];
    myRightSubmitBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    [viewBackInNavi addSubview:myRightSubmitBtn];
    
    UIBarButtonItem * right=[[UIBarButtonItem alloc]initWithCustomView:viewBackInNavi];
    //将整个viewBackInNavi右移10
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width =-10;//负数为右移，正数为左移
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,right,nil];
}
- (void)reloadDataWith:(UIImage *)image title:(NSString *)title superView:(UIView *)superView supViewHeight:(CGFloat )height {
    self.nodataView =[[UIView alloc]initWithFrame:CGRectZero color:[UIColor clearColor]];
    [superView addSubview:self.nodataView];
    [self.nodataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(superView).offset(-(height?height:50));
        
        
//        make.left.right.equalTo(self.view).offset(0);
//        make.width.equalTo(@(HH_SCREEN_W));
        
//此处不当，已修改
        make.left.right.equalTo(superView).offset(0);
//        make.width.equalTo(@(HH_SCREEN_W));

        
        make.height.equalTo(@213);
    }];
    UIImageView * ima =[[UIImageView alloc] initWithImage:image];
    [self.nodataView addSubview:ima];
    [ima mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nodataView.mas_top).offset(0);
        make.centerX.equalTo(self.nodataView.mas_centerX);
        make.width.equalTo(@(237));
        make.height.equalTo(@148.5);
    }];
    CustomLab * messageLbl = [[CustomLab alloc]initWithFrame:CGRectZero font:14.0 aligment:NSTextAlignmentCenter text:title textcolor:kColorGray6];
    [self.nodataView addSubview:messageLbl];
    [messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.nodataView.mas_centerX);
        make.bottom.equalTo(self.nodataView.mas_bottom).offset(-10);
    }];    
    [self.nodataView setHidden:YES];
}
- (void)reloadDataWithStatus:(BOOL)isShow {
    [self.nodataView setHidden:isShow];
}
@end
