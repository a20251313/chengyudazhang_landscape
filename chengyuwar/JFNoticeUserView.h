//
//  JFNoticeUserView.h
//  chengyuwar
//
//  Created by ran on 13-12-18.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JFNoticeUserView : UIView
{
    BOOL        m_bIsWillRemove;
    UIImageView *_backgroundImageView;
    UILabel     *_contentLabel;
    
    UIButton    *_backButton;

    
    UIView      *_overlayView;
}
@property(nonatomic,copy)NSString  *message;


-(id)initWithmessage:(NSString *)strMsg;
- (void)show;
@end
