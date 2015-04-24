//
//  JFChargeView.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFChargeCell.h"
#import "JFChargeNet.h"
#import "JFAlertView.h"
#import "MBProgressHUD.h"
#import "JFExchangeView.h"
@interface JFChargeView : UIView<UITableViewDataSource,UITableViewDelegate,JFChargeCellDelegate,JFChargeNetDelegate>
{
    UITableView   *m_tableView;
    NSMutableArray *m_arrayData;
    JFChargeNet    *m_chargeNet;
}


-(void)show;

@end
