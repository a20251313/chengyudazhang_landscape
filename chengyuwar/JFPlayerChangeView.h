//
//  JFPlayerChangeView.h
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFLocalPlayer.h"

typedef enum
{
    JFPlayerChangeViewNameLocationTypeLeft,
    JFPlayerChangeViewNameLocationTypeRight
    
}JFPlayerChangeViewNameLocationType;

typedef enum
{
    JFPlayerChangeViewAnswerStatusNormal,
    JFPlayerChangeViewAnswerStatusAnswering,
    JFPlayerChangeViewAnswerStatusAnswerfail
    
}JFPlayerChangeViewAnswerStatus;

@interface JFPlayerChangeView : UIView
{
    JFPlayerChangeViewAnswerStatus      m_istatus;
    JFPlayerChangeViewNameLocationType  m_ilocationType;
    UIImageView                         *m_imageFaceView;
    UILabel                             *m_labelName;
    UILabel                             *m_labelLevel;
    
}
@property(nonatomic)JFPlayerChangeViewNameLocationType locationType;
@property(nonatomic)JFPlayerChangeViewAnswerStatus     answerStatus;


- (id)initWithFrame:(CGRect)frame Player:(JFLocalPlayer*)Tempplayer locationType:(JFPlayerChangeViewNameLocationType)type;
@property(nonatomic,retain)JFLocalPlayer  *player;
-(void)updateViewAccordPlayInfo:(JFLocalPlayer*)tempPlayer;

@end
