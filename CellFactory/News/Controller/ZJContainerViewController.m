//
//  ZJContainerViewController.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJContainerViewController.h"
#import "ZJNewsTableViewController.h"
#import "ZJTitleLable.h"
#import "ZJSqliteFMDBTool.h"
#import "ZJChannelViewController.h"
#import "ZJTools.h"

@interface ZJContainerViewController ()<UIScrollViewDelegate>
/** 新闻接口的数组*/
@property(nonatomic,retain)NSArray *arrayLists;

@property(nonatomic,retain)UIScrollView *titleView;

@property(nonatomic,retain)UIScrollView *vcView;

@property(nonatomic,assign)BOOL selected;


@end

@implementation ZJContainerViewController
- (NSArray *)arrayLists{
    if (!_arrayLists) {
        _arrayLists = [ZJSqliteFMDBTool selectedChannels];
    }return _arrayLists;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self rightBtn];
    [self addController];
    [self creatScrollView];
    [self addLable];

}

/** 添加按钮*/
- (void)rightBtn{
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    [rightBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.title = @"资讯";
    self.view.backgroundColor = [UIColor whiteColor];
    self.selected = NO;
}

- (void)changeChannel:(UIButton *)sender{
    _selected = !_selected;
    CAKeyframeAnimation *annimation = [CAKeyframeAnimation animation];
    annimation.keyPath = @"transform.rotation";
    if (_selected) {
        annimation.values = @[@(0),@(M_PI*0.25)];
    }
    else{
        annimation.values =@[@(M_PI*0.25),@(0)];
    }
    annimation.duration = 0.2;
    annimation.repeatCount = 1;
    annimation.fillMode = kCAFillModeForwards;
    annimation.removedOnCompletion = false;
    [sender.layer addAnimation:annimation forKey:nil];

    
    
    ZJChannelViewController *channel = [self.childViewControllers lastObject];
    if (!channel.view.superview) {
        channel.view.frame = CGRectMake(0, 64, UISCREENWIDTH, UISCREENHEIGHT-64);
        [self.view addSubview:channel.view];
        channel.view.alpha = 0.0;
    }
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.subtype = kCATransitionFromTop;
    if (_selected) {
        channel.userChannelArr = [self.arrayLists mutableCopy];
        channel.view.alpha = 1;
        
    }
    else{
        if (![self.arrayLists isEqual:channel.userChannelArr]) {
            
            self.arrayLists = channel.userChannelArr;
            [self reloadView];
        }
        channel.view.alpha = 0;
    }

    
    
    
    
    
}
/** 重置View*/
-(void)reloadView{
    
    for (UIViewController *temp in self.childViewControllers) {
        [temp removeFromParentViewController];
    }
    
    for (UIView *temp in self.titleView.subviews) {
        [temp removeFromSuperview];
    }
    for (UIView *temp in self.vcView.subviews) {
        [temp removeFromSuperview];
    }
    [self addController];
    [self addLable];
    [self creatScrollView];
    [self.vcView setContentOffset:CGPointMake(0, 0) animated:YES];
}

/**
 *  添加子控制器
 */
- (void)addController{
    for (int i = 0; i < self.arrayLists.count; i++) {
        ZJNewsTableViewController *VC = [[ZJNewsTableViewController alloc] init];
        VC.url = self.arrayLists[i][@"urlString"];
        VC.dataTitle = self.arrayLists[i][@"title"];
        VC.key = self.arrayLists[i][@"key"];
        [self addChildViewController:VC];
    }
    [self addChildViewController:[ZJChannelViewController new]];
}


/** 创建ScrollView*/
-(void)creatScrollView{
    if (self.vcView == nil) {
        self.vcView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 104, UISCREENWIDTH,UISCREENHEIGHT-104)];
    }
    CGFloat contentX = (self.childViewControllers.count-1) * UISCREENWIDTH;
    self.vcView.contentSize = CGSizeMake(contentX, 0);
    self.vcView.pagingEnabled = YES;
    self.vcView.delegate = self;
    if (self.vcView.superview == nil) {
        [self.view addSubview:self.vcView];
    }
    
    //添加默认控制器
    UIViewController *firseVC = [self.childViewControllers firstObject];
    firseVC.view.frame = CGRectMake(0, -64, UISCREENWIDTH, UISCREENHEIGHT-104);
    [self.vcView addSubview:firseVC.view];
    
    ZJTitleLable *lable = [self.titleView.subviews firstObject];
    lable.scale = 1.0;
    self.vcView.showsHorizontalScrollIndicator = NO;
    
    if (self.titleView == nil) {
        self.titleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, UISCREENWIDTH, 40)];
    }
    self.titleView.contentSize = CGSizeMake(70*(self.childViewControllers.count-1), 0);
    self.titleView.showsHorizontalScrollIndicator = NO;
    self.titleView.showsVerticalScrollIndicator = NO;
    if (self.titleView.superview == nil) {
        [self.view addSubview:self.titleView];
    }
    
    
}

/** 添加标题栏*/
-(void)addLable{
    
    
    for (int i = 0; i<self.arrayLists.count; i++) {
        CGFloat lw = 70;
        CGFloat lh = 40;
        CGFloat ly = 0;
        CGFloat lx = i*lw;
        ZJTitleLable *lable = [[ZJTitleLable alloc]init];
        lable.text = self.arrayLists[i][@"title"];
        lable.frame = CGRectMake(lx, ly, lw, lh);
        lable.font = [UIFont systemFontOfSize:22];
        [self.titleView addSubview:lable];
        lable.tag = 1000+i;
        lable.userInteractionEnabled = YES;
        [lable addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lableClick:)]];
    }
    
}

/** 标题点击事件*/
-(void)lableClick:(UITapGestureRecognizer*)tap{
    
    ZJTitleLable *lable = (ZJTitleLable*)tap.view;
    CGFloat offsetx = (lable.tag-1000) * self.vcView.frame.size.width;
    CGFloat offsety = self.vcView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetx, offsety);
    [self.vcView setContentOffset:offset animated:YES];
}


#pragma mark - scrollView Delegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    //获取索引页
    NSUInteger index = scrollView.contentOffset.x/self.vcView.bounds.size.width;
    
    //滚动标题栏
    ZJTitleLable *titleLable = (ZJTitleLable*)self.titleView.subviews[index];
    CGFloat offsetX = titleLable.center.x - self.titleView.frame.size.width * 0.5;
    CGFloat offsetMax = self.titleView.contentSize.width - self.titleView.frame.size.width;
    if (offsetX<0) {
        offsetX = 0;
    }
    else if (offsetX > offsetMax){
        offsetX = offsetMax;
    }
    CGPoint offset = CGPointMake(offsetX, self.titleView.contentOffset.y);
    [self.titleView setContentOffset:offset animated:YES];
    
    [self.titleView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx != index) {
            ZJTitleLable *temp = self.titleView.subviews[idx];
            temp.scale = 0;
        }
    }];
    ZJNewsTableViewController *newsVC = self.childViewControllers[index];
    
    if (newsVC.view.superview)return;
    
    newsVC.view.frame = scrollView.bounds;
    [self.vcView addSubview:newsVC.view];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //  取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    ZJTitleLable *labelLeft = self.titleView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    
    // 考虑到最后一个板块，如果右边已经没有板块了 就不在下面赋值scale了
    if (rightIndex < self.titleView.subviews.count) {
        ZJTitleLable *labelRight = self.titleView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }
}







@end
