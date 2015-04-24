//
//  JFGameExplainView.h
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFGameExplainCell.h"

@interface JFGameExplainView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    UITableView   *m_tableView;
    NSMutableArray *m_arrayData;
}

-(void)show;

@end
