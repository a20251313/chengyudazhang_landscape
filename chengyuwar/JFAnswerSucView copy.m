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

//420 * 252
@implementation JFAnswerSucView
@synthesize player;
@synthesize delegate;

- (id)initwithPlayer:(JFLocalPlayer*)tempPlayer  goldValue:(int)goldNumber
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
        
        
        UIImageView  *bg1View = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-472)/2, 25, 472, 291)];
        bg1View.image = [PublicClass getImageAccordName:@"check_scrollerbg.png"];
        bg1View.userInteractionEnabled = YES;
        [self addSubview:bg1View];
        
        
        UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((bg1View.frame.size.width-420)/2, 30, 420, 252)];
        bgView.image = [PublicClass getImageAccordName:@"changefailbg.png"];
        bgView.userInteractionEnabled = YES;
        [bg1View addSubview:bgView];
        bgView.tag = 1234;
        bg1View.tag = 4321;
        
        
        CGFloat fxpoint = (bgView.frame.size.width/2-130)/2;
        CGFloat fypoint = (bgView.frame.size.height/2-130)/2+50;
        [self addViewAccordImageName:self.player.roleModel.ownPhoto frame:CGRectMake(fxpoint, fypoint, 130, 130) superView:bgView tag:0];
        
        
        
        fxpoint += 125;
        fypoint = 50;
       // [self addViewAccordImageName:@"racehall_level_bg.png" frame:CGRectMake(fxpoint, fypoint, 30, 46) superView:self tag:0];
        UIImageView   *viewlevelbg = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fypoint, 30, 46)];
        viewlevelbg.image = [PublicClass getImageAccordName:@"racehall_level_bg.png"];
        [bgView addSubview:viewlevelbg];
        
        UILabel *labelLevel = [[UILabel alloc] initWithFrame:CGRectMake(6, 0, 24, 46)];
        [labelLevel setNumberOfLines:2];
        [labelLevel setBackgroundColor:[UIColor clearColor]];
        [labelLevel setText:[UtilitiesFunction getLevelStringAccordWinCount:player.winNumber]];
        [labelLevel setTextColor:[UIColor colorWithRed:0x88*1.0/255.0 green:0x28*1.0/255.0 blue:0x09*1.0/255.0 alpha:1.0]];
        [labelLevel setFont:TEXTFONTWITHSIZE(17)];
        [viewlevelbg addSubview:labelLevel];
        
        [labelLevel release];
        [viewlevelbg release];
        
        fxpoint = bgView.frame.size.width/2+20;
        fypoint = 25;
        CGFloat  fysep = 5;
        
        [self addViewAccordImageName:@"change_sucword_small.png" frame:CGRectMake(fxpoint, fypoint, 91, 44) superView:bgView tag:0];
       // fxpoint += 91+10;
     //   [self addViewAccordImageName:@"change_5conlogin.png" frame:CGRectMake(fxpoint, fypoint, 16, 38) superView:bgView tag:1500];
        
        UIView  *view = [bgView viewWithTag:1500];
        view.transform = CGAffineTransformMakeRotation((M_PI*2-M_PI_4));
        
        
        
        fxpoint  = bgView.frame.size.width/2+31;
        fypoint += 49+fysep;
        [self addViewAccordImageName:@"createrole_nickname_titile.png" frame:CGRectMake(fxpoint, fypoint, 40, 17) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+40+2+20, fypoint, 100, 17) text:self.player.nickName color:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x88*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];
        
        fxpoint -= 31;
        fypoint += 17+fysep;
        [self addViewAccordImageName:@"change_currentrewards.png" frame:CGRectMake(fxpoint, fypoint, 71, 17) superView:bgView tag:0];
        [self addViewAccordImageName:@"change_gold_icon.png" frame:CGRectMake(fxpoint+71+20, fypoint+4, 15, 8) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+71+5+20+2+15, fypoint, 100, 17) text:[NSString stringWithFormat:@"%d",goldNumber] color:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x83*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1.0] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];
        
        
        fypoint += 17+fysep;
        [self addViewAccordImageName:@"racehall_wincount_word.png" frame:CGRectMake(fxpoint, fypoint, 71, 17) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+71+20, fypoint, 100, 17) text:[NSString stringWithFormat:@"%d",self.player.winNumber] color:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x83*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1.0] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];
        
    
        fypoint += 17+fysep;
        [self addViewAccordImageName:@"racehall_losecount_word.png" frame:CGRectMake(fxpoint, fypoint, 71, 17) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+71+20, fypoint, 100, 17) text:[NSString stringWithFormat:@"%d",self.player.loseNumber] color:[UIColor colorWithRed:0xBB*1.0/255.0 green:0x83*1.0/255.0 blue:0x4A*1.0/255.0 alpha:1.0] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];

        fypoint += 17+fysep;
        [self addViewAccordImageName:@"con_wincountwords.png" frame:CGRectMake(fxpoint, fypoint, 71, 17) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+71+20, fypoint, 100, 17) text:[NSString stringWithFormat:@"%d",self.player.currentMaxWinCount] color:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x33*1.0/255.0 blue:0x00*1.0/255.0 alpha:1.0] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];
      //   [self addViewAccordImageName:@"change_historyhighest.png" frame:CGRectMake(fxpoint+135, fypoint, 21, 20) superView:bgView tag:0];
        
        
        fxpoint += 11;
        fypoint += 17+fysep;
        [self addViewAccordImageName:@"racehall_totalscore_word.png" frame:CGRectMake(fxpoint, fypoint, 60, 17) superView:bgView tag:0];
        [self addlabelWithFrame:CGRectMake(fxpoint+60+20, fypoint, 100, 17) text:[NSString stringWithFormat:@"%d",self.player.score] color:[UIColor colorWithRed:0xFF*1.0/255.0 green:0x66*1.0/255.0 blue:0x00*1.0/255.0 alpha:1.0] font:TEXTHEITIWITHSIZE(17) superview:bgView tag:0];
        
    
        
        fxpoint = bgView.frame.size.width/2-20;
        fypoint = bgView.frame.size.height - 35;
        [self addBtn:@"change_continuechange_word.png" frame:CGRectMake(fxpoint, fypoint, 73, 23) selector:@selector(clickContinueChange:) superview:bgView];
        
        fxpoint = bgView.frame.size.width/2+73+30;
         [self addBtn:@"change_rank_word.png" frame:CGRectMake(fxpoint, fypoint, 73, 23) selector:@selector(clickMyRank:) superview:bgView];
        
        [bg1View release];
        [bgView release];
        
        
        // Initialization code
    }
    return self;
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
    
    if (self.player.currentMaxWinCount >= self.player.maxconwinNumber)
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
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"change_btnbg.png"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[PublicClass getImageAccordName:@"change_btnbg_pressed.png"] forState:UIControlStateNormal];
    [btn setImage:[PublicClass getImageAccordName:strName] forState:UIControlStateNormal];
    [supreView addSubview:btn];
    [btn release];
}

-(void)show
{
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    [self addobserverForBarOrientationNotification];
    UIWindow  *window = [UIApplication sharedApplication].keyWindow;
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
