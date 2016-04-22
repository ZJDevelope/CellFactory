//
//  ZJNewsTableViewController.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJNewsTableViewController.h"
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
#import "ZJCellFactory.h"
#import "ZJNewsModel.h"
#import "ZJNetWorkTool.h"
@interface ZJNewsTableViewController ()
/** 数据数组*/
@property(nonatomic,retain)NSMutableArray *dataModelArr;
/** 界面数据计数器*/
@property(nonatomic,assign)NSInteger count;
/** 轮播图*/
@property(nonatomic,retain)UIScrollView *headView;
/** 透视图图片数组*/
@property(nonatomic,retain)NSArray *headViewImagesArr;

@end

@implementation ZJNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.count = 1;
    self.dataModelArr = [NSMutableArray new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadDataInfo)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(newDataInfo)];
    [self.tableView.mj_header beginRefreshing];
    
    NSLog(@"%@",self.url);
}

-(void)creatheadView{
    
    self.headView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 200)];
    ZJNewsModel *model = [self.dataModelArr firstObject];
    self.headView.pagingEnabled = YES;
    self.headViewImagesArr = model.ads;
    self.headView.contentSize = CGSizeMake(UISCREENWIDTH * self.headViewImagesArr.count, 0);
    for (int i = 0; i<self.headViewImagesArr.count; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(UISCREENWIDTH*i, 0, UISCREENWIDTH, 200)];
        [image sd_setImageWithURL:[NSURL URLWithString:self.headViewImagesArr[i][@"imgsrc"]] placeholderImage:[UIImage imageNamed:@"桌面"]];
        [self.headView addSubview:image];
    }
    
}


/** 刷新数据*/
-(void)newDataInfo{
    NSString *head = @"http://c.m.163.com/nc/article/";
    NSString *foot = [NSString stringWithFormat:@"/%ld-20.html",20*self.count];
    NSString *temp = [NSString stringWithFormat:@"%@%@%@",head,self.url,foot];
    [ZJNetWorkTool getWithURL:temp paramer:nil httpHeader:nil responseType:ResponseTypeJSON progress:nil success:^(id result) {
        result = [result objectForKey:self.key];
        if (result == nil) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        else{
            for (NSDictionary *dic in result) {
                ZJNewsModel *model = [ZJNewsModel newsModelWithDic:dic];
                [self.dataModelArr addObject:model];
                [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:self.dataModelArr.count-2 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];

    }];
       self.count++;
}

/** 加载数据*/
-(void)reloadDataInfo{
    [self.dataModelArr removeAllObjects];
    [self.tableView reloadData];
    NSString *head = @"http://c.m.163.com/nc/article/";
    NSString *foot = @"/0-20.html";
    NSString *temp = [NSString stringWithFormat:@"%@%@%@",head,self.url,foot];
    [ZJNetWorkTool getWithURL:temp paramer:nil httpHeader:nil responseType:ResponseTypeJSON progress:nil success:^(id result) {
        result = [result objectForKey:self.key];
        for (NSDictionary *dic in result) {
            ZJNewsModel *model = [ZJNewsModel newsModelWithDic:dic];
            [self.dataModelArr addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        if (self.headView == nil) {
            [self creatheadView];
        }
        if (self.headViewImagesArr.count) {
            
            self.tableView.tableHeaderView = self.headView;
        }

    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
/** section count*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
/** rows in secion*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModelArr.count-1;
}
/** cell */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJNewsModel *model = self.dataModelArr[indexPath.row+1];
    return  [ZJCellFactory cellWithTableView:tableView Model:model IndexPath:indexPath];
}
/** cell hight*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJNewsModel *model = self.dataModelArr[indexPath.row+1];
    return [ZJCellFactory cellHightWithModel:model];
}




@end
