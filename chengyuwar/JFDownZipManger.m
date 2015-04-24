//
//  JFDownZipManger.m
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFDownZipManger.h"
#import "DownloadHttpFileDelegate.h"
#import "DownloadHttpInfo.h"
@implementation JFDownZipManger
@synthesize delegate;

-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayUrls = [[NSMutableArray alloc] init];
        m_idownCount = 0;
    }
    return self;
}


-(void)startDownLoadZip:(NSMutableArray *)arrayurls
{
    if ([arrayurls count])
    {
        [m_arrayUrls removeAllObjects];
        [m_arrayUrls addObjectsFromArray:arrayurls];
        if (m_idownCount < [arrayurls count])
        {
            [self startDownloadUrl:[arrayurls objectAtIndex:m_idownCount]];
        }else
        {
            DLOG(@"startDownLoadZip fail:%@ m_idownCount:%d",m_arrayUrls,m_idownCount);
        }
    }
}

-(void)startDownloadUrl:(JFDownUrlModel*)model
{
    
    DownloadHttpInfo    *object = nil;
    
    switch (model.urlType)
    {
        case JFDownUrlModelTypeNormalQustion:
            object = [[DownloadHttpInfo alloc] initWithDelegate:self fileUrl:model.urlString fileName:model.md5String downType:DownloadHttpFileDownTypeNormalQusetionZip];
            object.isNeedUnzip = YES;
            object.isNeedProgress = YES;
            break;
        case JFDownUrlModelTypeRaceQustion:
            object = [[DownloadHttpInfo alloc] initWithDelegate:self fileUrl:model.urlString fileName:model.md5String downType:DownloadHttpFileDownTypeRaceQusetionZip];
            object.isNeedUnzip = YES;
            object.isNeedProgress = YES;
            break;
            
        default:
            break;
    }
    
    [DownloadHttpFile addDownFileObjects:object];
    [object release];
    
}
-(void)dealloc
{
    [DownloadHttpFile CleanDelegateOfObject:self];
    [m_arrayUrls release];
    m_arrayUrls = nil;
    [super dealloc];
}


- (void)setProgress:(float)newProgress
{
    CGFloat progress = m_idownCount*1.0f/([m_arrayUrls count]*1.0f);
    progress += newProgress*(1.0f/[m_arrayUrls count]*1.0f);
    if (delegate && [delegate respondsToSelector:@selector(setProgress:)])
    {
        
        [delegate setProgress:progress];
    }
    
}


-(void)unZipNormalQuestionSuc:(DownloadHttpInfo*)object
{
    m_idownCount++;
    if (m_idownCount == [m_arrayUrls count])
    {
        if (delegate && [delegate respondsToSelector:@selector(downLoadZipSuc:)])
        {
            
            [delegate downLoadZipSuc:m_arrayUrls];
        }
        return;
        
    }
    
    if (m_idownCount < [m_arrayUrls count])
    {
        [self startDownloadUrl:[m_arrayUrls objectAtIndex:m_idownCount]];
    }else
    {
        DLOG(@"startDownLoadZip fail:%@ m_idownCount:%d",m_arrayUrls,m_idownCount);
    }
    
    
}
-(void)unZipNormalQuestionFail:(DownloadHttpInfo *)object
{
    DLOG(@"unZipNormalQuestionFail:%@",object);
    m_idownCount = 0;
    [self startDownloadUrl:[m_arrayUrls objectAtIndex:0]];
}



-(void)unZipRaceQuestionSuc:(DownloadHttpInfo*)object
{
    m_idownCount++;
    if (m_idownCount == [m_arrayUrls count])
    {
        if (delegate && [delegate respondsToSelector:@selector(downLoadZipSuc:)])
        {
            [delegate downLoadZipSuc:m_arrayUrls];
        }
        return;
    }
    
    
    if (m_idownCount < [m_arrayUrls count])
    {
        [self startDownloadUrl:[m_arrayUrls objectAtIndex:m_idownCount]];
    }else
    {
        DLOG(@"startDownLoadZip fail:%@ m_idownCount:%d",m_arrayUrls,m_idownCount);
    }
    
}
-(void)unZipRaceQuestionFail:(DownloadHttpInfo *)object
{
    
    DLOG(@"unZipRaceQuestionFail:%@",object);
}
@end
