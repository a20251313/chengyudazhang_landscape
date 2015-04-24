//
//  JFRaceReq.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFHttpRequsetManger.h"
#import "JFWarProtrol.h"
#import "JFPhaseXmlData.h"
#import "JFRankView.h"

@protocol JFRaceReqDelegate <NSObject>
-(void)getOnlineNumber:(eSDStatus)status number:(int)onlineNumber;
-(void)getPersionalInfo:(eSDStatus)status info:(NSDictionary*)dicInfo;
-(void)getStartGameResult:(NSDictionary*)dicInfo;
-(void)getNetErrorOccur:(NSString*)errorCode;
-(void)getCommonInfoInRace:(eSDStatus)status LanchModel:(JFLanchModel*)model;
@end

@interface JFRaceReq : NSObject<JFHttpRequsetMangerDelegate>
{
    id<JFRaceReqDelegate>   delegate;
    JFHttpRequsetManger     *m_httpResuest;
}

@property(nonatomic,assign)id<JFRaceReqDelegate> delegate;


-(void)requestOnlineNumber:(NSString*)userID;
-(void)requestPersonalInfo:(NSString*)userID;
-(void)getCommonInfo:(id)Thread;
-(void)startGame;
-(void)resetWarProtrol;



//-(void)insertDataToSQLForRace;

@end
