//
//  ZJOneImageTableViewCell.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJOneImageTableViewCell.h"
/** 图片与文字以及边线的间距*/
#define ONEIMAGESPACE 10

/** 图片与屏幕宽度的比例*/
#define IMAGESCALE 0.25

@implementation ZJOneImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
    }
    
    return self;
}

-(void)creatUI{
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(ONEIMAGESPACE, ONEIMAGESPACE, UISCREENWIDTH*IMAGESCALE, ONEIMAGECELLHEIGHT-2*ONEIMAGESPACE)];
    [self addSubview:self.titleImage];
    
    self.titleLable = [ZJTools titleLableWithFrame:CGRectMake(1.5*ONEIMAGESPACE+UISCREENWIDTH*IMAGESCALE, ONEIMAGESPACE, UISCREENWIDTH*0.7, ONEIMAGECELLHEIGHT*0.3)];
    [self addSubview:self.titleLable];
    
    self.digestLable = [ZJTools digestLableWithFrame:CGRectMake(1.5*ONEIMAGESPACE+UISCREENWIDTH*IMAGESCALE, ONEIMAGESPACE+ONEIMAGECELLHEIGHT*0.3, UISCREENWIDTH*0.7, ONEIMAGECELLHEIGHT*0.4)];
    [self addSubview:self.digestLable];
    
    
    self.replyCount = [ZJTools replyCountLableWithFrame:CGRectMake(UISCREENWIDTH-50, ONEIMAGESPACE+ONEIMAGECELLHEIGHT*0.6, 40, 20)];
    [self addSubview:self.replyCount];
    
}




-(void)getDataWithModel:(id)model{
    
    ZJNewsModel *newsModel = (ZJNewsModel*)model;
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
    self.titleLable.text = newsModel.title;
    self.digestLable.text = newsModel.digest;
    if ([newsModel.skipType  isEqual: @"special"]) {
        self.replyCount.text = @"专题";
        self.replyCount.textColor = [UIColor redColor];
    }
    else if ([newsModel.skipType isEqual:@"live"]){
        self.replyCount.text = @"直播";
        self.replyCount.textColor = [UIColor blueColor];
    }
    else{
        [ZJTools replyCountLableWidth:newsModel.replyCount Height:20 font:12 view:self.replyCount];
        self.replyCount.textColor = [UIColor grayColor];
    }
    
}



@end
