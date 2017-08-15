//
//  GFNavigationController.m
//  qudiaoyu
//
//  Created by abel on 14/10/14.
//  Copyright (c) 2014年 qudiaoyu.com.cn. All rights reserved.
//

#import "JDNavigationController.h"
//#import "BaseViewController.h"
//#import "UIColor+Utils.h"
//#import "HomeViewController.h"
#import<objc/runtime.h>
@interface JDNavigationController ()
{
    UIImage *_currentBarImage;
}
@property (nonatomic, retain) UIView *alphaView;

@end

@implementation JDNavigationController




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setBarTintColor:HEXCOLOR(0x4169E1, 1)];
//    [self.navigationBar setBarTintColor:[UIColor whiteColor]];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationBar.tintColor=[UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor whiteColor]}];

}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    [self.view endEditing:YES];
    [self setHiddenNavigationBar:NO];
    return [super popViewControllerAnimated:animated];
}
@end
@implementation UINavigationController (bar)

- (void)setHiddenNavigationBar:(BOOL)hiden{
    self.barHiden=hiden;
    if (hiden) {
        UIImage *image = [self clearImage];//[self imageWithColor:[UIColor clearColor]];
        
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }else{
        UIImage *image = [self redImage];//[self imageWithColor:COLORHEX(0xE20C20)];
        
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:[UIImage new]];
        self.navigationBar.tintColor=[UIColor whiteColor];


    }

}
-(void)setBarHiden:(BOOL)barHiden{
    objc_setAssociatedObject(self, "barHiden", @(barHiden), OBJC_ASSOCIATION_ASSIGN);
}
-(BOOL)barHiden{
    return [objc_getAssociatedObject(self, "barHiden") boolValue];
}
- (UIImage *)clearImage{
    id image=objc_getAssociatedObject(self, "navigationBarClearImage");
    if (image==nil) {
        image=[self imageWithColor:[UIColor clearColor]];
        objc_setAssociatedObject(self, "navigationBarClearImage", image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return image;
}
- (UIImage *)redImage{
    id image=objc_getAssociatedObject(self, "navigationBarRedImage");
    if (image==nil) {
        image=[self imageWithColor:HEXCOLOR(0x4169E1, 0.9)];
//                image=[self imageWithColor:[UIColor clearColor]];

        objc_setAssociatedObject(self, "navigationBarRedImage", image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return image;

}
- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
