//
//  JFRewardView.h
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import <UIKit/UIKit.h>
#import "JFConLoginModel.h"
#import <QuartzCore/QuartzCore.h>
#import "PublicClass.h"


//58  * 76
@interface JFRewardView : UIView
{
    
    JFRewardType   m_iType;
}

@property(nonatomic)int day;
@property(nonatomic)int scores;
@property(nonatomic)JFRewardType  rewardType;


- (id)initWithFrame:(CGRect)frame  withType:(JFRewardType)type withDay:(int)tempday withScroes:(int)temscores;
- (void)loadWithRewardType:(JFRewardType)type;
@end
