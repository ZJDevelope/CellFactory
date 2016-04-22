//
//  ZJBaseNewsTableViewCell.h
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
@interface ZJBaseNewsTableViewCell : UITableViewCell


@property(nonatomic,retain)UIImageView *titleImage;

@property(nonatomic,retain)UILabel *titleLable;

@property(nonatomic,retain)UILabel *digestLable;



-(void)getDataWithModel:(id)model;


@end
