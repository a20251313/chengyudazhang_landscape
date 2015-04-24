//
//  JFRankReq.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFHttpRequsetManger.h"
#import "JFRankModel.h"

typedef enum
{
    JFRankListTypeWeek = 1,
    JFRankListTypeMonth = 2,
    JFRankListTypetotal = 3
    
}JFRankListType;


@protocol JFRankReqDelegate <NSObject>

-(void)getRankIndexArray:(NSMutableArray*)arrayRank type:(JFRankListType)type selfModel:(JFRankModel*)selfmodel;
-(void)getNetError:(NSString*)statusCode;
-(void)getPersionalInfo:(eSDStatus)status info:(NSDictionary*)dicInfo;
@end

@interface JFRankReq : NSObject<JFHttpRequsetMangerDelegate>
{
    id<JFRankReqDelegate>   delegate;
    JFHttpRequsetManger     *m_httpRequset;
    
}
@property(nonatomic)JFRankListType  ranktype;

@property(nonatomic,assign)id<JFRankReqDelegate>  delegate;

-(void)sendToGetRankList:(NSString*)userID rankType:(JFRankListType)type;
-(void)requestPersonalInfo:(NSString*)userID;

@end
