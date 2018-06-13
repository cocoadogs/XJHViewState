//
//  XJHViewStateProperty.m
//  XJHViewState
//
//  Created by xujunhao on 2018/6/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "XJHViewStateProperty.h"
#import "XJHViewStatePublicDataCenter.h"

@interface XJHViewStateProperty ()

@property (nonatomic, strong) NSMutableDictionary *customerViewDictionary;

@end

@implementation XJHViewStateProperty

#pragma mark - Public Methods

+ (instancetype)defaultProperties {
	return [[XJHViewStateProperty alloc] init];
}

+ (void)configImageForNoData:(UIImage *)noData error:(UIImage *)error network:(UIImage *)network {
	[XJHViewStatePublicDataCenter sharedInstance].noDataImage = noData;
	[XJHViewStatePublicDataCenter sharedInstance].errorImage = error;
	[XJHViewStatePublicDataCenter sharedInstance].networkFailImage = network;
}

+ (void)configTitleForNoData:(NSString *)noData error:(NSString *)error network:(NSString *)network {
	[XJHViewStatePublicDataCenter sharedInstance].noDataTitle = noData;
	[XJHViewStatePublicDataCenter sharedInstance].errorTitle = error;
	[XJHViewStatePublicDataCenter sharedInstance].networkFailTitle = network;
}

- (void)configImage:(UIImage *)image forState:(XJHViewState)state {
	if (image) {
		[[self customerViewDictionary] setObject:image forKey:[NSString stringWithFormat:@"img_%@", @(state)]];
	}
}

- (UIImage *)imageForState:(XJHViewState)state {
	UIImage *img = [[self customerViewDictionary] objectForKey:[NSString stringWithFormat:@"img_%@", @(state)]];
	if (!img) {
		switch (state) {
				case XJHViewStateNoData:
				img = [XJHViewStatePublicDataCenter sharedInstance].noDataImage;
				break;
				case XJHViewStateError:
				img = [XJHViewStatePublicDataCenter sharedInstance].errorImage;
				break;
				case XJHViewStateNetworkFail:
				img = [XJHViewStatePublicDataCenter sharedInstance].networkFailImage;
				break;
			default:
				img = [XJHViewStatePublicDataCenter sharedInstance].errorImage;
				break;
		}
	}
	return img;
}

- (void)configTitle:(NSString *)title forState:(XJHViewState)state {
	if (title) {
		[[self customerViewDictionary] setObject:title forKey:[NSString stringWithFormat:@"title_%@", @(state)]];
	}
}

- (NSString *)titleForState:(XJHViewState)state {
	NSString *title = [[self customerViewDictionary] objectForKey:[NSString stringWithFormat:@"title_%@", @(state)]];
	if (!title) {
		switch (state) {
				case XJHViewStateNoData:
				title = [XJHViewStatePublicDataCenter sharedInstance].noDataTitle;
				break;
				case XJHViewStateError:
				title = [XJHViewStatePublicDataCenter sharedInstance].errorTitle;
				break;
				case XJHViewStateNetworkFail:
				title = [XJHViewStatePublicDataCenter sharedInstance].networkFailTitle;
				break;
			default:
				title = [XJHViewStatePublicDataCenter sharedInstance].errorTitle;
				break;
		}
	}
	return title;
}

- (void)configDetail:(NSString *)detail forState:(XJHViewState)state {
	if (detail) {
		[[self customerViewDictionary] setObject:detail forKey:[NSString stringWithFormat:@"detail_%@", @(state)]];
	}
}

- (NSString *)detailForState:(XJHViewState)state {
	NSString *detail = [[self customerViewDictionary] objectForKey:[NSString stringWithFormat:@"detail_%@", @(state)]];
	if (!detail) {
		detail = @"";
	}
	return detail;
}

- (void)configCustomerView:(UIView *)view ForState:(XJHViewState)state {
	if (view) {
		[[self customerViewDictionary] setObject:view forKey:[NSString stringWithFormat:@"view_%@", @(state)]];
	}
}

- (UIView *)customerViewForState:(XJHViewState)state {
	return [[self customerViewDictionary] objectForKey:[NSString stringWithFormat:@"view_%@", @(state)]];
}


#pragma mark - Lazy Load Method

- (NSMutableDictionary *)customerViewDictionary {
	if (!_customerViewDictionary) {
		_customerViewDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	return _customerViewDictionary;
}

@end
