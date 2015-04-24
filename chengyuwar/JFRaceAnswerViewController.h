//
//  JFNormalAnswerViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFAlertView.h"
#import "JFIdiomModel.h"
#import "JFIdiomDetailView.h"
#import "JFPropButton.h"
#import "JFAnswerRightView.h"
#import "JFFreeGoldVew.h"
#import "JFPlayerChangeView.h"
#import "JFAnswerSucView.h"
#import "JFAnswerFailView.h"
#import "JFAudioPlayerManger.h"
#import "JFRaceManger.h"
#import "JFChangeView.h"
#import "JFPlayRaceManger.h"
//#import "YouMiView.h"
#import "DownloadHttpFile.h"
#import "JFAlertUpdateView.h"
#import "JFRankManger.h"
#import "JFFreeGiftView.h"
#import "iToast.h"

@interface JFRaceAnswerViewController : UIViewController<JFAlertViewDeledate,JFIdiomDetailViewDelegate,JFPropButtonDelegate,JFAnswerResultDelegate,JFPlayRaceMangerDelegate,JFAlertUpdateViewDelegate,DownloadHttpFileDelegate,JFRaceMangerdelegate,JFFreeGiftViewDelegate>
{
    
    UIImageView             *m_levelView;
    UIImageView             *m_goldView;
    int                     m_itotalLevels;
    int                     m_imytotalLevels;
    JFIdiomDetailView       *m_idiomView;
    
    
    
    JFPlayerChangeView      *m_leftView;
    JFPlayerChangeView      *m_rightView;
    JFAudioPlayerManger     *m_playbgManger;
    JFRaceManger            *m_raceManger;
    BOOL                    m_bIsRacing;
    
    
    JFPlayRaceManger        *m_aniManger;
    BOOL                    m_bIsFirstLoad;

    NSTimeInterval          m_fOldtimer;
    
   
    JFFreeGiftView           *m_freeGiftView;
}

@property(nonatomic,retain)JFIdiomModel  *idiomModel;
@property(nonatomic,retain)JFPropButton  *firstButton;
@property(nonatomic,retain)JFPropButton  *secondButton;
@property(nonatomic,retain)NSString     *currentuserID;
@property(nonatomic,retain)NSString     *currentWinUserID;
-(id)initWithWithIdiomModel:(JFIdiomModel*)model;
@end
