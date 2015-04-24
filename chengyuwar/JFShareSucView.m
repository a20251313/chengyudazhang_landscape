//
//  JFShareSucView.m
//  chengyuwar
//
//  Created by ran on 13-12-25.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFShareSucView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFPlayAniManger.h"
#import "JFAudioPlayerManger.h"
#import "JFLocalPlayer.h"
#import "JFSQLManger.h"

@implementation JFShareSucView

- (id)initWithRewardCount:(int)rewardcount
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
    if (self)
    {

         m_irewardCount = rewardcount;
        [self defaultInit];
       
        // Initialization code
    }
    
    return self;
}






-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super dealloc];
}


-(void)defaultInit
{
    
    
    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-280)/2, (self.frame.size.height-228)/2, 280, 228)];
    bgView.image = [PublicClass getImageAccordName:@"alert_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    
    
    
    CGFloat   fwidth = 280-40;
    CGFloat   fheight = 228-70;
    
    UIImageView  *imageBg1 = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-fwidth)/2, (bgView.frame.size.height-fheight)/2+8, fwidth, fheight)];
    imageBg1.backgroundColor = BGCOLORFORFIRSTBG;
    imageBg1.userInteractionEnabled = YES;
    imageBg1.layer.masksToBounds = YES;
    imageBg1.layer.cornerRadius = 10;
    imageBg1.clipsToBounds = YES;
    [bgView addSubview:imageBg1];
    
    
    
    
    UIImageView *imagebg2 = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
    imagebg2.backgroundColor = BGCOLORFORSECONDBG;
    imagebg2.userInteractionEnabled = YES;
    imagebg2.layer.masksToBounds = YES;
    imagebg2.layer.cornerRadius = 10;
    [imageBg1 addSubview:imagebg2];
    
    
    
    
  

    
    //CGFloat     fxpoint = 0;
    CGFloat     fyPoint = 20;
    UILabel *labelShareSuc = [[UILabel alloc] initWithFrame:CGRectMake(10, fyPoint, imagebg2.frame.size.width-10, 21)];
    labelShareSuc.textAlignment = NSTextAlignmentCenter;
    [labelShareSuc setTextColor:[UIColor colorWithRed:0x59*1.0/255.0 green:0x37*1.0/255.0 blue:0x22*1.0/255.0 alpha:1]];
    [labelShareSuc setBackgroundColor:[UIColor clearColor]];
    [labelShareSuc setFont:TEXTFONTWITHSIZE(15)];
    [labelShareSuc setText:@"分享成功"];
    [imagebg2 addSubview:labelShareSuc];
    
    
    //check_gold_icon   27 15
    
    fyPoint += 21+25;
    UILabel    *labelreward = [[UILabel alloc] initWithFrame:CGRectMake(imagebg2.frame.size.width/2-50, fyPoint,50, 21)];
    [labelreward setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x13*1.0/255.0 alpha:1]];
    [labelreward setFont:TEXTFONTWITHSIZE(15)];
    [labelreward setText:@"奖励:"];
    [labelreward setBackgroundColor:[UIColor clearColor]];
    [labelreward setTextAlignment:NSTextAlignmentCenter];
    [imagebg2 addSubview:labelreward];
    
    
    UIImageView  *imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width)/2, fyPoint+3, 27, 15)];
    imageIcon.image = [PublicClass getImageAccordName:@"check_gold_icon.png"];
    [imagebg2 addSubview:imageIcon];
    
    
    UIImageView  *imagegoldNumber = [[UtilitiesFunction getImagewithNumber:m_irewardCount type:JFPicNumberTypeAnswerRightNumber] retain];
    [imagegoldNumber setFrame:CGRectMake(imageIcon.frame.origin.x+imageIcon.frame.size.width+10,fyPoint+3, imagegoldNumber.frame.size.width, imagegoldNumber.frame.size.height)];
    [imagebg2 addSubview:imagegoldNumber];
    
    
    
    UIButton    *btnGainward = [[UIButton alloc] initWithFrame:CGRectMake((imagebg2.frame.size.width-92)/2, imagebg2.frame.size.height-36, 92, 31)];
    [btnGainward setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnGainward setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnGainward setImage:[UtilitiesFunction getImageAccordTitle:@"领取奖励"] forState:UIControlStateNormal];
    [btnGainward addTarget:self action:@selector(clickGainWardButton:) forControlEvents:UIControlEventTouchUpInside];
    [imagebg2 addSubview:btnGainward];
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-78)/2, 0, 78, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"alert_title_notice.png"];
    [bgView addSubview:imageTitle];
    
    

    
    
    [imagegoldNumber release];
    [imageIcon release];
    [labelreward release];
    [labelShareSuc release];
    [btnGainward release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [imageTitle release];
}


-(void)addobserverForBarOrientationNotification
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInterface:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}
-(void)changeInterface:(NSNotification*)note
{
    
    int type = [[[note userInfo] valueForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];
    if (type == 4)
    {
        [self setTransform:CGAffineTransformMakeRotation(-M_PI_2*3)];
    }else if (type == 3)
    {
        [self setTransform:CGAffineTransformMakeRotation(M_PI_2*3)];
    }
    DLOG(@"note:%@  note userInfo:%@",note,[note userInfo]);
}

-(void)show
{
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    [self addobserverForBarOrientationNotification];
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    self.center = window.center;
    self.transform = CGAffineTransformMakeRotation(fValue);
    [window addSubview:self];
    
    
}




-(void)clickGainWardButton:(id)sender
{
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    int addgoldNumber = 50;
    
    [JFLocalPlayer addgoldNumberWithNoAudio:addgoldNumber];
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeGainGold];
    [JFPlayAniManger addGoldWithAni:addgoldNumber];
  
    
    [self removeFromSuperview];
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
