//
//  JFFreeGoldVew.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicClass.h"
#import "JFLocalPlayer.h"

@protocol JFFreeGoldVewDelegate <NSObject>

-(void)clickToAddGoldNumber:(int)addgoldNumber;
-(void)clickToGainreward:(id)thread;

@end
@interface JFFreeGoldVew : UIView
{
    UIButton                    *m_btntreasure;
    NSTimer                     *m_timer;
    int                         m_iseconds;
    id<JFFreeGoldVewDelegate>   delegate;
    BOOL                        m_biSGainGold;
    int                         m_oldTimeInter;
}
@property(nonatomic)int remainCountDown;
@property(nonatomic)BOOL    isGainGold;
@property(nonatomic,assign)id<JFFreeGoldVewDelegate>   delegate;
@property(nonatomic)BOOL    needPlayCangain;

-(void)startCountOntime:(int)timer;
-(void)stopTimer;
@end
