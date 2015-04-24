//
//  JFLanchRequest.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFHttpRequsetManger.h"
#import "JFLanchModel.h"
@protocol JFLanchRequestDelegate <NSObject>

-(void)getCommoninfo:(eSDStatus)status lanchModel:(JFLanchModel*)model;
-(void)getDailySignResult:(eSDStatus)status;
-(void)getUserIDResult:(eSDStatus)status dicInfo:(NSDictionary*)dicInfo;
@optional
-(void)getNetError:(int)statusCode;

@end
@interface JFLanchRequest : NSObject<JFHttpRequsetMangerDelegate>
{
    id<JFLanchRequestDelegate>  delegate;
    JFHttpRequsetManger         *m_httpResuest;
}
@property(nonatomic,assign)id<JFLanchRequestDelegate>  delegate;

-(void)getCommonInfo:(id)Thread;
-(void)sendDailySignedReq:(int)userID;
-(void)getUserID:(NSString*)strGameCenterID;
@end
