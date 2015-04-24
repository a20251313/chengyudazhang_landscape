//
//  JFCheckPointViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFSinglecheckView.h"
#import "JFCheckContentView.h"
#import "JFSQLManger.h"
#import "JFDownZipManger.h"
#import "DownloadHttpFile.h"
#import "JFPhaseXmlData.h"
//#import "YouMiWallSpotView.h"
#import "ZVolumeSlide.h"

@interface JFCheckPointViewController : UIViewController<JFSinglecheckViewDelegate,JFCheckContentViewDelegate,JFDownZipMangerDelegate,DownloadHttpFileDelegate>
{
    NSMutableArray              *m_arrayData;
    
    JFCheckContentView          *m_contentView;
    ZVolumeSlide                *m_sliderProgress;
    UILabel                     *m_labelBeatScore;

    JFDownZipManger             *m_downZip;
    BOOL                        m_bIsLoading;
    BOOL                        m_bIsStartDown;
}

@property(nonatomic)BOOL    showMaxPage;

-(void)setLabelBeatProgress:(CGFloat)fprogress;

@end
