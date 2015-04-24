//
//  JFRaceHallViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFCreateRoleView.h"
#import "JFAlertView.h"
#import "JFChangeView.h"
#import "JFAlertUpdateView.h"
#import "JFRaceReq.h"
#import "DownloadHttpFile.h"
#import "JFPlayRaceManger.h"
#import "JFRankManger.h"

@interface JFRaceHallViewController : UIViewController<UITextFieldDelegate,JFAlertViewDeledate,JFRaceReqDelegate,JFCreateRoleViewDelegate,DownloadHttpFileDelegate>
{
    UILabel             *m_labelOnlineNumber;
    UILabel             *m_lableMaxwinnumber;
    UILabel             *m_labelwincount;
    UILabel             *m_labelLoseCount;
    UILabel             *m_lableScore;
    UILabel             *m_labelLevel;
    UITextField         *m_textName;
    UIImageView         *m_imageRole;
    JFRaceReq           *m_raceReq;
    UIImageView         *m_goldView;
    NSTimer             *m_timer;
    
    
    BOOL                m_bIsAlert;
    NSMutableArray      *m_arrayNickName;
    
    JFRankManger        *m_rankMyRank;

}

@end
