//
//  JFAnswerRightView.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAnswerRightView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFLocalPlayer.h"
#import "JFYouMIManger.h"
#import "JFAudioPlayerManger.h"
#import "JFSendAdInfo.h"
#import "JFAppSet.h"

#if DEBUG
#define AUTOCLICKNEXT   0
#endif

@implementation JFAnswerRightView
@synthesize delegate;
@synthesize model;
@synthesize addGoldNumber;
- (id)initWithFrame:(CGRect)frame  withModel:(JFIdiomModel*)Tempmodel  gold:(int)rewardNumber progress:(CGFloat)fprogress islastidiom:(BOOL)islast
{
    
    frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        self.model = Tempmodel;
        
        self.addGoldNumber = rewardNumber;
        if (iPhone5)
        {
            self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
            //main_bg_withnothing
        }else
        {
            self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
        }
        
     
      
        
        UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
        [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
        [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
        [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnback];
        [btnback release];
        
        
        
        
        
        
        UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-472)/2, 25, 472, 291)];
        bgView.image = [PublicClass getImageAccordName:@"check_scrollerbg.png"];
        bgView.userInteractionEnabled = YES;
        [self addSubview:bgView];
        
        
        
        UIImageView  *imageScoreBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-155)/2,-5, 155, 25)];
        [imageScoreBg setImage:[PublicClass getImageAccordName:@"check_bottomword_bg.png"]];
        [bgView addSubview:imageScoreBg];
        
       
        UILabel    *labelBeatScore = [[UILabel alloc] initWithFrame:CGRectMake(0, (imageScoreBg.frame.size.height-21)/2, imageScoreBg.frame.size.width, 21)];
        [labelBeatScore setTextColor:[UIColor colorWithRed:0x69*1.0/255.0 green:0x46*1.0/255.0 blue:0x2F*1.0/255.0 alpha:1]];
        [labelBeatScore setFont:TEXTFONTWITHSIZE(11)];
        [labelBeatScore setText:[NSString stringWithFormat:@"您已打败%0.2f%%的玩家",fprogress*100]];
        [labelBeatScore setBackgroundColor:[UIColor clearColor]];
        [labelBeatScore setTextAlignment:NSTextAlignmentCenter];
        [imageScoreBg addSubview:labelBeatScore];
        
        CGFloat    fysep = 3;
        CGFloat   fypoint =  28;
        UILabel    *labelAnswerright = [[UILabel alloc] initWithFrame:CGRectMake(0, fypoint, bgView.frame.size.width, 21)];
        [labelAnswerright setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelAnswerright setFont:TEXTFONTWITHSIZE(15)];
        [labelAnswerright setText:@"答案正确"];
        [labelAnswerright setBackgroundColor:[UIColor clearColor]];
        [labelAnswerright setTextAlignment:NSTextAlignmentCenter];
        [bgView addSubview:labelAnswerright];
        
        
        
        fypoint +=  21+fysep;
        UILabel    *labelAnswer = [[UILabel alloc] initWithFrame:CGRectMake(0, fypoint, bgView.frame.size.width, 24)];
        [labelAnswer setTextColor:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x99*1.0/255.0 blue:0x33*1.0/255.0 alpha:1]];
        [labelAnswer setFont:TEXTHEITIWITHSIZE(21)];
        [labelAnswer setText:self.model.idiomAnswer];
        [labelAnswer setBackgroundColor:[UIColor clearColor]];
        [labelAnswer setTextAlignment:NSTextAlignmentCenter];
        [bgView addSubview:labelAnswer];
        
        
        fypoint +=  24+fysep+20;
        
        
        
        UILabel *labelExplain = [[UILabel alloc] initWithFrame:CGRectMake(40, fypoint-10, 50, 16)];
        [labelExplain setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelExplain setFont:TEXTHEITIWITHSIZE(15)];
        [labelExplain setText:@"解释:"];
        [labelExplain setBackgroundColor:[UIColor clearColor]];
        [bgView addSubview:labelExplain];
        
        
        CGFloat fsingHeight =  [UtilitiesFunction calculateTextHeight:bgView.frame.size.width-90-40 Content:@"我" font:TEXTHEITIWITHSIZE(15)];
        
         CGFloat fheight = [UtilitiesFunction calculateTextHeight:bgView.frame.size.width-90-40 Content:self.model.idiomExplain font:TEXTHEITIWITHSIZE(15)];
         int    count = fheight/fsingHeight;
        
        UILabel    *labelDesprition = [[UILabel alloc] initWithFrame:CGRectMake(40+50, fypoint-10, bgView.frame.size.width-90-40, 17*count)];
        [labelDesprition setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelDesprition setFont:TEXTHEITIWITHSIZE(15)];
        [labelDesprition setBackgroundColor:[UIColor clearColor]];
        [labelDesprition setText:self.model.idiomExplain];
        [labelDesprition setLineBreakMode:NSLineBreakByWordWrapping];
        [bgView addSubview:labelDesprition];
        
       
        [labelDesprition setNumberOfLines:8];
        
        fypoint += fsingHeight*(count < 4?4:count);
        fheight = [UtilitiesFunction calculateTextHeight:bgView.frame.size.width-90-40 Content:self.model.idiomFrom font:TEXTHEITIWITHSIZE(15)];
        count = fheight/fsingHeight;
        
        UILabel *labelFrom = [[UILabel alloc] initWithFrame:CGRectMake(40, fypoint-10, 50, 17)];
        [labelFrom setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelFrom setFont:TEXTHEITIWITHSIZE(15)];
        [labelFrom setText:@"出处:"];
        [labelFrom setBackgroundColor:[UIColor clearColor]];
        [bgView addSubview:labelFrom];
        
        UILabel    *labelFromDes = [[UILabel alloc] initWithFrame:CGRectMake(40+50, fypoint-10, bgView.frame.size.width-90-40, 17*count)];
        [labelFromDes setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelFromDes setFont:TEXTHEITIWITHSIZE(15)];
        [labelFromDes setBackgroundColor:[UIColor clearColor]];
        [labelFromDes setText:self.model.idiomFrom];
        [labelFromDes setLineBreakMode:NSLineBreakByWordWrapping];
        [labelFromDes setNumberOfLines:8];
        [bgView addSubview:labelFromDes];
    
      
        fypoint =  bgView.frame.size.height-70;
        
        UILabel    *labelreward = [[UILabel alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2-50, fypoint,50, 21)];
        [labelreward setTextColor:[UIColor colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1]];
        [labelreward setFont:TEXTFONTWITHSIZE(16)];
        [labelreward setText:@"奖励:"];
        [labelreward setBackgroundColor:[UIColor clearColor]];
        [labelreward setTextAlignment:NSTextAlignmentCenter];
        [bgView addSubview:labelreward];
        
        
        
        UIImageView  *imagegoldIcon = [[UIImageView alloc] initWithFrame:CGRectMake(bgView.frame.size.width/2,fypoint+3, 27, 15)];
        [bgView addSubview:imagegoldIcon];
        imagegoldIcon.image  = [PublicClass getImageAccordName:@"check_gold_icon.png"];
        
        
        UIImageView  *imagegoldNumber = [UtilitiesFunction getImagewithNumber:rewardNumber type:JFPicNumberTypeAnswerRightNumber];
        [imagegoldNumber setFrame:CGRectMake(bgView.frame.size.width/2+27+10,fypoint+3, imagegoldNumber.frame.size.width, imagegoldNumber.frame.size.height)];
        [bgView addSubview:imagegoldNumber];

        
        
        
        UIButton   *shareBtn = [[UIButton alloc] initWithFrame:CGRectMake(140, bgView.frame.size.height-45, 92, 31)];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [shareBtn setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
        [shareBtn setImage:[PublicClass getImageAccordName:@"answer_right_share.png"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(clickShareButton:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:shareBtn];
        
        
        UIButton   *btnNext = [[UIButton alloc] initWithFrame:CGRectMake(140+92+20, bgView.frame.size.height-45, 92, 31)];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
        [btnNext setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
        if (islast)
        {
            [btnNext setImage:[PublicClass getImageAccordName:@"answer_right_more.png"] forState:UIControlStateNormal];
            [btnNext addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
            
        }else
        {
            [btnNext setImage:[PublicClass getImageAccordName:@"answer_right_next.png"] forState:UIControlStateNormal];
            [btnNext addTarget:self action:@selector(clickNextButton:) forControlEvents:UIControlEventTouchUpInside];
            btnNext.tag = 1423;
        }
        
        [bgView addSubview:btnNext];
        [btnNext release];
        [shareBtn release];
        [imagegoldIcon release];
        [imageScoreBg release];
        [labelAnswer release];
        [labelAnswerright release];
        [labelBeatScore release];
        [labelreward release];
        [bgView release];
        [labelDesprition release];
        [labelExplain release];
        [labelFrom release];
        [labelFromDes release];

        
       
        
        [self addBannerView];

        // Initialization code
    }
    return self;
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

-(void)clickShareButton:(id)sender
{
    
    if (delegate  && [delegate respondsToSelector:@selector(clickToshare:)])
    {
        [delegate clickToshare:sender];
    }
    DLOG(@"clickShareButton:%@",sender);
    
    //[self removeFromSuperview];
}


-(void)clickBackbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(clickBackButtonInAnswerview:)])
    {
        [delegate clickBackButtonInAnswerview:sender];
    }
    [self removeFromSuperview];
    
}
-(void)clickMoreButton:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate  && [delegate respondsToSelector:@selector(clickMoreIdioms:addGoldNumber:)])
    {
        [delegate clickMoreIdioms:sender addGoldNumber:self.addGoldNumber];
    }
    DLOG(@"clickMoreButton:%@",sender);
    
    [self removeFromSuperview];
}
-(void)clickNextButton:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    
    
    if ([self.model.idiomlevelString intValue]%120 == 0)
    {
        if (![JFSQLManger levelIsPurchased:[self.model.idiomlevelString intValue]])
        {
            JFUnlockView    *unview = [[JFUnlockView alloc] initWithFrame:CGRectZero withLevel:[self.model.idiomlevelString intValue]];
            [unview show];
            [unview release];
            return;
        }
    }
    
    if (delegate && [delegate respondsToSelector:@selector(clickToNextIdiom:addGoldNumber:)])
    {
        [delegate clickToNextIdiom:self.model addGoldNumber:addGoldNumber];
    }
    DLOG(@"clickNextButton:%@",sender);
    
    [self removeFromSuperview];
}

-(void)checkAutoClickNext
{
#if AUTOCLICKNEXT
    UIButton    *btnNext = (UIButton*)[self viewWithTag:1423];
    if (btnNext)
    {
        [self performSelector:@selector(clickNextButton:) withObject:nil afterDelay:0.2];
    }
#endif
}
-(void)show
{
    //[self addobserverForBarOrientationNotification];
    //UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    //CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    //self.transform = CGAffineTransformMakeRotation(fValue);
    self.center = window.center;
    [window addSubview:self];
    [self checkAutoClickNext];
}
-(void)addobserverForBarOrientationNotification
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInterface:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    self.model = nil;
    self.delegate = nil;
    DLOG(@"JFAnswerRightView dealloc");
    [super dealloc];
}



-(void)addBannerView
{
    
    if ([[JFLocalPlayer shareInstance] isPayedUser])
    {
        return;
    }

   //[JFSendAdInfo sendShowAD:[[JFLocalPlayer shareInstance] userID]];
   
}




@end
