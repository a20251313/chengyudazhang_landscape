//
//  JFRankViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRankView.h"
#import "JFRankReq.h"
@interface JFRankViewController : UIViewController<JFRankViewDelegate,JFRankReqDelegate>
{
    NSMutableArray      *m_arrayMonth;
    NSMutableArray      *m_arrayWeek;
    NSMutableArray      *m_arrayTotal;
    JFRankView          *m_rankView;
    JFRankReq           *m_rankReq;
    
    JFRankViewType      m_irankviewtype;
}


@property(nonatomic,retain)JFRankModel  *modelWeek;
@property(nonatomic,retain)JFRankModel  *modelMonth;
@property(nonatomic,retain)JFRankModel  *modelTotal;


@end
