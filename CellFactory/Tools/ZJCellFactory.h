//
//  ZJCellFactory.h
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJOneImageTableViewCell.h"
#import "ZJNewsModel.h"
#import "ZJOneBigImageTableViewCell.h"
#import "ZJImagesTableViewCell.h"
#import "ZJBaseNewsTableViewCell.h"
@interface ZJCellFactory : NSObject


typedef NS_ENUM(NSUInteger, CellType){
    
        NewsOneImageCell = 0,
        NewsOneImageCellSpecial,
        // NewsOneImageCellLive,
        NewsImagesCell,
        NewsOneBigImageCell,
        ListenNormalCell,
        CityNormalCell,
        CityImageCell,
};


+(CellType)cellTypeWithModel:(id)model;

+(ZJBaseNewsTableViewCell*)cellWithTableView:(UITableView*)tableView Model:(id)model IndexPath:(NSIndexPath*)indexPath;

+(ZJBaseNewsTableViewCell*)cellWithTableView:(UITableView*)tableView Model:(id)model IndexPath:(NSIndexPath*)indexPath Type:(CellType)type;

+(CGFloat)cellHightWithModel:(id)model;

+(CGFloat)cellHightWithModel:(id)model Type:(CellType)type;
@end
