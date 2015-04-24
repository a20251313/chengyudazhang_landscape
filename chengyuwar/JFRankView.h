//
//  JFRankView.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRankModel.h"
#import "JFRankCell.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "JFAlertView.h"
typedef enum
{
    JFRankViewTypeNone,
    JFRankViewTypeWeek,
    JFRankViewTypeMonth,
    JFRankViewTypeTotal
    
}JFRankViewType;


@protocol JFRankViewDelegate <NSObject>

@optional;
-(void)requestData:(JFRankViewType)type;
-(void)clickBackBtn:(id)sender;
@end
@interface JFRankView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray     *m_arrdata;
    UITableView        *m_tableView;
    UIImageView        *m_imageViewType;
    UIImageView        *m_imageViewtitle;
    
    UITableView        *m_tableMe;
    id<JFRankViewDelegate>  delegate;
    
    CGFloat             fcellHeight;
}
@property(nonatomic,retain)JFRankModel  *userSelfModel;
@property(nonatomic)JFRankViewType  rankType;
@property(nonatomic,assign)id<JFRankViewDelegate> delegate;
@property(nonatomic)BOOL    showSelf;



-(void)setWinNumber:(int)winNumber;
- (id)initWithFrame:(CGRect)frame  withType:(JFRankViewType)viewType;
-(void)updateWithModelWithArray:(NSMutableArray*)arrdata type:(JFRankViewType)type userSelf:(JFRankModel*)model;
@end
