//
//  JFAnswerSucView.h
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFLocalPlayer.h"
#import "JFAlertView.h"
#import "JFChargeView.h"
#import "JFAnswerResultDelegate.h"

@interface JFAnswerSucView : UIView<JFAlertViewDeledate>
{

    id<JFAnswerResultDelegate>  delegate;
}


@property(nonatomic,retain)JFLocalPlayer  *player;
@property(nonatomic,assign)id<JFAnswerResultDelegate>  delegate;


- (id)initwithPlayer:(JFLocalPlayer*)tempPlayer  goldValue:(int)goldNumber  answerNumber:(int)answerNumber;
-(void)show;

-(void)addHistoryView;
@end
