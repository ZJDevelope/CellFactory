//
//  ZJSqliteFMDBTool.h
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJSqliteFMDBTool : NSObject

+ (NSMutableArray *)selectedChannels;
+ (void)delectedAll;
+ (void)addChannelWithDic:(NSDictionary *)dic;
+ (void)addChannelsWithArr:(NSMutableArray *)arr;

@end
