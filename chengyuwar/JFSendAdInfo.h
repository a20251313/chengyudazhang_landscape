//
//  JFSendAdInfo.h
//  chengyuwar
//
//  Created by ran on 14-1-14.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JFHttpRequsetManger.h"
@interface JFSendAdInfo : NSObject<JFHttpRequsetMangerDelegate>
{
    JFHttpRequsetManger     *m_http;
}



+(void)sendShowAD:(NSString*)userID adType:(int)adType;
@end
