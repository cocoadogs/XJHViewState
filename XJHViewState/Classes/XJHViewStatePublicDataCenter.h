//
//  XJHViewStatePublicDataCenter.h
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XJHViewStatePublicDataCenter : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) UIImage *noDataImage;
@property (nonatomic, strong) UIImage *errorImage;
@property (nonatomic, strong) UIImage *networkFailImage;

@property (nonatomic, copy) NSString *noDataTitle;
@property (nonatomic, copy) NSString *errorTitle;
@property (nonatomic, copy) NSString *networkFailTitle;

@property (nonatomic, copy) NSString *noDataSubtitle;
@property (nonatomic, copy) NSString *errorSubtitle;
@property (nonatomic, copy) NSString *networkSubtitle;

@end
