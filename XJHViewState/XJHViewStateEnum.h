//
//  XJHViewStateEnum.h
//  XJHViewState
//
//  Created by cocoadogs on 2018/10/13.
//

#ifndef XJHViewStateEnum_h
#define XJHViewStateEnum_h

typedef NS_ENUM(NSInteger, XJHViewState) {
    ///默认状态
    XJHViewStateDefault = 0,
    ///普通占位图状态
    XJHViewStatePlaceholder,
    ///加载状态，中间有一个UIIndicatorView
    XJHViewStateLoading,
    ///无数据状态
    XJHViewStateNoData,
    ///无网络状态
    XJHViewStateNetworkFail,
    ///其他错误
    XJHViewStateError
};


#endif /* XJHViewStateEnum_h */
