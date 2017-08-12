//
//  HHLoginManager.m
//  HHKit
//
//  Created by LWJ on 16/8/2.
//  Copyright © 2016年 HHAuto. All rights reserved.
//

#import "HHControllerManager.h"

#define HH_TRANSITION_DURATION 0.45

#pragma mark - HHWindowRootViewController
@interface HHWindowRootViewController : UIViewController

- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;

- (void)modalViewController:(UIViewController *)controller animated:(BOOL)flag completion:(void (^ )(void))completion;

@end

@implementation HHWindowRootViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
}
-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated{
    [self presentViewController:controller animated:animated completion:nil];

}
-(void)modalViewController:(UIViewController *)controller animated:(BOOL)flag completion:(void (^)(void))completion{
    [self presentViewController:controller animated:flag completion:completion];
}
-(BOOL)prefersStatusBarHidden{
    return NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
@end
#pragma mark - HHLoginManager
@interface HHControllerManager()

@property (nonatomic, strong) UIWindow *window;

@end
@implementation HHControllerManager
+(instancetype)sharedInstance{
    static HHControllerManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[HHControllerManager alloc] init];
    });
    return instance;
}
-(UIWindow *)window{
    if (_window==nil) {
        _window=[[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = UIWindowLevelStatusBar - 1;
        _window.backgroundColor = [UIColor clearColor];
        UIViewController *vc=[[HHWindowRootViewController alloc] init];
        UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:vc];
        _window.rootViewController=nav;

    }
    return _window;
}
- (UINavigationController *)rootViewController{
    return (UINavigationController *)self.window.rootViewController;
}
- (void)pushViewController:(UIViewController *)controller animated:(BOOL)animated{
    if (controller==nil) {return;}
    self.window.rootViewController=controller;
    [self showWindowAnimated:animated transition:HHViewControllerTransitionStyleRight];
}

- (void)presentViewController:(UIViewController *)controller animated:(BOOL)flag completion:(void (^ )(void))completion{
    if (controller==nil) {return;}
    self.window.rootViewController=controller;
    [self showWindowAnimated:flag transition:HHViewControllerTransitionStyleBottom];
}

- (void)popViewControllerAnimated:(BOOL)animated{
    [self closeWindowAnimated:animated transition:HHViewControllerTransitionStyleRight complete:nil];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^ )(void))completion{
    [self closeWindowAnimated:flag transition:HHViewControllerTransitionStyleBottom complete:^{
        if (completion) {
            completion();
        }
    }];

}



- (void)showWindowAnimated:(BOOL)animated transition:(HHViewControllerTransitionStyle)style{
    self.window.hidden=NO;
    
    switch (style) {
        case HHViewControllerTransitionStyleRight:
        {
            self.window.frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        }
            break;
        case HHViewControllerTransitionStyleBottom:
        {
            self.window.frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        }
            break;
        case HHViewControllerTransitionStyleTop:
        {
            self.window.frame=CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        }
            break;
        case HHViewControllerTransitionStyleLeft:
        {
            self.window.frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);

        }
            break;
        case HHViewControllerTransitionStyleCenter:
        {
            self.window.frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, 0, 0);

        }
            break;
        default:
            self.window.frame=[UIScreen mainScreen].bounds;
            break;
    }
    [UIView animateWithDuration:HH_TRANSITION_DURATION delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.window.frame=[UIScreen mainScreen].bounds;

    } completion:^(BOOL finished) {
        
    }];
}
- (void)closeWindowAnimated:(BOOL)animated transition:(HHViewControllerTransitionStyle)style complete:(void(^)())complete{
    
    CGRect frame=CGRectZero;
    switch (style) {
        case HHViewControllerTransitionStyleRight:
        {
            frame=CGRectMake([UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        }
            break;
        case HHViewControllerTransitionStyleBottom:
        {
            frame=CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        }
            break;
        case HHViewControllerTransitionStyleTop:
        {
            frame=CGRectMake(0, -[UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        }
            break;
        case HHViewControllerTransitionStyleLeft:
        {
            frame=CGRectMake(-[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            
        }
            break;
        case HHViewControllerTransitionStyleCenter:
        {
            frame=CGRectMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2, 0, 0);
            
        }
            break;
        default:
            frame=[UIScreen mainScreen].bounds;
            break;
    }
    [UIView animateWithDuration:HH_TRANSITION_DURATION delay:0.0 usingSpringWithDamping:1.0 initialSpringVelocity:1.0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
        self.window.frame=frame;

    }completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
        self.window.hidden=YES;
        self.window.rootViewController=nil;

    }];
}
@end

