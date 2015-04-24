//
//  JFMedalViewController.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMedalView.h"
#import "JFMedalNoticeView.h"

@interface JFMedalViewController : UIViewController<JFMedalViewDelegate>
{
    NSMutableArray  *m_arrayNormal;
    NSMutableArray  *m_arrayRace;
    UIScrollView    *m_scrollViewNormal;
    UIScrollView    *m_scrollViewRace;
    UILabel         *m_labelInfo;
    int             m_ihasGainMedals;
}

@end
