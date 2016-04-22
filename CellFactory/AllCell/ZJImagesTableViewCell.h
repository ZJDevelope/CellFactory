//
//  ZJImagesTableViewCell.h
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJBaseNewsTableViewCell.h"
#import "ZJTools.h"
#import "ZJNewsModel.h"
#import "ZJBaseNewsTableViewCell.h"
@interface ZJImagesTableViewCell : ZJBaseNewsTableViewCell
/** 三个图片*/
@property(nonatomic,retain)UIImageView *imageCenter;
@property(nonatomic,retain)UIImageView *imageRight;


/** 跟帖数*/
@property(nonatomic,retain)UILabel *replyCountLable;

@end
