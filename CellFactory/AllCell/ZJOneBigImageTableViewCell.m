//
//  ZJOneBigImageTableViewCell.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJOneBigImageTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "ZJNewsModel.h"
/** 图片与文字以及边线的间距*/
#define ONEBIGIMAGESPACE 10

/** 图片占据Cell高度的比例*/
#define BIGIMAGESCALE 0.65

@implementation ZJOneBigImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    return self;
}

-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGESPACE, UISCREENWIDTH-2*ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE)];
    [self addSubview:self.titleImage];
    
    self.titleLable = [ZJTools titleLableWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5, UISCREENWIDTH-2*ONEBIGIMAGESPACE, 20)];
    [self addSubview:self.titleLable];
    
    self.digestLable = [ZJTools digestLableWithFrame:CGRectMake(ONEBIGIMAGESPACE, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5+25, UISCREENWIDTH-2*ONEBIGIMAGESPACE, 30)];
    [self addSubview:self.digestLable];
    
    self.replyCount = [ZJTools replyCountLableWithFrame:CGRectMake(0, ONEBIGIMAGECELLHEIGHT*BIGIMAGESCALE+ONEBIGIMAGESPACE*1.5+45, 0, 20)];
    [self addSubview:self.replyCount];
}


-(void)getDataWithModel:(id)model{
    
    ZJNewsModel *newsModel = (ZJNewsModel*)model;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
    
    self.titleLable.text = newsModel.title;
    
    self.digestLable.text = newsModel.digest;
    
    [ZJTools replyCountLableWidth:newsModel.replyCount Height:20 font:12 view:self.replyCount];
    
}

@end
