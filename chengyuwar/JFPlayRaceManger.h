//
//  JFPlayRaceManger.h
//  chengyuwar
//
//  Created by ran on 13-12-31.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JFPlayRaceMangerDelegate <NSObject>

-(void)playAniFinish:(id)Thread;

@end
@interface JFPlayRaceManger : NSObject
{
     NSMutableArray                 *m_arrayBeforeAni;
     NSMutableArray                 *m_arrayAfter;
     id<JFPlayRaceMangerDelegate>    delegate;
    
    BOOL               m_bStop;
}
@property(nonatomic,assign)id<JFPlayRaceMangerDelegate> delegate;

-(void)stopAni;
-(void)playReadyAni;
-(void)playFailAni:(CGFloat)aniDuction;
-(void)playSucAni:(CGFloat)aniDuction;
@end
