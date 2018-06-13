//
//  XJHViewStateProperty.h
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+State.h"

typedef void(^NoDataAction)(void);
typedef void(^ErrorAction)(void);
typedef void(^NetworkFailAction)(void);

@interface XJHViewStateProperty : NSObject

+ (void)configImageForNoData:(UIImage *)noData error:(UIImage *)error network:(UIImage *)network;
+ (void)configTitleForNoData:(NSString *)noData error:(NSString *)error network:(NSString *)network;

@property (nonatomic, copy) NoDataAction noDataAction;
@property (nonatomic, copy) ErrorAction errorAction;
@property (nonatomic, copy) NetworkFailAction networkAction;

///title字体
@property (nonatomic, strong) UIFont *titleFont;
///detail字体
@property (nonatomic, strong) UIFont *detailFont;
///title颜色
@property (nonatomic, strong) UIColor *titleColor;
///detail颜色
@property (nonatomic, strong) UIColor *detailColor;


///垂直方向内容偏移，默认为0，居中，<0向上偏移， >0向下偏移
@property (nonatomic, assign) CGFloat contentVerticalOffset;

///文本垂直方向偏移，默认为0，图片下方
@property (nonatomic, assign) CGFloat labelOffset;

///加载区域偏移，默认为UIEdgeInsetsZero
@property (nonatomic, assign) UIEdgeInsets loadingAreaInsets;

///是否忽略导航高度，默认为NO
@property (nonatomic, assign) BOOL ignoreNavBar;

@property (nonatomic, assign) CGFloat indicatorOffsetX;

@property (nonatomic, assign) CGFloat indicatorOffsetY;

///加载的背景alpha，默认为0.7
@property (nonatomic, assign) CGFloat indicatorAlpha;

- (void)configImage:(UIImage *)image forState:(XJHViewState)state;
- (UIImage *)imageForState:(XJHViewState)state;

- (void)configTitle:(NSString *)title forState:(XJHViewState)state;
- (NSString *)titleForState:(XJHViewState)state;

- (void)configDetail:(NSString *)detail forState:(XJHViewState)state;
- (NSString *)detailForState:(XJHViewState)state;

- (void)configCustomerView:(UIView *)view ForState:(XJHViewState)state;
- (UIView *)customerViewForState:(XJHViewState)state;

+ (instancetype)defaultProperties;

@end
