//
//  XJHWebViewController.m
//  XJHViewState_Example
//
//  Created by xujunhao on 2018/6/14.
//  Copyright © 2018年 许君浩. All rights reserved.
//

#import "XJHWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+State.h"
#import "XJHViewStateProperty.h"

@interface XJHWebViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation XJHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self buildUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buildUI {
	[self.view setBackgroundColor:[UIColor whiteColor]];
	[self.view addSubview:self.webView];
	[self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
	@weakify(self)
	self.webView.stateProperties.errorAction = ^{
		@strongify(self)
		[self dismissViewControllerAnimated:YES completion:^{
			
		}];
	};
	[self.webView.stateProperties configImage:[UIImage imageNamed:@"空数据占位图"] forState:XJHViewStateError];
	[self.webView.stateProperties configTitle:@"网页加载失败" forState:XJHViewStateError];
	self.webView.viewState = XJHViewStateError;
}

- (WKWebView *)webView {
	if (!_webView) {
		WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
		configuration.selectionGranularity = WKSelectionGranularityCharacter;
		WKPreferences  *preferences = [[WKPreferences alloc] init];
		preferences.javaScriptEnabled = YES;
		// 默认是不能通过JS自动打开窗口的，必须通过用户交互才能打开
		preferences.javaScriptCanOpenWindowsAutomatically = NO;
		configuration.preferences = preferences;
		_webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
		_webView.navigationDelegate = self;
		_webView.UIDelegate = self;
	}
	return _webView;
}

@end
