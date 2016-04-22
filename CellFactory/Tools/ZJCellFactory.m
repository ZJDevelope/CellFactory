//
//  ZJCellFactory.m
//  CellFactory
//
//  Created by 张剑 on 16/4/20.
//  Copyright © 2016年 张剑. All rights reserved.
//

#import "ZJCellFactory.h"

@implementation ZJCellFactory

+(ZJBaseNewsTableViewCell *)cellWithTableView:(UITableView *)tableView Model:(id)model IndexPath:(NSIndexPath *)indexPath{
    return  [self cellWithTableView:tableView Model:model IndexPath:indexPath Type:[self cellTypeWithModel:model]];
}

+(CGFloat)cellHightWithModel:(id)model{
    return [self cellHightWithModel:model Type:[self cellTypeWithModel:model]];
}

+(CellType)cellTypeWithModel:(id)model{
    
        ZJNewsModel *newsModel = (ZJNewsModel*)model;
        if (newsModel.imgType)                                          return NewsOneBigImageCell;
        else if (newsModel.imgextra)                                    return NewsImagesCell;
        else if ([newsModel.skipType isEqual:@"special"])               return NewsOneImageCellSpecial;
        else                                                            return NewsOneImageCell;
    
}

+(ZJBaseNewsTableViewCell *)cellWithTableView:(UITableView *)tableView Model:(id)model IndexPath:(NSIndexPath *)indexPath Type:(CellType)type{
    ZJBaseNewsTableViewCell *result = nil;
    switch (type) {
        case NewsOneImageCell:
            result = [tableView dequeueReusableCellWithIdentifier:NEWSONEIMAGECELL];
            break;
        case NewsOneBigImageCell:
            result = [tableView dequeueReusableCellWithIdentifier:NEWSONEBIGIMAGECELL];
            break;
        case NewsImagesCell:
            result = [tableView dequeueReusableCellWithIdentifier:NEWSIMAGESCELL];
            break;
        case NewsOneImageCellSpecial:
            result = [tableView dequeueReusableCellWithIdentifier:NEWSONEIMAGECELLSPECIAL];
            break;
        case ListenNormalCell:
            result = [tableView dequeueReusableCellWithIdentifier:LISTENCELL];
            break;
        case CityNormalCell:
            result = [tableView dequeueReusableCellWithIdentifier:CITYNORMAL];
            break;
        case CityImageCell:
            result = [tableView dequeueReusableCellWithIdentifier:CITYIMAGE];
    }
    
    [result getDataWithModel:model];
    return result;
}

+(CGFloat)cellHightWithModel:(id)model Type:(CellType)type{
    
    switch (type) {
        case NewsOneImageCell:
            return ONEIMAGECELLHEIGHT;
            break;
        case NewsOneBigImageCell:
            return ONEBIGIMAGECELLHEIGHT;
            break;
        case NewsImagesCell:
            return IMAGESCELLHEIGHT;
            break;
        case NewsOneImageCellSpecial:
            return ONEIMAGECELLHEIGHT;
        case ListenNormalCell:
        case CityImageCell:
        case CityNormalCell:
            return LISTENCELLHEIGHT;
            break;
    }
    
}


@end
