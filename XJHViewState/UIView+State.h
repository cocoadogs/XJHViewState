//
//  UIView+State.h
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XJHViewStateEnum.h"
@class XJHViewStateProperty;

@interface UIView (State)

@property (nonatomic, assign) XJHViewState viewState;
@property (nonatomic, strong) XJHViewStateProperty *stateProperties;

@end
