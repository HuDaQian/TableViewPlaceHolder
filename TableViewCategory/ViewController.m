//
//  ViewController.m
//  TableViewCategory
//
//  Created by HuDaQian on 2016/12/19.
//  Copyright © 2016年 HuXiaoQian. All rights reserved.
//

#import "ViewController.h"

#import "CustomTableView.h"


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    CustomTableView *listTableView;
}
@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self initData];
    [self getData];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - createView
- (void)createView {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:NSLocalizedString(@"ReFresh", nil) forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 64, 80, 20);
    btn.tag = 1000;
    [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    listTableView = [[CustomTableView alloc] initWithFrame:CGRectMake(0, 84, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-84) style:UITableViewStylePlain];
    
    __weak typeof(self) weakSelf = self;
    listTableView.freshBlock = ^(){
        [weakSelf getData];
    };
    listTableView.delegate = self;
    listTableView.dataSource = self;
    [self.view addSubview:listTableView];
    listTableView.tableFooterView = [[UIView alloc] init];
    [listTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"listCell"];
}

#pragma mark - btnMethod
- (void)buttonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 1000:
            [self getData];
            break;
            
        default:
            break;
    }
}

#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - getData
- (void)initData {
    _dataArray = [[NSMutableArray alloc] init];
}
static bool dataStatus = NO;
- (void)getData {
    dataStatus = !dataStatus;
    if (dataStatus) {
        [_dataArray addObjectsFromArray:@[@"1",@"2",@"3",@"4",@"5"]];
    } else {
        [_dataArray removeAllObjects];
    }
    [listTableView reloadData];
}

@end
