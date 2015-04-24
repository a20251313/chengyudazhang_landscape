//
//  JFLevelCell.h
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFLevelModel.h"
@interface JFLevelCell : UITableViewCell
{
    UILabel     *m_labelName;
    UILabel     *m_labelDescription;
}

@property(nonatomic,retain)JFLevelModel *model;

-(void)updateViewAccordCell:(JFLevelModel*)levelModel;

@end
