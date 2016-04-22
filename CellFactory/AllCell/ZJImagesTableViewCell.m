//
//  ZJImagesTableViewCell.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJImagesTableViewCell.h"
#import <UIImageView+WebCache.h>
#define IMAGESPACE 10
#define IMAGEWIDTH (UISCREENWIDTH-IMAGESPACE*4)/3

@implementation ZJImagesTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatUI];
        
    }
    
    return self;
}


-(void)creatUI{
    
    self.titleLable = [ZJTools titleLableWithFrame:CGRectMake(IMAGESPACE, IMAGESPACE, 300, IMAGESCELLHEIGHT/6)];
    [self addSubview:self.titleLable];
    
    self.replyCountLable = [ZJTools replyCountLableWithFrame:CGRectMake(0, IMAGESPACE*1.5, 0, IMAGESCELLHEIGHT/6)];
    [self addSubview:self.replyCountLable];
    
    self.titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.titleImage];
    
    self.imageCenter = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE*2+IMAGEWIDTH, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.imageCenter];
    
    self.imageRight = [[UIImageView alloc]initWithFrame:CGRectMake(IMAGESPACE*3+IMAGEWIDTH*2, IMAGESPACE*2+IMAGESCELLHEIGHT/6, IMAGEWIDTH, IMAGESCELLHEIGHT-IMAGESPACE*3-IMAGESCELLHEIGHT/6)];
    [self addSubview:self.imageRight];
    
    
}



-(void)getDataWithModel:(id)model{
    
    ZJNewsModel *newsModel = (ZJNewsModel*)model;
    
    self.titleLable.text = newsModel.title;
    
    [ZJTools replyCountLableWidth:newsModel.replyCount Height:IMAGESCELLHEIGHT/6 font:12 view:self.replyCountLable];
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:newsModel.imgsrc] placeholderImage:nil];
    
    [self.imageCenter sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[0][@"imgsrc"]] placeholderImage:nil];
    
    [self.imageRight sd_setImageWithURL:[NSURL URLWithString:newsModel.imgextra[1][@"imgsrc"]] placeholderImage:nil];
    
}


@end
