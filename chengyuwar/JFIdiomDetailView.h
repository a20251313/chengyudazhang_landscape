//
//  JFIdiomDetailView.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFIdiomModel.h"
#import "JFPropModel.h"
#import "JFAudioPlayerManger.h"
#import "MCProgressBarView.h"

typedef enum
{
    JFIdiomDetailViewStatusDefault,         //什么都不做
    JFIdiomDetailViewStatusCounting,        // 倒计时中
    JFIdiomDetailViewStatusCounted        //倒计时结束
}JFIdiomDetailViewStatus;

typedef enum
{
    JFIdiomDetailViewTypeNormal,         //闯关模式
    JFIdiomDetailViewTypeRace           //竞赛模式
}JFIdiomDetailViewType;

@protocol JFIdiomDetailViewDelegate <NSObject>
-(void)answerIdiomSuc:(JFIdiomModel*)model isUsedAvoidprop:(BOOL)isUsed isTimeOut:(BOOL)isTimeOut;
-(void)answerIdiomOverTime:(JFIdiomModel *)model;
@end
@interface JFIdiomDetailView : UIView
{
    
    NSMutableArray                  *m_arrayOption;
    NSMutableArray                  *m_arrayBtnOption;
    NSMutableArray                  *m_arrayBtnAnswer;
    MCProgressBarView               *m_progressView;
    UIImageView                     *m_imageAnswer;
    
    
    
    int                             m_ianswercount;
    id<JFIdiomDetailViewDelegate>   delegate;
    
    
    int                             m_iTotalSecond;
    int                             m_iSecond;
    NSTimer                         *m_timer;
    JFIdiomDetailViewStatus         m_iViewStatus;
    JFIdiomDetailViewType           m_iViewType;
    
    JFAudioPlayerManger             *m_audioManger;
    BOOL                            m_bisAnswerRight;
    
    int                             m_oldTimeInter;
    BOOL                            m_bIsNeedCount;
    BOOL                            m_bIsFailed;
    NSLock                          *m_lock;
}

@property(nonatomic,assign)id<JFIdiomDetailViewDelegate>  delegate;
@property(nonatomic,retain)JFIdiomModel  *model;
@property(nonatomic,readonly)JFIdiomDetailViewStatus viewStatus;
@property(nonatomic)JFIdiomDetailViewType  viewType;
@property(nonatomic)int     remainCountDown;
@property(nonatomic)BOOL    answerRight;
@property(nonatomic)BOOL    isFailed;

-(BOOL)isRightAnswerInForm;
-(void)updateViewAccordModel:(JFIdiomModel*)tempModel;
-(NSString*)getNowOptionStr;
-(NSString*)getNowAnswerStr;

- (id)initWithFrame:(CGRect)frame  withModel:(JFIdiomModel*)tempModel;
- (id)initWithFrame:(CGRect)frame;
-(void)startAnswer:(int)totalTimer;
-(void)stopTimer:(id)Thread;
-(void)usePropWithType:(JFPropModelType)modelType;
-(void)setProgreViewHidden:(BOOL)bHide;
-(void)addCoverView:(id)Thread;
-(void)removeCoverView:(id)thread;
-(void)setStringAfterLoadModel:(NSString*)optionStr answerStr:(NSString*)strAnswer;
@end
