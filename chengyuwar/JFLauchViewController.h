//
//  JFViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-10.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFGameCenterManger.h"
#import "JFAppSet.h"
#import "JFLocalPlayer.h"
#import "JFConLoginView.h"
#import "JFSetView.h"
#import "JFAboutViewController.h"
#import "JFCheckPointViewController.h"
#import "JFRankViewController.h"
#import "JFCreateRoleView.h"
#import "JFRaceHallViewController.h"
#import "JFNoticeUserView.h"
#import "JFAudioPlayerManger.h"
#import "JFLanchRequest.h"
#import "DownloadHttpFile.h"
#import "JFDownZipManger.h"
#import "DownloadHttpFileDelegate.h"
#import "JFChargeNet.h"

@interface JFLauchViewController : UIViewController<JFGameCenterMangerDelegate,JFConLoginViewDelegate,JFSetViewDelegate,JFLanchRequestDelegate,JFAlertViewDeledate,DownloadHttpFileDelegate,JFDownZipMangerDelegate,JFCreateRoleViewDelegate,JFChargeNetDelegate>
{
    JFAudioPlayerManger     *m_playManger;
    JFLanchRequest          *m_lanchReq;
    BOOL                    m_bhasgetUserID;
    JFDownZipManger         *m_downzipManger;
    
    NSMutableArray          *m_arrAllUrl;
    NSMutableArray          *m_arrayIdioms;
    JFChargeNet             *m_undealNet;   //just for undeal charge info
    
    BOOL                    m_bIsMovePath;
    BOOL                    m_bIsWritingDB;
    BOOL                    m_bIsShowGClogin;
}
@property(nonatomic,retain)JFLanchModel *model;

@end
