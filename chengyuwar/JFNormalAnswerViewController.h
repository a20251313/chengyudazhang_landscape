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
#import "JFAudioPlayerManger.h"
#import "JFSQLManger.h"
#import "JFFreeGiftView.h"
@interface JFNormalAnswerViewController : UIViewController<JFAlertViewDeledate,JFIdiomDetailViewDelegate,JFPropButtonDelegate,JFAnswerRightViewDelegate,JFFreeGoldVewDelegate,JFFreeGiftViewDelegate>
{
    
    UIImageView         *m_levelView;
    UIImageView         *m_goldView;
    JFIdiomDetailView   *m_idiomView;
    NSMutableArray      *m_arrayIdioms;
    JFFreeGiftView      *m_freeGiftView;
    JFAudioPlayerManger *m_playerbgManger;
   // immobView           *m_bannerView;
    
}

@property(nonatomic,retain)JFIdiomModel  *idiomModel;
@property(nonatomic,retain)JFPropButton  *trashProp;
@property(nonatomic,retain)JFPropButton  *ideaShowProp;
@property(nonatomic,retain)JFPropButton  *avoidProp;


-(id)initWithWithIdiomModel:(JFIdiomModel*)model arrayIdioms:(NSMutableArray*)array;

@end
