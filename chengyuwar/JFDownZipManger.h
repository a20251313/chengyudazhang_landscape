//
//  JFDownZipManger.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadHttpFile.h"
#import "UtilitiesFunction.h"
#import "JFSQLManger.h"
#import "JFDownUrlModel.h"
#import "DownloadHttpFileDelegate.h"

@protocol JFDownZipMangerDelegate <NSObject>
- (void)setProgress:(float)newProgress;
- (void)downLoadZipSuc:(NSMutableArray*)arrDownload;
@end


@interface JFDownZipManger : NSObject<DownloadHttpFileDelegate>
{
    int                             m_idownCount;
    NSMutableArray                  *m_arrayUrls;
    id<JFDownZipMangerDelegate>     delegate;
}
@property(nonatomic,assign)id<JFDownZipMangerDelegate> delegate;


-(void)startDownLoadZip:(NSMutableArray *)arrayurls;
@end
