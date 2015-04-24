//
//  ;
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFLocalPlayer.h"
#import "JFAlertView.h"
#import "JFAnswerResultDelegate.h"
#import "JFChargeView.h"

@interface JFAnswerFailView : UIView<JFAlertViewDeledate>
{
    id<JFAnswerResultDelegate>  delegate;
}


@property(nonatomic,retain)JFLocalPlayer  *player;
@property(nonatomic,assign)id<JFAnswerResultDelegate>  delegate;


////420 * 252
- (id)initwithPlayer:(JFLocalPlayer*)tempPlayer  goldValue:(int)goldNumber;
-(void)show;
@end
