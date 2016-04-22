//
//  ZJLabelCollectiongViewCell.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJLabelCollectiongViewCell.h"

@implementation ZJLabelCollectiongViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView{
    
    self.title = [ZJTools replyCountLableWithFrame:self.contentView.bounds];
    self.title.textColor = [UIColor blackColor];
    self.title.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.title];
}

@end
