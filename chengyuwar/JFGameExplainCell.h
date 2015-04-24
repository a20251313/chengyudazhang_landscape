//
//  JFGameExplainCell.h
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFPropModel.h"
@interface JFGameExplainCell : UITableViewCell
{
    

    UILabel     *m_labelDescrption;
    UIImageView *m_propicon;
    
}

@property(nonatomic,retain)JFPropModel  *model;
-(void)updateCellWithPropModel:(JFPropModel*)tempModel;
@end
