//
//  HHBannerView.m
//  BannerView
//
//  Created by 张家欢 on 16/8/8.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "HHBannerView.h"
#import "UIImageView+WebCache.h"
@interface HHBannerView()<CAAnimationDelegate>

@property (nonatomic,strong) UIImageView *imgView;                  // 显示图片的视图
@property (nonatomic,strong) NSArray *imgArr;                       // 图片数组
@property (nonatomic, strong) NSTimer *myTimer;                     // 定时器
@property (nonatomic, strong) UIPageControl *pageControl;           // 下方显示页数
@property (nonatomic, strong) CustomLab * titleLabel;           // 显示标题

@end

@implementation HHBannerView
{
    CGFloat SELFWIDTH;
    CGFloat SELFHEIGHT;
    NSInteger totalNumber;
    NSInteger currentPage;
    NSMutableArray *bannerImageArray;
    NSInteger bannerSourceType;
}
- (instancetype)initWithFrame:(CGRect)frame WithBannerSource:(NinaBannerSource)bannerSource WithBannerArray:(NSArray *)bannerArray titleArray:(NSArray *)titleArray{
    if (self = [super initWithFrame:frame]) {
        SELFWIDTH = frame.size.width;
        SELFHEIGHT = frame.size.height;
        totalNumber = bannerArray.count;
        currentPage = 0;
        _imgArr = bannerArray;
        _titleArr = titleArray;
        bannerSourceType = bannerSource;
        
        self.imgArr = bannerArray;
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.imgView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.imgView];
        self.imgView.userInteractionEnabled = YES;
        //标题
        UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-30, frame.size.width, 30) color:HEXCOLOR(0x000000,0.6)];
        [self.imgView addSubview:bgView];
        self.titleLabel = [[CustomLab alloc]initWithFrame:CGRectMake(0, frame.size.height-25, frame.size.width-100, 20) font:15.0 aligment:NSTextAlignmentLeft text:self.titleArr[0] textcolor:[UIColor whiteColor]];
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];

        if (bannerSourceType == 0) {
            self.imgView.image = [UIImage imageNamed:self.imgArr[currentPage]];
        }else if (bannerSourceType == 1) {
            [ self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[currentPage]]placeholderImage:ImageNamed(@"nullData_image")];
            self.titleLabel.text = self.titleArr[currentPage];
        }

        UISwipeGestureRecognizer *fromRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight)];
        [fromRightRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [self.imgView addGestureRecognizer:fromRightRecognizer];

        UISwipeGestureRecognizer *fromLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft)];
        [fromLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [self.imgView addGestureRecognizer:fromLeftRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView)];
        [self.imgView addGestureRecognizer:tapRecognizer];
        [self setupTimer:5];
    }
    return self;
}


- (void)reloadDataWithBannerArray:(NSArray *)bannerArray titleArray:(NSArray *)titleArray {
    totalNumber = bannerArray.count;
    _imgArr = bannerArray;
    self.imgArr = bannerArray;
    _titleArr = titleArray;
    currentPage = 0;
    self.showPageControl = YES;
    self.pageControl.numberOfPages = totalNumber;
    if (bannerSourceType == 0) {
        self.imgView.image = [UIImage imageNamed:self.imgArr[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[currentPage]]placeholderImage:ImageNamed(@"nullData_image")];
        self.titleLabel.text = self.titleArr[currentPage];
    }
}

#pragma mark - SetMethod
- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    if (showPageControl) {
        [self addSubview:self.pageControl];
    }
}

#pragma mark - LazyLoad
- (UIPageControl *)pageControl {
    
    if (!_pageControl) {
        _pageControl = [UIPageControl new];
        _pageControl.numberOfPages = totalNumber;
        CGSize size = [_pageControl sizeForNumberOfPages:totalNumber];
        _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(SELFWIDTH-45, SELFHEIGHT - 15);
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.hidesForSinglePage = YES;
    }
    return _pageControl;
}
- (void)handleSwipeFromRight{
    currentPage++;
    if (currentPage >= self.imgArr.count) {
        currentPage = 0;
    }
    self.pageControl.currentPage = currentPage;

    if (bannerSourceType == 0) {
        self.imgView.image = [UIImage imageNamed:self.imgArr[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[currentPage]]placeholderImage:ImageNamed(@"nullData_image")];
        self.titleLabel.text = self.titleArr[currentPage];

    }
        CATransition *transition = [[CATransition alloc] init];
    if (self.showTransition) {
        transition.type = @"cube";                //立方体翻转
    }
        transition.subtype = kCATransitionFromRight;
        transition.duration = 0.5;
        transition.delegate = self;
        [self.imgView.layer addAnimation:transition forKey:nil];
//        [self.titleLabel.layer addAnimation:transition forKey:nil];

}
- (void)handleSwipeFromLeft{
    
    currentPage--;
    if (currentPage < 0 ) {
        currentPage = self.imgArr.count-1;
    }
    self.pageControl.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        self.imgView.image = [UIImage imageNamed:self.imgArr[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.imgView sd_setImageWithURL:[NSURL URLWithString:self.imgArr[currentPage]]placeholderImage:ImageNamed(@"nullData_image")];
        self.titleLabel.text = self.titleArr[currentPage];

    }
    CATransition *transition2 = [[CATransition alloc] init];
    if (self.showTransition) {
    transition2.type = @"cube";
    }
    transition2.subtype = kCATransitionFromLeft;
    transition2.duration = 1.5;
    transition2.delegate = self;
    [self.imgView.layer addAnimation:transition2 forKey:nil];
    

}

- (void)setTimeInterval:(CGFloat)timeInterval {
    _timeInterval = fabs(timeInterval);
    if (self.myTimer) {
        [self.myTimer invalidate];
        [self setupTimer:_timeInterval];
    }
}

- (void)setupTimer:(CGFloat)timeInterval {
    self.myTimer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.myTimer forMode:NSDefaultRunLoopMode];
}
- (void)animationDidStart:(CAAnimation *)theAnimation{
    if (self.myTimer) {
        [self.myTimer invalidate];
    }
    self.imgView.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (self.timeInterval > 0) {
        [self setupTimer:self.timeInterval];
    }else {
        [self setupTimer:5.0];
    }
    self.imgView.userInteractionEnabled = YES;
}

- (void)tapImgView{
    
    if ([self.delegate respondsToSelector:@selector(hhBannerView:didSelectItemAtIndex:)]) {
        [self.delegate hhBannerView:self didSelectItemAtIndex:currentPage];
    }
}
@end
