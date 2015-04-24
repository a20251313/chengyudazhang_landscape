//
//  JFMedalView.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFMedalView.h"
#import "PublicClass.h"
//50*50
@implementation JFMedalView
@synthesize delegate;
@synthesize model;
- (id)initWithFrame:(CGRect)frame  withModel:(JFMedalModel*)tempmodel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.model = tempmodel;
        self.exclusiveTouch = YES;
        [self addTarget:self action:@selector(clickSelfView:) forControlEvents:UIControlEventTouchUpInside];
        if (!m_bgimageView)
        {
            m_bgimageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-44)/2, 0, 44, 44)];
            m_bgimageView.userInteractionEnabled = NO;
            if (self.model.isGained)
            {
                m_bgimageView.image = [PublicClass getImageAccordName:@"medal_bottom_default.png"];
            }else
            {
                m_bgimageView.image = [PublicClass getImageAccordName:@"medal_bottom_gray.png"];
            }
            [self addSubview:m_bgimageView];
            
        }
        
        if (!m_imageIcon)
        {
            
            m_imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake((m_bgimageView.frame.size.width-31)/2, (m_bgimageView.frame.size.height-31)/2, 31, 31)];
            if (model.isGained)
            {
                m_imageIcon.image = [PublicClass getImageAccordName:model.medalImageName];
            }else
            {
                m_imageIcon.image = [PublicClass getImageAccordName:model.medalGrayImageName];
            }
            [m_bgimageView addSubview:m_imageIcon];
            m_imageIcon.userInteractionEnabled = NO;
        }
        
        
        if (!m_imageNameBg)
        {
            m_imageNameBg = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-40)/2, m_bgimageView.frame.size.height-5, 40, 12)];
            if (model.isGained)
            {
                m_imageNameBg.image = [PublicClass getImageAccordName:@"medal_word_bg.png"];
            }else
            {
                m_imageNameBg.image = [PublicClass getImageAccordName:@"medal_word_bggray.png"];
 
            }
            [self addSubview:m_imageNameBg];
        }
        
        if (!m_imageName)
        {
            m_imageName = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 12)];
            if (model.isGained)
            {
                m_imageName.image = [PublicClass getImageAccordName:model.medalNameImageName];
            }else
            {
                m_imageName.image = [PublicClass getImageAccordName:model.medalGrayNameImageName];
            }
            [m_imageNameBg addSubview:m_imageName];
        }
        
        // Initialization code
    }
    return self;
}

-(void)updateMealdView:(JFMedalModel*)tempmodel
{
    self.model = tempmodel;
    if (self.model.isGained)
    {
        m_bgimageView.image = [PublicClass getImageAccordName:@"medal_bottom_default.png"];
    }else
    {
        m_bgimageView.image = [PublicClass getImageAccordName:@"medal_bottom_gray.png"];
    }
    
    
    if (model.isGained)
    {
        m_imageIcon.image = [PublicClass getImageAccordName:model.medalImageName];
    }else
    {
        m_imageIcon.image = [PublicClass getImageAccordName:model.medalGrayImageName];
    }
    
    if (model.isGained)
    {
        m_imageNameBg.image = [PublicClass getImageAccordName:@"medal_word_bg.png"];
    }else
    {
        m_imageNameBg.image = [PublicClass getImageAccordName:@"medal_word_bggray.png"];
        
    }
    
    if (model.isGained)
    {
        m_imageName.image = [PublicClass getImageAccordName:model.medalNameImageName];
    }else
    {
        m_imageName.image = [PublicClass getImageAccordName:model.medalGrayNameImageName];
    }
}

-(void)setLabelInfoHidden:(BOOL)bHide
{
    [m_imageName setHidden:bHide];
    [m_imageNameBg setHidden:bHide];
}
-(void)dealloc
{
    [m_imageName release];
    m_imageName = nil;
    [m_imageNameBg release];
    m_imageNameBg = nil;
    [m_imageIcon release];
    m_imageIcon = nil;
    [m_bgimageView release];
    m_bgimageView = nil;
    self.model = nil;
    [super dealloc];
}

-(void)clickSelfView:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(clickMedalMode:)])
    {
        [delegate clickMedalMode:self.model];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
