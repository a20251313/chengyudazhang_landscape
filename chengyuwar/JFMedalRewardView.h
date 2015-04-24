//
//  JFMedalRewardView.h
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMedalView.h"

@interface JFMedalRewardView : UIView
{
    UIImageView *_backgroundImageView;
    UILabel     *_contentLabel;
    UIView      *_overlayView;
}
@property(nonatomic,retain)JFMedalModel  *model;
@property(nonatomic)BOOL    bHasOther;
@property(nonatomic)JFMedalModelGetType getType;


+(void)showMedalViewwithType:(JFMedalModelGetType)getType;
- (void)show;
- (id)initWithModel:(JFMedalModel*)tempModel;

@end


