//
//  JFPropButton.h
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JFPropModel.h"

//34*34 + //answer_prop_bg  35*10
@class JFPropButton;

//40*40
@protocol JFPropButtonDelegate <NSObject>

-(void)clickPropButton:(JFPropModel*)model button:(JFPropButton*)btnProp;

@end
@interface JFPropButton : UIButton
{
    UIImageView            *m_imageIcon;
    id<JFPropButtonDelegate> delegate;
}


@property(nonatomic,retain)JFPropModel  *propModel;
@property(nonatomic,assign)id<JFPropButtonDelegate> delegate;


-(void)updatePropBtn:(JFPropModel*)model;
-(void)setGoldIconGray:(BOOL)bIsGray;
- (id)initWithFrame:(CGRect)frame  withModel:(JFPropModel*)model;

@end
