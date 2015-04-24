//
//  JFAnswerSucView.m
//  chengyuwar
//
//  Created by ran on 13-12-19.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAnswerFailView.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"

//420 * 252
@implementation JFAnswerFailView
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
        
      
        
        
        [self addViewAccordImageName:@"main_bg_clouds.png" frame:CGRectMake((frame.size.width-478)/2, frame.size.height-100, 478, 60) superView:self tag:0];
        
        [self addViewAccordImageName:@"racefail_bg.png" frame:CGRectMake(0, 0, frame.size.width, frame.size.height) superView:self tag:0];
        [self addViewAccordImageName:@"racefail_total.png" frame:CGRectMake((frame.size.width-480)/2, (frame.size.height-320)/2, 480, 320) superView:self tag:0];

        [self addBtn:@"racewin_continue.png" frame:CGRectMake((frame.size.width-90)/2, frame.size.height-60, 90, 31) selector:@selector(clickContinueChange:) superview:self];

        UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
        [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
        [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
        [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnback];
        [btnback release];
        // Initialization code
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.player = nil;
    
    DLOG(@"JFAnswerFailView dealloc");
    [super dealloc];
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
    
        DLOG(@"clickMyRank:%@",sender);
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate  && [delegate respondsToSelector:@selector(clickMyRank:)])
    {
        [delegate clickMyRank:sender];
    }
    
 //   [self removeFromSuperview];

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
    imageView.userInteractionEnabled = YES;
    imageView.image = [PublicClass getImageAccordName:strName];
    [superView addSubview:imageView];
    imageView.tag = tag;
    [imageView release];
    
}

//73*23
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
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    self.transform = CGAffineTransformMakeRotation(fValue);
    self.center = window.center;
    [window addSubview:self];
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
