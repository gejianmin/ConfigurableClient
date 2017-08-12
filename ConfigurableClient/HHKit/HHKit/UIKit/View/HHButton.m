//
//  HHButton.m
//  HHButton
//
//  Created by liuwenjie on 15/11/25.
//  Copyright © 2015年 LWJ. All rights reserved.
//

#import "HHButton.h"

@implementation HHButton
#pragma mark - init
- (instancetype)initWithStyle:(HHButtonSubviewLayoutStyle)style{
    if (self=[super init]) {
        self.subviewLayoutStyle=style;
        self.imageTitleMargin=10.f;
    }
    return self;
}
-(instancetype)init{
    if (self=[super init]) {
        self.subviewLayoutStyle=HHButtonSubviewLayoutStyleHorizontal;
        self.imageTitleMargin=10.f;
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.subviewLayoutStyle=HHButtonSubviewLayoutStyleHorizontal;
        self.imageTitleMargin=10.f;

    }
    return self;
}

#pragma mark - setter
-(void)setTitleRect:(CGRect)titleRect{
    _titleRect=titleRect;
    [self setNeedsDisplay];
}
-(void)setImageRect:(CGRect)imageRect{
    _imageRect=imageRect;
    [self setNeedsDisplay];
}
-(void)setImageTitleMargin:(CGFloat)imageTitleMargin{
    _imageTitleMargin=imageTitleMargin;
    [self setNeedsDisplay];
}
-(void)setContentAlignment:(HHButtonContentAlignment)contentAlignment{
    _contentAlignment=contentAlignment;
    [self setNeedsDisplay];
}
-(void)setSubviewLayoutStyle:(HHButtonSubviewLayoutStyle)subviewLayoutStyle{
    _subviewLayoutStyle=subviewLayoutStyle;
    [self setNeedsDisplay];
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    if (title) {
        titleSize=[title sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    }else{
        titleSize=CGSizeZero;
    }

}
-(void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state{
    [super setAttributedTitle:title forState:state];
    if (title) {
        titleSize=[title boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    }else{
        titleSize=CGSizeZero;
    }
}

#pragma mark - Ovrride

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGRect titleRect=[super titleRectForContentRect:contentRect];
    CGRect newTitleRect=titleRect;
    CGRect imageRect=[super imageRectForContentRect:contentRect];

    switch (self.subviewLayoutStyle) {
        case HHButtonSubviewLayoutStyleHorizontal:
        {
            if (CGRectEqualToRect(imageRect, CGRectZero)) {
                newTitleRect=titleRect;
            }else{
                newTitleRect=CGRectMake(CGRectGetMaxX(imageRect)+self.imageTitleMargin/2, titleRect.origin.y, titleRect.size.width, titleRect.size.height);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleHorizontalReverse:
        {
            if (CGRectEqualToRect(imageRect, CGRectZero)) {
                newTitleRect=titleRect;
            }else{
                newTitleRect=CGRectMake(imageRect.origin.x-self.imageTitleMargin/2, titleRect.origin.y, titleRect.size.width, titleRect.size.height);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleVertical:
        {
            if (CGRectEqualToRect(imageRect, CGRectZero)) {
                newTitleRect=titleRect;
            }else{
                
                CGFloat imageY=contentRect.size.height/2-(imageRect.size.height+self.imageTitleMargin+titleRect.size.height)/2;
                CGFloat titleY=imageY+imageRect.size.height+self.imageTitleMargin/2;
                newTitleRect=CGRectMake(contentRect.size.width/2-titleSize.width/2, titleY, titleSize.width, titleSize.height);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleVerticalReverse:
        {
            if (CGRectEqualToRect(imageRect, CGRectZero)) {
                newTitleRect=titleRect;
            }else{
                CGFloat titleY=contentRect.size.height/2-(imageRect.size.height+self.imageTitleMargin+titleRect.size.height)/2;

                newTitleRect=CGRectMake(contentRect.size.width/2-titleSize.width/2, titleY, titleSize.width, titleSize.height);
            }

        }
            break;
        case HHButtonSubviewLayoutStyleCustom:{
            newTitleRect=_titleRect;
        }
            break;
    }

    
    return newTitleRect;
}
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect imageRect=[super imageRectForContentRect:contentRect];
    CGRect newImageRect=imageRect;
    CGRect titleRect=[super titleRectForContentRect:contentRect];
    
    switch (self.subviewLayoutStyle) {
        case HHButtonSubviewLayoutStyleHorizontal:
        {
            if (CGRectEqualToRect(titleRect, CGRectZero)) {
                newImageRect=imageRect;
            }else{
                CGFloat imageHScale=titleRect.size.height/imageRect.size.height;
                CGFloat imageH=titleRect.size.height;
                CGFloat imageW=imageRect.size.width*imageHScale;
                
                newImageRect=CGRectMake(imageRect.origin.x-self.imageTitleMargin/2, imageRect.origin.y, imageW, imageH);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleHorizontalReverse:
        {
            if (CGRectEqualToRect(titleRect, CGRectZero)) {
                newImageRect=imageRect;
            }else{
                CGFloat imageH=imageRect.size.height;                CGFloat imageW=imageRect.size.width;
                newImageRect=CGRectMake(CGRectGetMaxX(titleRect)+self.imageTitleMargin/2-imageW, imageRect.origin.y, imageW, imageH);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleVertical:
        {
            if (CGRectEqualToRect(titleRect, CGRectZero)) {
                newImageRect=imageRect;
            }else{
                CGFloat imageY=contentRect.size.height/2-(imageRect.size.height+self.imageTitleMargin+titleRect.size.height)/2;
                newImageRect=CGRectMake(contentRect.size.width/2-imageRect.size.width/2, imageY, imageRect.size.width, imageRect.size.height);
            }
        }
            break;
        case HHButtonSubviewLayoutStyleVerticalReverse:
        {
            if (CGRectEqualToRect(titleRect, CGRectZero)) {
                newImageRect=imageRect;
            }else{
                CGFloat titleY=contentRect.size.height/2-(imageRect.size.height+self.imageTitleMargin+titleSize.height)/2;
                CGFloat imageY=titleY+titleSize.height+self.imageTitleMargin/2;
                
                newImageRect=CGRectMake(contentRect.size.width/2-imageRect.size.width/2, imageY, imageRect.size.width, imageRect.size.height);

            }
        }
            break;
        case HHButtonSubviewLayoutStyleCustom:{
            newImageRect=_imageRect;
        }
            break;
    }


    return newImageRect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
@implementation HHButtonItem

- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)image{
    return [self initWithTitle:title normalImage:image className:nil];
}
- (instancetype)initWithTitle:(NSString *)title normalImage:(UIImage *)image className:(NSString *)aClass{
    if (self=[super init]) {
        _title=title;
        _normalImage=image;
        _className=aClass;
    }
    return self;
}
@end
