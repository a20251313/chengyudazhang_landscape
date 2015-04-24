//
//  JFChangeView.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFRoleModel.h"
@interface JFChangeView : UIView
{
    UIImageView         *m_leftAniView;
    UIImageView         *m_rightAniView;
}
@property(nonatomic)JFRoleModelType roleType;

- (id)initWithRoleType:(JFRoleModelType)type;
-(void)show;
-(void)setRightRoleImage:(JFRoleModelType)type;
@end
