//
//  JFPlayerChangeView.m
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFPlayerChangeView.h"
#import "PublicClass.h"

#define FACEVIEWBGTAG     1000
#define NICKNAMEBGVIEWTAG  1001
#define LEVELVIEWBGTAG     2341
@implementation JFPlayerChangeView



@synthesize answerStatus = m_istatus;
@synthesize locationType = m_ilocationType;
@synthesize player;


//110*92
- (id)initWithFrame:(CGRect)frame Player:(JFLocalPlayer*)Tempplayer locationType:(JFPlayerChangeViewNameLocationType)type
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.player = Tempplayer;
        m_ilocationType = type;
        [self updateViewAccordPlayInfo:Tempplayer];
        // Initialization code
    }
    return self;
}

-(void)setAnswerStatus:(JFPlayerChangeViewAnswerStatus)answerStatus
{
    m_istatus = answerStatus;
    
    
    UIView  *viewbg = [self viewWithTag:FACEVIEWBGTAG];
    
    UIImageView  *hightView = (UIImageView*)[viewbg viewWithTag:1111];
    [hightView removeFromSuperview];
    switch (m_istatus)
    {
        case JFPlayerChangeViewAnswerStatusNormal:
            if (m_ilocationType == JFPlayerChangeViewNameLocationTypeLeft)
            {
                m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.leftFaceImageName];
            }else
            {
                m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.rightFaceImageName];
            }
            break;
        case JFPlayerChangeViewAnswerStatusAnswerfail:
             m_imageFaceView.image = [PublicClass getImageAccordName:@"changefail_faceicon.png"];
            break;
        case JFPlayerChangeViewAnswerStatusAnswering:
            if (m_ilocationType == JFPlayerChangeViewNameLocationTypeLeft)
            {
                m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.leftFaceImageName];
            }else
            {
                m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.rightFaceImageName];
            }
            hightView = [[UIImageView alloc] initWithFrame:viewbg.bounds];
            hightView.image = [PublicClass getImageAccordName:@"change_flash_frame.png"];
            hightView.tag = 1111;
            [viewbg addSubview:hightView];
            [hightView release];
            
            break;
            
        default:
            break;
    }
    
    if (!self.player.roleModel.rightFaceImageName)
    {
        m_imageFaceView.image = nil;
    }
}


-(void)setLocationType:(JFPlayerChangeViewNameLocationType)locationType
{
    m_ilocationType = locationType;
    
    
    UIView  *viewnicknamebg = [self viewWithTag:NICKNAMEBGVIEWTAG];
    if (!viewnicknamebg)
    {
        viewnicknamebg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 71, 22)];
       // viewnicknamebg.layer.contents = (id)[PublicClass getImageAccordName:@"change_rolenick_bg.png"].CGImage;
        [self addSubview:viewnicknamebg];
        viewnicknamebg.tag = NICKNAMEBGVIEWTAG;
        [viewnicknamebg release];
    }
    
    
    UIView  *viewfacebg = [self viewWithTag:FACEVIEWBGTAG];
    if (!viewfacebg)
    {
        viewfacebg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 71)];
        viewfacebg.layer.contents = (id)[PublicClass getImageAccordName:@"change_face_bg2.png"].CGImage;
        [self addSubview:viewfacebg];
        
        viewfacebg.tag = FACEVIEWBGTAG;
        UIImageView   *imageViewBg2 = [[UIImageView alloc] initWithFrame:viewfacebg.bounds];
        imageViewBg2.image = [PublicClass getImageAccordName:@"change_face_bg1.png"];
        [viewfacebg addSubview:imageViewBg2];
        [imageViewBg2 release];
        [viewfacebg release];
    }
    
    UIImageView   *viewlevelbg = (UIImageView*)[self viewWithTag:LEVELVIEWBGTAG];
    
    
    if (!viewlevelbg)
    {
        viewlevelbg =   [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 46)];
        viewlevelbg.image = [PublicClass getImageAccordName:@"racehall_level_bg.png"];
        viewlevelbg.userInteractionEnabled = YES;
        [self addSubview:viewlevelbg];
        viewlevelbg.tag = LEVELVIEWBGTAG;
        [viewlevelbg release];
    }
    
    
    
    if (m_ilocationType == JFPlayerChangeViewNameLocationTypeLeft)
    {
        
        
        [viewlevelbg setFrame:CGRectMake(0,0, 30, 46)];
        [viewfacebg setFrame:CGRectMake(40,0, 70, 71)];
        [viewnicknamebg setFrame:CGRectMake(viewfacebg.frame.origin.x,viewfacebg.frame.origin.y+viewfacebg.frame.size.height-3, 70, 22)];
        
    }else
    {
        [viewlevelbg setFrame:CGRectMake(80, 0, 30, 46)];
        [viewfacebg setFrame:CGRectMake(0, 0, 70, 71)];
        [viewnicknamebg setFrame:CGRectMake(viewfacebg.frame.origin.x,viewfacebg.frame.origin.y+viewfacebg.frame.size.height-3, 70, 22)];
    }
    
    if (!m_labelLevel)
    {
        m_labelLevel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 24, 46)];
        [m_labelLevel setNumberOfLines:2];
        [m_labelLevel setBackgroundColor:[UIColor clearColor]];
        [m_labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];
        [m_labelLevel setTextColor:[UIColor colorWithRed:0x25*1.0/255.0 green:0x00*1.0/255.0 blue:0x00*1.0/255.0 alpha:1.0]];
        [m_labelLevel setFont:TEXTFONTWITHSIZE(17)];
        [viewlevelbg addSubview:m_labelLevel];
    }
    
     [m_labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];

    

}


-(void)updateViewAccordPlayInfo:(JFLocalPlayer*)tempPlayer
{
    self.player = tempPlayer;
    [self setLocationType:m_ilocationType];
    
    UIView  *viewnicknamebg = [self viewWithTag:NICKNAMEBGVIEWTAG];
    if (!m_labelName)
    {
        m_labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 1, viewnicknamebg.frame.size.width, viewnicknamebg.frame.size.height-2)];
        [m_labelName setText:@"abcd我是你叶"];
        [m_labelName setTextColor:[UIColor colorWithRed:0x59*1.0/255.0 green:0x37*1.0/255.0 blue:0x22*1.0/255.0 alpha:1]];
        [m_labelName setFont:TEXTFONTWITHSIZE(13)];
        [m_labelName setNumberOfLines:1];
        [m_labelName setBackgroundColor:[UIColor clearColor]];
        [m_labelName setTextAlignment:NSTextAlignmentCenter];
        [viewnicknamebg addSubview:m_labelName];
    }
    
    
    NSString    *strtext = @"";
    NSString    *strInfo = self.player.nickName;
    
    if ([strInfo length] > 4)
    {
        
        strtext = [strInfo substringWithRange:NSMakeRange(0, 4)];
        /*
        for (int i = 0; i < 4; i++)
        {
            strtext = [strtext stringByAppendingString:[NSString stringWithFormat:@"%@\n",[strInfo substringWithRange:NSMakeRange(i, 1)]]];
        }*/
        
    }else
    {
        strtext = strInfo;
    }
    [m_labelName setText:strtext];
    
    
     UIView  *viewfacebg = [self viewWithTag:FACEVIEWBGTAG];
    
    if (!m_imageFaceView)
    {
        m_imageFaceView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 71)];
        [viewfacebg addSubview:m_imageFaceView];
       
    }
    if (m_ilocationType == JFPlayerChangeViewNameLocationTypeLeft)
    {
        m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.leftFaceImageName];
    }else
    {
        m_imageFaceView.image = [PublicClass getImageAccordName:self.player.roleModel.rightFaceImageName];
    }
    
     [m_labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];
}

-(void)dealloc
{
    self.player = nil;
    [m_imageFaceView release];
    m_imageFaceView = nil;
    [m_labelName release];
    m_labelName = nil;
    [m_labelLevel release];
    m_labelLevel = nil;
    [super dealloc];
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
