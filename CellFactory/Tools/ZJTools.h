//
//  ZJTools.h
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AnimationType) {
    Show,
    Hide
};

@interface ZJTools : NSObject

/** 标题Lable  */
+(UILabel*)titleLableWithFrame:(CGRect)frame;

/** 子标题Lable*/
+(UILabel*)digestLableWithFrame:(CGRect)frame;

/** 跟帖数Lable*/
+(UILabel*)replyCountLableWithFrame:(CGRect)frame;

/** 跟帖数Lable宽度*/
+(void)replyCountLableWidth:(NSNumber*)data Height:(CGFloat)height font:(CGFloat)font view:(UILabel*)lable;

/** 时间Lable*/
+(UILabel*)timeLableWithFrame:(CGRect)frame;

/** 时间戳转日期*/
+(NSString*)timeStampToDate:(NSNumber*)time;

/** 视图出现动画(未使用)*/
+(CAAnimationGroup*)animationGroupWithType:(AnimationType)type;
@end
