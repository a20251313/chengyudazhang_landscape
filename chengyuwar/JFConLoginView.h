//
//  JFConLoginView.h
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import <UIKit/UIKit.h>
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "UIUnderlinelineButton.h"
#import "JFRewardView.h"
#import "JFConLoginModel.h"
@protocol JFConLoginViewDelegate <NSObject>

-(void)sendGetReward:(id)sender;
@optional
-(void)GotoChareCenter:(id)sender;


@end

typedef enum
{
    JFUserVipTypeNone,
    JFUserVipTypeRedVIP,
    JFUserVipTypeBlueVIP,
    JFUserVipTypeGreenVIP
    
}JFUserVIPType;

@interface JFConLoginView : UIImageView
{
 
    id<JFConLoginViewDelegate> delegate;
    JFUserVIPType   m_iType;
    NSMutableArray  *m_arrayData;
    
    
    
    
    UIImageView    *m_bgView;
    UIImageView    *m_littleBgView;
    UIImageView    *m_topView;
    UILabel        *m_labelNotice;
    UIUnderlinelineButton  *m_btnUpgread;
    UIButton       *m_btnGetReward;
    
  
    
}

@property(nonatomic,assign)id<JFConLoginViewDelegate> delegate;
@property(nonatomic)JFUserVIPType  vipType;
@property(nonatomic)int  conLogInDays;
- (void)show;
-(void)loadWholeWithVip:(JFUserVIPType)TempvipType nextSignID:(int)TempnextSignID withArray:(NSMutableArray *)arrayInfo;
-(void)loadAfterGainReward;
-(int)getRewardNumber;
-(int)getConLoginDays;
@end
