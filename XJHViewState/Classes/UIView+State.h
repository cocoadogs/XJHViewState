//
//  UIView+State.h
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJHViewStateProperty;

@interface UIView (State)

typedef NS_ENUM(NSInteger, XJHViewState) {
	///默认状态
	XJHViewStateDefault = 0,
	///加载状态，中间有一个UIIndicatorView
	XJHViewStateLoading,
	///无数据状态
	XJHViewStateNoData,
	///无网络状态
	XJHViewStateNetworkFail,
	///其他错误
	XJHViewStateError
};

@property (nonatomic, assign) XJHViewState viewState;
@property (nonatomic, strong) XJHViewStateProperty *stateProperties;

@end
