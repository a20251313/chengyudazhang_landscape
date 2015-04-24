//
//  JFRankCell.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRankModel.h"
@interface JFRankCell : UITableViewCell
{
    UILabel     *m_labelName;
    UIImageView *m_rankView;
    UILabel     *m_rankLabel;
    UILabel     *m_labelGold;
    
    UIImageView *m_rankLevel;
}


@property(nonatomic,retain)JFRankModel  *model;
@property(nonatomic)CGFloat         cellHeight;


-(void)updateCellWithModel:(JFRankModel*)tempmodel;
@end
