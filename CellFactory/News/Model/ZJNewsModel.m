//
//  ZJNewsModel.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJNewsModel.h"

@implementation ZJNewsModel



+(instancetype)newsModelWithDic:(NSDictionary *)dic{
    ZJNewsModel *model = [ZJNewsModel new];
    [model setValuesForKeysWithDictionary:dic];
    return model;
    
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

@end
