//
//  JFRankManger.h
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFRankView.h"
#import "JFRankReq.h"
@interface JFRankManger : NSObject<JFRankViewDelegate,JFRankReqDelegate>
{
    NSMutableArray      *m_arrayData;
    UIView              *m_rankView;
    JFRankReq           *m_rankReq;
    
}
@property(nonatomic,retain)JFRankModel  *selfModel;


-(void)showRankView;
@end
