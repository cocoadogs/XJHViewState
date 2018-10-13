//
//  XJHViewStatePublicDataCenter.m
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "XJHViewStatePublicDataCenter.h"

static XJHViewStatePublicDataCenter *instance = nil;

@implementation XJHViewStatePublicDataCenter

#pragma mark - Singleton Methods

+ (instancetype)sharedInstance {
	return [[self alloc] init];
}

- (instancetype)init {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [super init];
	});
	return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [super allocWithZone:zone];
	});
	return instance;
}

@end
