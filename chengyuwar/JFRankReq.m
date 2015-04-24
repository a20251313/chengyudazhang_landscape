//
//  JFRankReq.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankReq.h"
#import "JFLocalPlayer.h"
@implementation JFRankReq
@synthesize delegate;
@synthesize ranktype;



-(void)dealloc
{
    m_httpRequset.delegate = nil;
    [m_httpRequset release];
    m_httpRequset = nil;
    [super dealloc];
}

-(void)sendToGetRankList:(NSString*)userID rankType:(JFRankListType)type
{
    
    if (!m_httpRequset)
    {
        m_httpRequset = [[JFHttpRequsetManger alloc] init];
        m_httpRequset.delegate = self;
    }
    self.ranktype = type;
    [m_httpRequset startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id",@(type),@"ranking_type", nil] requestURL:@"get_ranking_list"];
    
}

-(void)requestPersonalInfo:(NSString*)userID
{
    
    if (!m_httpRequset)
    {
        m_httpRequset = [[JFHttpRequsetManger alloc] init];
        m_httpRequset.delegate = self;
    }
    
    [m_httpRequset startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id", nil] requestURL:@"personal_vs_info"];
    
}





-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString *)requestString
{
    int  status = [[dicInfo valueForKey:@"result"] intValue];
    
    DLOG(@"getServerResult:%d   mangerrequetstring:%@ dicInfo:%@ ",status,requestString,dicInfo);
    
    if ([requestString isEqualToString:@"get_ranking_list"])
    {
        JFRankModel *modelself = [[JFRankModel alloc] init];
        modelself.nickName = nil;
        modelself.rankIndex = [[dicInfo valueForKey:@"personal_ranks"] intValue];
        modelself.userRankScore = [[dicInfo valueForKey:@"personal_score_num"] intValue];
        
      //  [[JFLocalPlayer shareInstance] setScore:modelself.userRankScore];
      //  [[JFLocalPlayer shareInstance] setWinNumber:modelself.userRankScore/3];
        
        NSMutableArray  *arrayRank = [NSMutableArray array];
        
        
        NSArray *array = [dicInfo valueForKey:@"ranking_list"];
        int rankindex = 1;
        for (NSDictionary   *dicRank in array)
        {
            JFRankModel *rankModel = [[JFRankModel alloc] init];
            rankModel.nickName = [dicRank valueForKey:@"user_name"];
            if (!rankModel.nickName || [rankModel.nickName isEqualToString:@""])
            {
                rankModel.nickName = [[dicRank valueForKey:@"user_id"] description];
            }
            rankModel.userRankScore = [[dicRank valueForKey:@"user_score"] intValue];
            rankModel.rankIndex = rankindex;
            rankindex++;
            [arrayRank addObject:rankModel];
            [rankModel release];
        }
        
        if (delegate && [delegate respondsToSelector:@selector(getRankIndexArray:type:selfModel:)])
        {
            [delegate getRankIndexArray:arrayRank type:self.ranktype selfModel:modelself];
        }
        
        [modelself release];
    }else if ([requestString isEqualToString:@"personal_vs_info"])
    {
        if (delegate && [delegate respondsToSelector:@selector(getPersionalInfo:info:)])
        {
            [delegate getPersionalInfo:status info:dicInfo];
        }
    }
}


-(void)getNetError:(NSString*)statusCode requsetString:(NSString *)requestString
{
    if (delegate && [delegate respondsToSelector:@selector(getNetError:)])
    {
        [delegate getNetError:statusCode];
    }
    DLOG(@"getNetError:%@ reauestString:%@",statusCode,requestString);
}
@end
