//
//  ZJTitleLable.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJTitleLable.h"

@implementation ZJTitleLable

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:12];
        self.scale = 0;
    }
    return self;
}

/** 通过scale的改变调整其他参数*/
-(void)setScale:(CGFloat)scale{
    
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1-minScale)*scale;
    //按照比例缩放
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
    
}
@end
