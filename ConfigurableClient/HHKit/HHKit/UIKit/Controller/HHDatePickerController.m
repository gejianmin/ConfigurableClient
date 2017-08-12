//
//  HHDatePickerController.m
//  LoginAPI
//
//  Created by LWJ on 2016/10/19.
//  Copyright © 2016年 gejianmin. All rights reserved.
//

#import "HHDatePickerController.h"
#import "HHBlurView.h"
#import "UIView+Util.h"
#define HHKIT_SCREEN_H [UIScreen mainScreen].bounds.size.height
//屏幕的宽带
#define HHKIT_SCREEN_W [UIScreen mainScreen].bounds.size.width


#pragma mark - present animation interface
@interface _HHDatePickerPresent : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property (nonatomic, assign) CGRect presentRect;
@property (nonatomic, assign) HHDatePickerStyle datePickerStyle;

@end
@interface _HHDatePickerPresentController : UIPresentationController
@property (nonatomic, assign) CGRect presentRect;
@property (nonatomic, assign) HHDatePickerStyle datePickerStyle;

@end

#pragma mark - date picker
@interface HHDatePickerController ()
@property (nonatomic, strong) _HHDatePickerPresent *transition;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIDatePicker *endDatePicker;
@property (nonatomic, assign) CGRect presentRect;
@property (nonatomic, strong) HHBlurView *blurContentView;
@property (nonatomic, strong) HHBlurView *blurButtonView;

@end

@implementation HHDatePickerController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.datePickerStyle=HHDatePickerStyleNormal;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (_datePickerStyle==HHDatePickerStyleNormal) {
        self.view.backgroundColor=[UIColor whiteColor];
        [self setupNormalDatePicker];
    }else if (_datePickerStyle==HHDatePickerStyleActionSheet ){
        self.view.backgroundColor=[UIColor clearColor];
        [self setupActionDatePicker];
    }else if (_datePickerStyle==HHDatePickerStyleAlert){
        self.view.backgroundColor=[UIColor clearColor];
        [self setupAlertDatePicker];
    }
}
-(void)setDatePickerStyle:(HHDatePickerStyle)datePickerStyle{
    _datePickerStyle=datePickerStyle;
    if (_datePickerStyle==HHDatePickerStyleNormal) {
        self.presentRect=CGRectMake(0, HHKIT_SCREEN_H-304, HHKIT_SCREEN_W, 304);
    }else if (_datePickerStyle==HHDatePickerStyleActionSheet ){
        self.presentRect=CGRectMake(0, HHKIT_SCREEN_H-340, HHKIT_SCREEN_W, 340);;
    }else if (_datePickerStyle==HHDatePickerStyleAlert){
        self.presentRect=CGRectMake(0, HHKIT_SCREEN_H-340, HHKIT_SCREEN_W, 340);
    }

}
-(_HHDatePickerPresent *)transition{
    if (_transition==nil) {
        _transition=[[_HHDatePickerPresent alloc] init];
        _transition.presentRect=self.presentRect;
        _transition.datePickerStyle=_datePickerStyle;
    }
    return _transition;
}
- (UIView *)containerView{
    if (_containerView==nil) {
        _containerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, _presentRect.size.width, _presentRect.size.height)];
        _containerView.backgroundColor=[UIColor whiteColor];
    }
    return _containerView;
}
-(UIDatePicker *)endDatePicker{
    if (_endDatePicker==nil) {
        _endDatePicker=[[UIDatePicker alloc] init];
        _endDatePicker.datePickerMode=self.datePickerMode;
        _endDatePicker.minimumDate=[NSDate date];
    }
    return _endDatePicker;
}

-(UIDatePicker *)datePicker{
    if (_datePicker==nil) {
        _datePicker=[[UIDatePicker alloc] init];
        _datePicker.datePickerMode=self.datePickerMode;
    }
    return _datePicker;
}
-(HHBlurView *)blurContentView{
    if (_blurContentView==nil) {
        _blurContentView=[[HHBlurView alloc] init];
        _blurContentView.frame=CGRectMake(10, 0, _presentRect.size.width-20, 260);
        _blurContentView.cornerRadius=15.f;
        _blurContentView.clipsToBounds=YES;
        _blurContentView.userInteractionEnabled=YES;
        
    }
    return _blurContentView;
}
- (HHBlurView *)blurButtonView{
    if (_blurButtonView==nil) {
        _blurButtonView=[[HHBlurView alloc] init];
        _blurButtonView.cornerRadius=15.f;
        _blurButtonView.clipsToBounds=YES;
        _blurButtonView.frame=CGRectMake(10, _presentRect.size.height-60-10, _presentRect.size.width-20, 60);
        UIButton *btn=[[UIButton alloc] init];
        btn.frame=_blurButtonView.bounds;
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(comfirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_blurButtonView addSubview:btn];
        
        _blurButtonView.userInteractionEnabled=YES;
        
    }
    return _blurButtonView;
    
}
- (void)setupNormalDatePicker{
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    
    UIBarButtonItem *fistItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleItemClick)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *finishItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(comfirmButtonAction)];
    
    toolBar.items = @[fistItem,flexItem,finishItem];
    
    toolBar.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    [toolBar addTopLine:0.5];
    [self.containerView addSubview:toolBar];

    if (self.dateBucket) {
        self.datePicker.frame=CGRectMake(0, toolBar.maxY, self.containerView.width/2, self.containerView.height-44);
        self.endDatePicker.frame=CGRectMake(self.datePicker.maxX, toolBar.maxY, self.containerView.width/2, self.containerView.height-44);

        [self.containerView addSubview:self.datePicker];
        [self.containerView addSubview:self.endDatePicker];
    }else{
        self.datePicker.frame=CGRectMake(0, toolBar.maxY, self.containerView.width, self.containerView.height-44);
        [self.containerView addSubview:self.datePicker];
    }
    [self.view addSubview:self.containerView];

 
}
- (void)setupActionDatePicker{
    if (self.dateBucket) {
        self.datePicker.frame=CGRectMake(0, 0, self.blurContentView.width/2, self.blurContentView.height);
        self.endDatePicker.frame=CGRectMake(self.datePicker.maxX, 0, self.blurContentView.width/2, self.blurContentView.height);

        [self.blurContentView addSubview:self.datePicker];
        [self.blurContentView addSubview:self.endDatePicker];
    }else{
        self.datePicker.frame=CGRectMake(0, 0, self.blurContentView.width, self.blurContentView.height);
        [self.blurContentView addSubview:self.datePicker];
    }
    [self.view addSubview:self.blurContentView];
    [self.view addSubview:self.blurButtonView];

}
- (void)setupAlertDatePicker{
    if (self.dateBucket) {
        
    }else{
        
    }
}
- (void)cancleItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)comfirmButtonAction{
    HHDate *date=[[HHDate alloc] init];
    date.dateBucket=self.dateBucket;
    if (self.dateBucket) {
        date.startDate=self.datePicker.date;
        date.endDate=self.endDatePicker.date;
    }else{
        date.date=self.datePicker.date;
    }
    if ([self.delegate respondsToSelector:@selector(datePicker:didSelectedDate:)]) {
        [self.delegate datePicker:self didSelectedDate:date];
    }
    if (self.didSelectDateBlock) {
        self.didSelectDateBlock(date);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)showInViewController:(UIViewController *)viewController{
    self.transitioningDelegate = self.transition;
    
    self.modalPresentationStyle = UIModalPresentationCustom;
    
    [viewController presentViewController:self animated:YES completion:nil];
}
@end
#pragma mark - present animation impl

@implementation _HHDatePickerPresentController

-(void)containerViewWillLayoutSubviews{
    self.presentedView.frame = self.presentRect;
    UIView *baffle = [self baffleView];
    [self.containerView insertSubview:baffle atIndex:0];
    
}

- (UIView *)baffleView{
    
    UIView *baffle = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    if (_datePickerStyle==HHDatePickerStyleNormal) {
        baffle.backgroundColor = [UIColor clearColor];
    }else if (_datePickerStyle==HHDatePickerStyleActionSheet ||_datePickerStyle==HHDatePickerStyleAlert ){
        baffle.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    }

    [baffle addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
    return baffle;
}
- (void)tapAction:(id)sender{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation _HHDatePickerPresent{
    BOOL _isPresent;
    NSTimeInterval _animationDuration;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _animationDuration=0.25;
    }
    return self;
}
-(UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    _HHDatePickerPresentController *presentVC=[[_HHDatePickerPresentController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
    presentVC.presentRect=_presentRect;
    presentVC.datePickerStyle=_datePickerStyle;
    return presentVC;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _isPresent=YES;
    return self;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    _isPresent=NO;
    return self;
}
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return _animationDuration;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    if (_isPresent) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        [[transitionContext containerView] addSubview:toView];
        toView.frame=CGRectMake(0, HHKIT_SCREEN_H, HHKIT_SCREEN_W, 0);
        [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            toView.frame=_presentRect;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }else{
        UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        [UIView animateWithDuration:_animationDuration delay:0 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
            fromView.frame=CGRectMake(0, HHKIT_SCREEN_H, HHKIT_SCREEN_W, 0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
        
    }
}
@end

@implementation HHDate

-(NSString *(^)(NSString *,NSDate *))dateFormat{
    return ^NSString *(NSString *fmt,NSDate *aDate){
        if (fmt==nil||aDate==nil) {
            return nil;
        }
        NSDateFormatter *datefmt=[[NSDateFormatter alloc] init];
        datefmt.dateFormat=fmt;
        return [datefmt stringFromDate:aDate];
    };
}
@end
