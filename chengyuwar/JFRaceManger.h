//
//  JFRaceManger.h
//  chengyuwar
//
//  Created by ran on 13-12-30.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "JFHttpRequsetManger.h"
#import "JFWarProtrol.h"
#import "JFPhaseXmlData.h"
@protocol JFRaceMangerdelegate <NSObject>

-(void)getJoinGameResult:(NSDictionary*)dicInfo;
-(void)PlayResult:(NSDictionary*)dicInfo;
-(void)startPlay:(NSDictionary*)dicInfo;
-(void)Play:(NSDictionary*)dicInfo;
-(void)usePropInfo:(NSDictionary*)dicInfo;
-(void)ReConnect:(NSDictionary*)dicInfo;
-(void)Relogin:(NSDictionary*)dicInfo;
-(void)QuitSuc:(id)sender;
-(void)netOccouError:(id)Thread;
-(void)getPersonInfostats:(eSDStatus)status dic:(NSDictionary*)dicInfo;
@end
@interface JFRaceManger : NSObject<JFHttpRequsetMangerDelegate>
{
    id<JFRaceMangerdelegate> delegate;
    JFHttpRequsetManger     *m_httpresuset;
    BOOL                    isrightVersion;
    
}
@property(nonatomic,assign)id<JFRaceMangerdelegate> delegate;


-(void)startGame;
-(void)resetWarProtrol;
-(void)sendPlayResult:(eIdiomWarPlayResult)result;
-(void)sendUseProp:(int)propId;


-(void)requestPersonalInfo:(NSString*)userID;
@end
