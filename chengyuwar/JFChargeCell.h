//
//  JFChagreCell.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFChargeProductModel.h"

@protocol JFChargeCellDelegate <NSObject>

-(void)chargeProductModel:(JFChargeProductModel*)model;

@end
@interface JFChargeCell : UITableViewCell
{
    UILabel     *m_labelMoney;
    UIImageView *m_imageIcon;
    UIButton    *m_btnPurchase;
    id<JFChargeCellDelegate>  delegate;
}

@property(nonatomic,retain)JFChargeProductModel  *model;
@property(nonatomic,assign)id<JFChargeCellDelegate> delegate;

-(void)updateDataWithModel:(JFChargeProductModel*)tempModel;
@end
