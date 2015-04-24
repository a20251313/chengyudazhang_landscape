//
//  JFAnswerSucView.m
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAnswerSucView.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"
#import "JFShareManger.h"
#import "UIImge-GetSubImage.h"

//420 * 252
@implementation JFAnswerSucView
@synthesize player;
@synthesize delegate;

- (id)initwithPlayer:(JFLocalPlayer*)tempPlayer  goldValue:(int)goldNumber  answerNumber:(int)answerNumber
{
     CGRect   frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.player = tempPlayer;
        
        
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
        
        
        //571*542
        CGFloat     fXPoint = (frame.size.width-285)/2;
        CGFloat     fYpoint = 0;
        [self addViewAccordImageName:@"racewin_flash.png" frame:CGRectMake(fXPoint, fYpoint, 285, 271) superView:self tag:111];
        [self addViewAccordImageName:@"main_bg_clouds.png" frame:CGRectMake((frame.size.width-478)/2, frame.size.height-100, 478, 60) superView:self tag:0];
        
        
        
        
        int conWinNumber = 0;
        BOOL bIsTotalMax = NO;
        BOOL bIsWeekMax = NO;
        
        if (self.player.currentMaxWinCount >= self.player.maxConWinNumber && self.player.currentMaxWinCount != 0)
        {
            conWinNumber = self.player.currentMaxWinCount;
            bIsTotalMax = YES;
        }
        
        if (self.player.weekConWinCount >= self.player.weekMaxConWinCount && self.player.weekConWinCount != 0)
        {
            conWinNumber = tempPlayer.weekConWinCount;
            bIsWeekMax = YES;
        }
        
       
        
        DLOG(@"conWinNumber:%d tempPlayer.currentMaxWinCount:%d tempPlayer.weekConWinCount:%d",conWinNumber,self.player.currentMaxWinCount,self.player.weekConWinCount);
        if (bIsTotalMax || bIsWeekMax)
        {
            if (bIsTotalMax)
           {
               [self addViewAccordImageName:@"racewin_historymax.png" frame:CGRectMake(frame.size.width-71-30, 10, 71, 76) superView:self tag:0];
               
               conWinNumber = self.player.maxConWinNumber;
           }else if (bIsWeekMax)
           {
               [self addViewAccordImageName:@"racewin_weekmax.png" frame:CGRectMake(frame.size.width-71-30, 10, 71, 76) superView:self tag:0];
               conWinNumber = self.player.weekMaxConWinCount;
           }
            
            
            DLOG(@"bIsTotalMax:%d bIsWeekMax:%d",bIsTotalMax,bIsWeekMax);
        }else
        {
            DLOG(@"not max");
            conWinNumber = tempPlayer.currentMaxWinCount > 0?tempPlayer.currentMaxWinCount:1;
        }
        
        UIView  *view = [self viewWithTag:111];
        
        UIImageView *imageView = [UtilitiesFunction getImagewithNumber:conWinNumber type:JFPicNumberTypeAnswerconwinNumber];
        
        CGFloat ftempWidth = imageView.frame.size.width+135;
        
        [imageView setFrame:CGRectMake((view.frame.size.width-ftempWidth)/2, 60, imageView.frame.size.width, imageView.frame.size.height)];
        [view addSubview:imageView];
        [self addViewAccordImageName:@"racewin_lianshengword.png" frame:CGRectMake((view.frame.size.width-ftempWidth)/2+imageView.frame.size.width, 60, 135, 70) superView:view tag:0];
        
       
        fXPoint = (frame.size.width-100)/2;
        fYpoint += 155;
        [self addlabelWithFrame:CGRectMake(fXPoint, fYpoint, 60, 21) text:@"奖励:" color: [UIColor colorWithRed:0xff*1.0/255.0 green:0x64*1.0/255.0 blue:0 alpha:1] font:TEXTHEITIWITHSIZE(20) superview:self tag:0];
        [self addViewAccordImageName:@"change_gold_icon.png" frame:CGRectMake(fXPoint+60, fYpoint+5, 15, 8) superView:self tag:0];
        [self addlabelWithFrame:CGRectMake(fXPoint+60+20, fYpoint-3, 100, 21) text:@"80" color:[UIColor colorWithRed:0xd7*1.0/255.0 green:0x34*1.0/255.0 blue:0x13*1.0/255.0 alpha:1] font:TEXTFONTWITHSIZE(20) superview:self tag:119];
        UILabel *label = (UILabel*)[self viewWithTag:119];
        [label setShadowColor:[UIColor whiteColor]];
        [label setShadowOffset:CGSizeMake(1, 1)];
        
        
        fYpoint += 20+10;
        [self addlabelWithFrame:CGRectMake(fXPoint, fYpoint, 60, 21) text:@"答题:" color: [UIColor colorWithRed:0x86*1.0/255.0 green:0x57*1.0/255.0 blue:0x2B*1.0/255.0 alpha:1] font:TEXTHEITIWITHSIZE(20) superview:self tag:0];
        [self addlabelWithFrame:CGRectMake(fXPoint+60, fYpoint-3, 100, 21) text:[NSString stringWithFormat:@"%d题",answerNumber] color:[UIColor colorWithRed:0x59*1.0/255.0 green:0x36*1.0/255.0 blue:0x22*1.0/255.0 alpha:1] font:TEXTFONTWITHSIZE(20) superview:self tag:120];
        label = (UILabel*)[self viewWithTag:120];
        [label setShadowColor:[UIColor whiteColor]];
        [label setShadowOffset:CGSizeMake(1, 1)];
        
        
        fYpoint = frame.size.height-55;
        fXPoint = (frame.size.width-92*2)/3;
        [self addBtn:@"racewin_continue.png" frame:CGRectMake(fXPoint+20,fYpoint,92,30) selector:@selector(clickContinueChange:) superview:self];
        [self addBtn:@"race_win_share.png" frame:CGRectMake(fXPoint+92+fXPoint-20,fYpoint,92,30) selector:@selector(clickShare:) superview:self];
        
        // Initialization code
    }
    return self;
}

-(void)showNetCannotUserAlert
{
    JFAlertView *av = [[JFAlertView alloc] initWithTitle:@"提示"
                                                 message:@"无法连接网络。" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"我知道了"];
    [av show];
    [av release];
}

-(void)clickShare:(id)sender
{
    
    if (![UtilitiesFunction networkCanUsed])
    {
        [self showNetCannotUserAlert];
        return;
    }
    UIImage *image = [UIImage getScreenImageWithView:self size:CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)];
    [JFShareManger shareWithMsg:@"hello" image:image];
    DLOG(@"clickToshare:%@",sender);
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.player = nil;
    
    
    DLOG(@"JFAnswerSucView dealloc");
    [super dealloc];
}


-(void)addHistoryView
{
    
    if (self.player.currentMaxWinCount >= self.player.maxConWinNumber)
    {
        
        UIView  *bg1View = [self viewWithTag:4321];
        UIView  *bgView = [bg1View viewWithTag:1234];
        
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeStamp];
                           [self addViewAccordImageName:@"change_historyhighest.png" frame:CGRectMake(210+135, 167, 21, 20) superView:bgView tag:0];
                           
                       });
    }

        
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


-(void)clickBackbtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(clickRaceResultBackBtn:)])
    {
        [delegate clickRaceResultBackBtn:sender];
    }
    
    [self removeFromSuperview];
}


-(void)clickContinueChange:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    
    if ([[JFLocalPlayer shareInstance] goldNumber] < 50)
    {
        JFAlertView  *av = [[JFAlertView alloc] initWithTitle:@"提示" message:@"挑战需要花费50金币，金币不足，是否需要购买金币？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"购买"];
        av.tag = 2000;
        [av show];
        [av release];
        return;
    }
    if (delegate  && [delegate respondsToSelector:@selector(continueChange:)])
    {
        [delegate continueChange:sender];
    }
    DLOG(@"clickContinueChange:%@",sender);
    [self removeFromSuperview];

}

-(void)clickMyRank:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate  && [delegate respondsToSelector:@selector(clickMyRank:)])
    {
        [delegate clickMyRank:sender];
    }
    
    
    //[self removeFromSuperview];
    DLOG(@"clickMyRank:%@",sender);
}

-(void)addlabelWithFrame:(CGRect)frame text:(NSString*)text color:(UIColor*)textColor font:(UIFont*)font superview:(UIView*)superview tag:(int)tag
{
    UILabel  *label = [[UILabel alloc] initWithFrame:frame];
    [label setText:text];
    [label setTextColor:textColor];
    label.tag = tag;
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont:font];
    [superview addSubview:label];
    [label release];
    
}

-(void)addViewAccordImageName:(NSString*)strName frame:(CGRect)frame superView:(UIView*)superView tag:(int)tag
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [PublicClass getImageAccordName:strName];
    [superView addSubview:imageView];
    imageView.tag = tag;
    [imageView release];
    
}

//73*23
-(void)addBtn:(NSString*)strName frame:(CGRect)frame selector:(SEL)selctor superview:(UIView*)supreView
{
    UIButton  *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"alert_btn_bg_pressed.png"] forState:UIControlStateNormal];
    [btn setImage:[PublicClass getImageAccordName:strName] forState:UIControlStateNormal];
    [supreView addSubview:btn];
    [btn release];
}

-(void)show
{
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    [self addobserverForBarOrientationNotification];
    UIWindow  *window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    self.transform = CGAffineTransformMakeRotation(fValue);
    self.center = window.center;
    [window addSubview:self];
    
    
    [self performSelector:@selector(addHistoryView) withObject:nil afterDelay:0.5];
}


#pragma mark jfalertView delegate
-(void)JFAlertClickView:(JFAlertView *)alertView index:(JFAlertViewClickIndex)buttonIndex
{
    if (buttonIndex == JFAlertViewClickIndexRight)
    {
        if (alertView.tag == 2000)
        {
            
            JFChargeView    *view = [[JFChargeView alloc] initWithFrame:CGRectZero];
            [view show];
            [view release];
        }
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
