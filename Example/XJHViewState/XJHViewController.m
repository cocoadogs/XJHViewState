//
//  XJHViewController.m
//  XJHViewState
//
//  Created by 许君浩 on 06/13/2018.
//  Copyright (c) 2018 许君浩. All rights reserved.
//

#import "XJHViewController.h"
#import "UIView+State.h"
#import "XJHViewStateProperty.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "XJHTableViewController.h"


@interface XJHViewController ()


@end

@implementation XJHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder"]];
    [self.view.stateProperties configCustomerView:imgView ForState:XJHViewStatePlaceholder];
    
	[self.view.stateProperties configImage:[UIImage imageNamed:@"空数据占位图"] forState:XJHViewStateNoData];
	[self.view.stateProperties configImage:[UIImage imageNamed:@"空数据占位图"] forState:XJHViewStateError];
	[self.view.stateProperties configImage:[UIImage imageNamed:@"空数据占位图"] forState:XJHViewStateNetworkFail];
	
	[self.view.stateProperties configTitle:@"暂无数据" forState:XJHViewStateNoData];
	[self.view.stateProperties configTitle:@"一般错误" forState:XJHViewStateError];
	[self.view.stateProperties configTitle:@"网络出错" forState:XJHViewStateNetworkFail];
	
	@weakify(self)
	self.view.stateProperties.noDataAction = ^{
		@strongify(self)
		self.view.viewState = XJHViewStateError;
		[self presentViewController:[[XJHTableViewController alloc] init] animated:YES completion:^{
			
		}];
	};
	self.view.stateProperties.errorAction = ^{
		@strongify(self)
		self.view.viewState = XJHViewStateNetworkFail;
	};
	self.view.stateProperties.networkAction = ^{
		@strongify(self)
		self.view.viewState = XJHViewStateNoData;
	};
	self.view.stateProperties.imageSize = CGSizeMake(50, 50);
    self.view.viewState = XJHViewStatePlaceholder;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.view.viewState = XJHViewStateLoading;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.view.viewState = XJHViewStateNoData;
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
