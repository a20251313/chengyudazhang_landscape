//
//  JFAnswerRightView.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UtilitiesFunction.h"
#import "JFIdiomModel.h"
//#import "YouMiView.h"

#import "JFUnlockView.h"
#import "JFSQLManger.h"
@protocol JFAnswerRightViewDelegate <NSObject>

@optional

-(void)clickToshare:(id)sender;
-(void)clickToNextIdiom:(JFIdiomModel*)model addGoldNumber:(int)number;
-(void)clickMoreIdioms:(id)sender addGoldNumber:(int)number;
-(void)clickBackButtonInAnswerview:(id)sender;

@end

@interface JFAnswerRightView : UIView
{
    id<JFAnswerRightViewDelegate> delegate;
   // immobView       *m_bannerView;
}
@property(nonatomic,assign)id<JFAnswerRightViewDelegate>  delegate;
@property(nonatomic,retain)JFIdiomModel  *model;
@property(nonatomic)int addGoldNumber;


-(void)show;
-(id)initWithFrame:(CGRect)frame  withModel:(JFIdiomModel*)Tempmodel  gold:(int)rewardNumber progress:(CGFloat)fprogress islastidiom:(BOOL)islast;

@end
