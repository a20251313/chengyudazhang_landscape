//
//  JFMedalNoticeView.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMedalView.h"

@interface JFMedalNoticeView : UIView
{
    
    
    
    UIImageView *_backgroundImageView;
    UILabel     *_contentLabel;
    UIView      *_overlayView;
}
@property(nonatomic,retain)JFMedalModel  *model;

- (void)show;
- (id)initWithModel:(JFMedalModel*)tempModel;

@end
