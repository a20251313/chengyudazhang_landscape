//
//  JFConLoginView.h
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import <UIKit/UIKit.h>
#import "JFChargeNet.h"
#import "JFLocalPlayer.h"
#import "JFSQLManger.h"
#import "JFAlertView.h"
#import "MBProgressHUD.h"
#import "JFChargeView.h"



@interface JFUnlockView : UIImageView<JFChargeNetDelegate,JFAlertViewDeledate>
{
    

    UIImageView    *m_bgView;
    UIImageView    *m_littleBgView;
    UIImageView    *m_topView;
    UILabel        *m_labelNotice;
    UIButton       *m_btnGetReward;
    

    JFChargeNet    *m_chargeNet;
  
}


- (id)initWithFrame:(CGRect)frame withLevel:(int)lelel;
@property(nonatomic)int         level;
- (void)show;

@end
