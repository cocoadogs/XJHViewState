//
//  UIView+State.m
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "UIView+State.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "XJHViewStateProperty.h"

const char * kPlaceholderStateViewKey   =   "kPlaceholderStateViewKey";
const char * kNoDataStateViewKey        =    "kNoDataStateViewKey";
const char * kErrorStateViewKey            =    "kErrorStateViewKey";
const char * kNetworkFailStateViewKey    =    "kNetworkFailStateViewKey";

@interface XJHStateView : UIView

- (instancetype)initWithVerticalOffset:(CGFloat)verticalOffset
                           labelOffset:(CGFloat)labelOffset
                             titleFont:(UIFont *)titleFont
                            titleColor:(UIColor *)titleColor
                            detailFont:(UIFont *)detailFont
                           detailColor:(UIColor *)detailColor
                             imageSize:(CGSize)imageSize;

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation XJHStateView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [self initWithVerticalOffset:0 labelOffset:0 titleFont:nil titleColor:nil detailFont:nil detailColor:nil imageSize:CGSizeZero];
    }
    return self;
}

- (instancetype)initWithVerticalOffset:(CGFloat)verticalOffset
                           labelOffset:(CGFloat)labelOffset
                             titleFont:(UIFont *)titleFont
                            titleColor:(UIColor *)titleColor
                            detailFont:(UIFont *)detailFont
                           detailColor:(UIColor *)detailColor
                             imageSize:(CGSize)imageSize{
    if (self = [super initWithFrame:CGRectZero]) {
        UIFont *title_font = titleFont?:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular];
        UIFont *detatil_font = detailFont?:[UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
        UIColor *title_color = titleColor?:[UIColor colorWithRed:195/255.0f green:199/255.0f blue:205/255.0f alpha:1.0f];
        UIColor *detail_color = detailColor?:[UIColor colorWithRed:195/255.0f green:199/255.0f blue:205/255.0f alpha:1.0f];
        self.titleLabel.font = title_font;
        self.titleLabel.textColor = title_color;
        self.detailLabel.font = detatil_font;
        self.detailLabel.textColor = detail_color;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        
        CGFloat width = imageSize.width > 0 ? imageSize.width : self.bounds.size.width * 0.3;
        CGFloat height = imageSize.height > 0 ? imageSize.height : self.bounds.size.width * 0.3;
        CGFloat centerY = self.center.y + verticalOffset;
        
        self.imageView.frame = CGRectMake(self.center.x - width / 2, centerY - height / 2, width, height);
        
        self.titleLabel.center = CGPointMake(self.center.x, centerY + height / 2 + labelOffset + ceil(titleFont.capHeight / 2));
        
        self.detailLabel.center = CGPointMake(self.center.x, centerY + height / 2 + labelOffset + titleFont.capHeight + ceil(detailFont.capHeight / 2) + 6);
    }
    return self;
}

#pragma mark - Lazy Load Methods

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.userInteractionEnabled = YES;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.userInteractionEnabled = YES;
    }
    return _detailLabel;
}

@end

@implementation UIView (State)

- (void)setViewState:(XJHViewState)currentState {
    if (self.viewState != currentState) {
        switch (self.viewState) {
            case XJHViewStateDefault:
                //do nothing
                break;
            case XJHViewStateLoading: {
                UIView *stateView = self.loadingView;
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     stateView.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     [stateView removeFromSuperview];
                                     self.loadingDataView = nil;
                                 }];
            }
                break;
            default: {
                UIView *stateView = [self stateViewForState:self.viewState];
                [self setStateView:nil forState:self.viewState];
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     stateView.alpha = 0;
                                 } completion:^(BOOL finished) {
                                     [stateView removeFromSuperview];
                                 }];
            }
                break;
        }
        objc_setAssociatedObject(self, @selector(viewState), @(currentState), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        //放在superView上可以防止直接放在self上会出现点击事件传递到原界面的情况
        //经测试，上述情况不存在
        UIView *stateView = nil;
        switch (currentState) {
            case XJHViewStateDefault:
            {
                [UIView animateWithDuration:0.25 animations:^{
                    self.alpha = 1.0f;
                }];
            }
                break;
            case XJHViewStateLoading:
            {
                stateView = self.loadingView;
            }
                break;
            default:
            {
                stateView = [self stateViewForState:currentState];
            }
                break;
        }
        
        if (stateView) {
            stateView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:stateView];
            stateView.alpha = 0;
            [UIView animateWithDuration:0.25 animations:^{
                stateView.alpha = 1.0f;
            } completion:^(BOOL finished) {
                
            }];
            [self bringSubviewToFront:stateView];
        }
    }
}

- (XJHViewState)viewState {
    return [objc_getAssociatedObject(self, @selector(viewState)) integerValue];
}

- (XJHViewStateProperty *)stateProperties {
    if (objc_getAssociatedObject(self, @selector(stateProperties))) {
        return objc_getAssociatedObject(self, @selector(stateProperties));
    }
    XJHViewStateProperty *properties = [XJHViewStateProperty defaultProperties];
    [self setStateProperties:properties];
    return properties;
}

- (void)setStateProperties:(XJHViewStateProperty *)properties {
    objc_setAssociatedObject(self, @selector(stateProperties), properties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)stateViewForState:(XJHViewState)state {
    UIView *stateView = objc_getAssociatedObject(self, [self stateViewKeyForState:state]);
    if (stateView) {
        stateView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        return stateView;
    }
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    bgView.backgroundColor = [UIColor clearColor];
    UIView *customerView = [self.stateProperties customerViewForState:state];
    if (customerView) {
        [bgView addSubview:customerView];
        customerView.frame = CGRectMake(0, 0, bgView.bounds.size.width, bgView.bounds.size.height);
        customerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [customerView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self)
            [self tapAction:state];
        }];
        [customerView addGestureRecognizer:tapGesture];
    } else {
        XJHStateView *statusView = [[XJHStateView alloc] initWithVerticalOffset:self.stateProperties.contentVerticalOffset labelOffset:self.stateProperties.labelOffset titleFont:self.stateProperties.titleFont titleColor:self.stateProperties.titleColor detailFont:self.stateProperties.detailFont detailColor:self.stateProperties.detailColor imageSize:self.stateProperties.imageSize];
        statusView.imageView.image = [self.stateProperties imageForState:state];
        statusView.titleLabel.text = [self.stateProperties titleForState:state];
        statusView.detailLabel.text = [self.stateProperties detailForState:state];
        [statusView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tapGesture rac_gestureSignal] subscribeNext:^(id x) {
            @strongify(self)
            [self tapAction:state];
        }];
        [statusView addGestureRecognizer:tapGesture];
        [bgView addSubview:statusView];
        statusView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        statusView.frame = CGRectMake(0, 0, bgView.bounds.size.width, bgView.bounds.size.height);
    }
    [self setStateView:bgView forState:state];
    return bgView;
}

- (void)setStateView:(UIView *)stateView forState:(XJHViewState)state {
    objc_setAssociatedObject(self, [self stateViewKeyForState:state], stateView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)loadingView {
    if (!objc_getAssociatedObject(self, @selector(loadingView))) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        bgView.backgroundColor = [UIColor clearColor];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        UIView *customerView = [self.stateProperties customerViewForState:XJHViewStateLoading];
        if (customerView) {
            customerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [bgView addSubview:customerView];
            customerView.frame = CGRectMake(0, 0, bgView.bounds.size.width, bgView.bounds.size.height);
        } else {
            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
            indicator.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            indicator.backgroundColor= UIColor.clearColor;
            indicator.color = UIColor.darkGrayColor;
            [bgView addSubview:indicator];
            indicator.center = CGPointMake(self.center.x + self.stateProperties.indicatorOffsetX, self.bounds.size.height / 2 + self.stateProperties.indicatorOffsetY);
            [indicator startAnimating];
            indicator.hidesWhenStopped = YES;
        }
        self.loadingDataView = bgView;
        return bgView;
    }
    return objc_getAssociatedObject(self, @selector(loadingView));
}

- (void)setLoadingDataView:(UIView *)loadingDataView {
    objc_setAssociatedObject(self, @selector(loadingView), loadingDataView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (const char *)stateViewKeyForState:(XJHViewState)state {
    const char *stateKey;
    switch (state) {
        case XJHViewStatePlaceholder:
            stateKey = kPlaceholderStateViewKey;
            break;
        case XJHViewStateNoData:
            stateKey = kNoDataStateViewKey;
            break;
        case XJHViewStateError:
            stateKey = kErrorStateViewKey;
            break;
        case XJHViewStateNetworkFail:
            stateKey = kNetworkFailStateViewKey;
            break;
        default:
            stateKey = "";
            break;
    }
    return stateKey;
}

- (void)tapAction:(XJHViewState)state {
    switch (state) {
        case XJHViewStateNoData:
        {
            !self.stateProperties.noDataAction?:self.stateProperties.noDataAction();
        }
            break;
        case XJHViewStateError:
        {
            !self.stateProperties.errorAction?:self.stateProperties.errorAction();
        }
            break;
        case XJHViewStateNetworkFail:
        {
            !self.stateProperties.networkAction?:self.stateProperties.networkAction();
        }
            break;
        default:
            break;
    }
}

@end
