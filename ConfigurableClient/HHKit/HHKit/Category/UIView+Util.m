//
//  UIView+Util.m
//  UsedCar
//
//  Created by Alan on 13-10-25.
//  Copyright (c) 2013年 Alan. All rights reserved.
//

#import "UIView+Util.h"
#import <objc/runtime.h>
#import "UIResponder+Router.h"


NSString *const  kMaxTextLengthEventName=@"kMaxTextLengthEventName";

#define CATEGORY_RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define kLinePixel  0.5
#define  kLine_Color             CATEGORY_RGBACOLOR(211, 212, 212,1)

@implementation UIView (Util)
@dynamic borderColor;

//MARK:X
- (CGFloat)minX {
	return self.frame.origin.x;
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setMinX:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

//MARK:Y
- (CGFloat)minY {
	return self.frame.origin.y;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setMinY:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
    
}

//MARK:maxX
- (CGFloat)maxX {
	return self.frame.origin.x + self.frame.size.width;
}

- (void)setMaxX:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x - frame.size.width;
	self.frame = frame;
}
//MARK:maxY
- (CGFloat)maxY {
	return self.frame.origin.y + self.frame.size.height;
}

- (void)setMaxY:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y - frame.size.height;
	self.frame = frame;
}
//MARK:width
- (CGFloat)width {
	return self.frame.size.width;
}
-(CGFloat)w{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setW:(CGFloat)w{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

//MARK:height
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)h{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setH:(CGFloat)h{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
    
}

//MARK:origin
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
//MARK:size
- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

//MARK:cornerRadius
- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
//    UIBezierPath *maskPath;
//    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
//                                          cornerRadius:cornerRadius];
//    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.frame = self.bounds;
//    maskLayer.path = maskPath.CGPath;
//    self.layer.mask = maskLayer;
    self.layer.cornerRadius=cornerRadius;
    self.layer.masksToBounds=YES;
}
-(void)setCornerRadiusOfTop:(CGFloat)cornerRadiusOfTop{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(cornerRadiusOfTop, cornerRadiusOfTop)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}
-(void)setCornerRadiusOfTopLeft:(CGFloat)cornerRadiusOfTopLeft{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopLeft)
                                           cornerRadii:CGSizeMake(cornerRadiusOfTopLeft, cornerRadiusOfTopLeft)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
-(void)setCornerRadiusOfTopRight:(CGFloat)cornerRadiusOfTopRight{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerTopRight)
                                           cornerRadii:CGSizeMake(cornerRadiusOfTopRight, cornerRadiusOfTopRight)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
-(void)setCornerRadiusOfBottom:(CGFloat)cornerRadiusOfBottom{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)
                                           cornerRadii:CGSizeMake(cornerRadiusOfBottom, cornerRadiusOfBottom)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
-(void)setCornerRadiusOfBottomLeft:(CGFloat)cornerRadiusOfBottomLeft{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:UIRectCornerBottomLeft
                                           cornerRadii:CGSizeMake(cornerRadiusOfBottomLeft, cornerRadiusOfBottomLeft)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
-(void)setCornerRadiusOfBottomRight:(CGFloat)cornerRadiusOfBottomRight{
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:UIRectCornerBottomRight
                                           cornerRadii:CGSizeMake(cornerRadiusOfBottomRight, cornerRadiusOfBottomRight)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;

}
//MARK:borderColor
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderWidth=kLinePixel;
    self.layer.cornerRadius=4.f;
    self.layer.borderColor=borderColor.CGColor;
}
- (void)setNoneCorner{
    self.layer.mask = nil;
}

//MARK:screenViewX
- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.minX;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}
//MARK:screenViewY
- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.minY;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}

- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


- (UIView*)subviewWithFirstResponder {
	if ([self isFirstResponder])
		return self;
	
	for (UIView *subview in self.subviews) {
		UIView *view = [subview subviewWithFirstResponder];
		if (view) return view;
	}
	
	return nil;
}

- (UIView*)subviewWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (UIView* subview in self.subviews) {
		UIView* view = [subview subviewWithClass:cls];
		if (view) return view;
	}
	
	return nil;
}

- (UIView*)superviewWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	} else if (self.superview) {
		return [self.superview superviewWithClass:cls];
	} else {
		return nil;
	}
}

-(void)addTopLine:(CGFloat)h{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, h) color:kLine_Color];
    [self addSubview:line];
}
-(void)addBottomLine:(CGFloat)h{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, self.height-h, self.width, h) color:kLine_Color];
    [self addSubview:line];

}
-(void)addLeftLine:(CGFloat)w{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 0, w, self.height) color:kLine_Color];
    [self addSubview:line];

}
-(void)addRightLine:(CGFloat)w{
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(self.width-w, 0, w, self.height) color:kLine_Color];
    [self addSubview:line];

}


- (void)removeAllSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}

- (UIImage *)screenshot{
//    //支持retina高分的关键
//    if(/* DISABLES CODE */ (&UIGraphicsBeginImageContextWithOptions) != NULL){
//    }
//    else{
//        UIGraphicsBeginImageContext(self.bounds.size);
//    }
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0.0);

    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//初始化
-(instancetype)initWithFrame:(CGRect)frame color:(UIColor *)bgColor{

    self = [self initWithFrame:frame];
	self.backgroundColor = bgColor;
	return self;
}

/** super UIViewController */
- (UIViewController*)viewController {
	for (UIView* next = [self superview]; next; next = next.superview) {
		UIResponder* nextResponder = [next nextResponder];
		if ([nextResponder isKindOfClass:[UIViewController class]]) {
			return (UIViewController*)nextResponder;
		}
	}
	return nil;
}




@end

@implementation UITextField (Util)
-(void)setMaxTextLength:(NSInteger)maxTextLength{
    objc_setAssociatedObject(self, "maxInputTextLength", @(maxTextLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self removeTarget:self action:@selector(limitMaxInputTextLength:) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(limitMaxInputTextLength:) forControlEvents:UIControlEventEditingChanged];
}
-(NSInteger)maxTextLength{
    return  [objc_getAssociatedObject(self, "maxInputTextLength") integerValue];
}
- (void)limitMaxInputTextLength:(UITextField *)sender{
    NSString *temp=sender.text;
    if (self.markedTextRange==nil) {
        while (1) {
            if (temp.length<=self.maxTextLength) {
                break;
            }else{
                temp=[temp substringToIndex:temp.length-1];
                [self routerEventWithName:kMaxTextLengthEventName userInfo:@{@"textField":self}];
            }
        }
        self.text=temp;
    }
    

}
-(void)showToolBar{
    UIToolbar *bar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 39)];
    bar.backgroundColor=CATEGORY_RGBACOLOR(235, 235, 241, 1);
    UIButton *finish=[UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-54, 0, 54, bar.height);
    finish.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishInput) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:finish];
    self.inputAccessoryView=bar;
}
-(void)finishInput{
    [self resignFirstResponder];
}
@end

@implementation UITextView (Util)
-(void)setMaxTextLength:(NSInteger)maxTextLength{
    objc_setAssociatedObject(self, "maxInputTextLength", @(maxTextLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(limitMaxInputTextLength:) name:UITextViewTextDidChangeNotification object:nil];
}
-(NSInteger)maxTextLength{
    return  [objc_getAssociatedObject(self, "maxInputTextLength") integerValue];
}
- (void)limitMaxInputTextLength:(NSNotification *)sender{
    
    
    //NSInteger len = [string lengthOfBytesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];字节数
    NSString *temp=self.text;
    if (self.markedTextRange==nil) {
        while (1) {
            if (temp.length<=self.maxTextLength) {
                break;
            }else{
                temp=[temp substringToIndex:temp.length-1];
                [self routerEventWithName:kMaxTextLengthEventName userInfo:@{@"textView":self}];

            }
        }
        self.text=temp;
    }
    
    
}

-(void)showToolBar{
    UIToolbar *bar=[[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 0, 39)];
    bar.backgroundColor=CATEGORY_RGBACOLOR(235, 235, 241, 1);
    UIButton *finish=[UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-54, 0, 54, bar.height);
    finish.autoresizingMask=UIViewAutoresizingFlexibleRightMargin;
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:[UIColor colorWithRed:50/255.0 green:168/255.0 blue:240/255.0 alpha:1] forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishInput) forControlEvents:UIControlEventTouchUpInside];
    [bar addSubview:finish];
    self.inputAccessoryView=bar;

}
-(void)finishInput{
    [self resignFirstResponder];
}

@end








