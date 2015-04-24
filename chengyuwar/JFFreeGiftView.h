//
//  JFConLoginView.h
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import <UIKit/UIKit.h>
@protocol JFFreeGiftViewDelegate <NSObject>

-(void)sendGetRewardGold:(id)sender;
@end



@interface JFFreeGiftView : UIImageView
{
    
    id<JFFreeGiftViewDelegate> delegate;

    UIImageView    *m_bgView;
    UIImageView    *m_littleBgView;
    UIImageView    *m_topView;
    UILabel        *m_labelNotice;
    UIButton       *m_btnGetReward;
    
}

@property(nonatomic,assign)id<JFFreeGiftViewDelegate> delegate;
- (void)show;

@end
