//
//  XJHTableViewController.m
//  XJHViewState_Example
//
//  Created by xujunhao on 2018/6/14.
//  Copyright © 2018年 许君浩. All rights reserved.
//

#import "XJHTableViewController.h"
#import "XJHWebViewController.h"
#import "UIView+State.h"
#import "XJHViewStateProperty.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

static NSString * const kTableCellIdentifier = @"TableCellIdentifier";

@interface XJHTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation XJHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self buildUIComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Method

- (void)dismissAction {
	[self dismissViewControllerAnimated:YES completion:^{
		
	}];
}

- (void)goToNextAction {
	[self presentViewController:[[XJHWebViewController alloc] init] animated:YES completion:^{
		
	}];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger row = [indexPath row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTableCellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTableCellIdentifier];
	}
	[cell.stateProperties configImage:[UIImage imageNamed:@"空数据占位图"] forState:XJHViewStateNoData];
	[cell.stateProperties configTitle:@"暂无数据" forState:XJHViewStateNoData];
	@weakify(self)
	cell.stateProperties.noDataAction = ^{
		@strongify(self)
		switch (row) {
			case 0:
				[self dismissAction];
				break;
			default:
				[self goToNextAction];
				break;
		}
	};
	cell.viewState = XJHViewStateNoData;
	return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

#pragma mark - UITableViewDelegate Methods

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
		[cell setSeparatorInset:UIEdgeInsetsZero];
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 200.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	return [[UIView alloc] init];
}

#pragma mark - Build UI Method

- (void)buildUIComponent {
	[self.view addSubview:self.tableView];
	[self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(self.view);
	}];
}

#pragma mark - Lazy load Method

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
		_tableView.backgroundColor = [UIColor whiteColor];
		_tableView.tableFooterView = [UIView new];
		_tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		_tableView.rowHeight = 200.0f;
		[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableCellIdentifier];
		//1.调整(iOS7以上)表格分隔线边距
		if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
			_tableView.separatorInset = UIEdgeInsetsZero;
		}
		//2.调整(iOS8以上)view边距(或者在cell中设置preservesSuperviewLayoutMargins,二者等效)
		if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
			_tableView.layoutMargins = UIEdgeInsetsZero;
		}
		[_tableView setSeparatorColor:[UIColor redColor]];
		_tableView.delegate = self;
		_tableView.dataSource = self;
	}
	return _tableView;
}


@end
