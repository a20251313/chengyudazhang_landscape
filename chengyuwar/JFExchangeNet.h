//
//  JFExchangeNet.h
//  chengyuwar
//
//  Created by ran on 14-1-9.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFHttpRequsetManger.h"
@protocol JFExchangeNetDelegate <NSObject>

@optional
-(void)getExchangeCoderesult:(int)status addNumber:(int)addnumber;
-(void)networkOccurError:(NSString*)statusCode;
@end


@interface JFExchangeNet : NSObject<JFHttpRequsetMangerDelegate>
{
    JFHttpRequsetManger     *m_httpRequest;
    id<JFExchangeNetDelegate> delegate;
}
@property(nonatomic,assign)id<JFExchangeNetDelegate>   delegate;



-(void)requestExchangeCode:(NSString*)userID exchangeCode:(NSString*)exchangeCode;
@end
