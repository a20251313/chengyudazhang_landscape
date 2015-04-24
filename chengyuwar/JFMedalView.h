//
//  JFMedalView.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFMedalModel.h"

@protocol JFMedalViewDelegate <NSObject>

-(void)clickMedalMode:(JFMedalModel*)model;

@end


@interface JFMedalView : UIButton
{
    UIImageView         *m_bgimageView;
    UIImageView         *m_imageIcon;
    UIImageView         *m_imageName;
    UIImageView         *m_imageNameBg;
    id<JFMedalViewDelegate>  delegate;
}

@property(nonatomic,assign)id<JFMedalViewDelegate> delegate;
@property(nonatomic,retain)JFMedalModel  *model;


- (id)initWithFrame:(CGRect)frame  withModel:(JFMedalModel*)model;
-(void)updateMealdView:(JFMedalModel*)tempmodel;
-(void)setLabelInfoHidden:(BOOL)bHide;

@end
