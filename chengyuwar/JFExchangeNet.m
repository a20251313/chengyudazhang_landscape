//
//  JFExchangeNet.m
//  chengyuwar
//
//  Created by ran on 14-1-9.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFExchangeNet.h"

@implementation JFExchangeNet
@synthesize delegate;


-(void)requestExchangeCode:(NSString*)userID exchangeCode:(NSString*)exchangeCode
{
    exchangeCode = [exchangeCode uppercaseString];
    JFHttpRequsetManger *manger = [[JFHttpRequsetManger alloc] init];
    manger.delegate = self;
    [manger startRequestData:[NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id",@(CLIENT_PLATFORM),@"platform",@(APP_VERSION),@"version",exchangeCode,@"verify_code",nil] requestURL:@"verify_exchange_code"];
    [manger autorelease];
    
}


-(void)getServerResult:(NSDictionary*)dicInfo requsetString:(NSString *)requestString
{
    if ([requestString isEqualToString:@"verify_exchange_code"])
    {
        if (delegate && [delegate respondsToSelector:@selector(getExchangeCoderesult:addNumber:)])
        {
            [delegate getExchangeCoderesult:[[dicInfo valueForKey:@"result"] intValue] addNumber:[[dicInfo valueForKey:@"add_amount"] intValue]];
        }
    }
    
}
-(void)getNetError:(NSString*)statusCode requsetString:(NSString *)requestString
{
    if (delegate && [delegate respondsToSelector:@selector(networkOccurError:)])
    {
        [delegate networkOccurError:statusCode];
    }
}

-(void)dealloc
{
    m_httpRequest.delegate = nil;
    [m_httpRequest release];
    m_httpRequest = nil;
    [super dealloc];
}





@end
