//
//  JFSetView.h
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSetCell.h"
#import "JFGameExplainView.h"
#import "JFSetView.h"
#import "JFAlertView.h"

@protocol JFSetViewDelegate <NSObject>

-(void)clickAboutView:(id)sener;
-(void)clickResetBtn:(id)sender;

@end

@interface JFSetView : UIView<UITableViewDataSource,UITableViewDelegate,JFSetCellDelegate,JFAlertViewDeledate>
{
    UITableView   *m_tableView;
    NSMutableArray *m_arrayData;
    id<JFSetViewDelegate>  delegate;
}
@property(nonatomic,assign)id<JFSetViewDelegate>  delegate;
-(void)show;
@end
