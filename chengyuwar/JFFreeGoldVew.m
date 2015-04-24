//
//  JFFreeGoldVew.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//


#define VIEWTIMETAG             1100
#import "JFFreeGoldVew.h"
#import "JFAudioPlayerManger.h"
//265 *221
@implementation JFFreeGoldVew
@synthesize remainCountDown = m_iseconds;
@synthesize delegate;
@synthesize isGainGold = m_biSGainGold;
@synthesize needPlayCangain;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        
        self.needPlayCangain = YES;
        m_iseconds = 30;
        self.layer.contents = (id)[PublicClass getImageAccordName:@"freegold_bg.png"].CGImage;
        CGFloat  fYpoint = 5;
        CGFloat  fwidth = frame.size.width;
        CGFloat  fysep = 4;
        [self addViewAccordImageName:@"freegold_title.png" frame:CGRectMake((fwidth-98)/2, fYpoint, 98, 18) superView:self tag:0];
        fYpoint += fysep+18;
        
    
        m_btntreasure = [self createBtn:@"freegold_closetreasure.png" frame:CGRectMake((fwidth-51)/2,fYpoint, 51, 57) selector:@selector(clickTrseaure:)];
        [self addSubview:m_btntreasure];
        
        fYpoint += 57+fysep;
        
        UIView  *viewTime = [self CreateViewaccordTime:m_iseconds];
        viewTime.tag = VIEWTIMETAG;
        [viewTime setFrame:CGRectMake((self.frame.size.width-viewTime.frame.size.width)/2, fYpoint, viewTime.frame.size.width, viewTime.frame.size.height)];
         [self addSubview:viewTime];
        [viewTime release];
        
        fYpoint += fysep+viewTime.frame.size.height+20;
        CGFloat  fXpoint = self.frame.size.width/2-70;
        [self addViewAccordImageName:@"freegold_ruhe.png" frame:CGRectMake(fXpoint, fYpoint, 86, 18) superView:self tag:0];
        fYpoint += fysep+18;
       
        
        [self addViewAccordImageName:@"freegold_1.png" frame:CGRectMake(fXpoint, fYpoint, 65, 16) superView:self tag:0];
        fYpoint += fysep+18;
        
        [self addViewAccordImageName:@"freegold_3.png" frame:CGRectMake(fXpoint, fYpoint, 110, 16) superView:self tag:0];
         fYpoint += fysep+18;
         [self addViewAccordImageName:@"freegold_2.png" frame:CGRectMake(fXpoint, fYpoint, 160, 16) superView:self tag:0];
        
       
        
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
        
        
     //   fYpoint += fysep+18;
        // Initialization code
    }
    return self;
}



-(void)WillEnterForeground:(NSNotification*)note
{
    
    if (m_oldTimeInter > 0)
    {
        NSTimeInterval  nowtimer = [[NSDate date] timeIntervalSince1970];
        m_iseconds  =  m_iseconds -(nowtimer-m_oldTimeInter);
        [self startCountOntime:m_iseconds];
        
    }
    m_oldTimeInter = 0;
    DLOG(@"WillEnterForeground:%@   m_iSecond:%d",note,m_iseconds);
}

-(void)WillResignActive:(NSNotification*)note
{
    
    
    if (m_iseconds > 0)
    {
        m_oldTimeInter = [[NSDate date] timeIntervalSince1970];
    }else
    {
        m_oldTimeInter = 0;
    }
    DLOG(@"WillResignActive:%@  m_iSecond:%d",note,m_iseconds);
    
}




-(void)startCountOntime:(int)timer
{
    
    if (timer <= 0)
    {
        m_iseconds = -1;
        [self countdownDelete:nil];
        return;
    }
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    
    m_iseconds = timer;
    
    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1
                                         target:self
                                       selector:@selector(countdownDelete:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];
}

-(void)countdownDelete:(id)Thread
{
    m_iseconds--;
    if (m_iseconds <= 0)
    {
        [m_btntreasure setBackgroundImage:[PublicClass getImageAccordName:@"freegold_opentreasure.png"] forState:UIControlStateNormal];
        if (self.needPlayCangain)
        {
            [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeTreasure];
        }
      
        [self stopTimer];
    }
    [self replaceViewAccordTime:m_iseconds];
}

-(void)clickGainGold:(id)sender
{
    
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(clickToGainreward:)])
    {
        [delegate clickToGainreward:sender];
    }
    DLOG(@"clickGainGold:%@",sender);
    //[self removeFromSuperview];
}

-(void)clickTrseaure:(id)sender
{
    
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (m_iseconds > 0)
    {
        return;
    }
    DLOG(@"clickTrseaure:%@",sender);
    if (delegate && [delegate respondsToSelector:@selector(clickToAddGoldNumber:)])
    {
          m_biSGainGold = YES;
        [delegate clickToAddGoldNumber:30];
      
    }
    
  
  //   [self removeFromSuperview];
}


-(void)addViewAccordImageName:(NSString*)strName frame:(CGRect)frame superView:(UIView*)superView tag:(int)tag
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [PublicClass getImageAccordName:strName];
    [superView addSubview:imageView];
    imageView.tag = tag;
    [imageView release];
    
}
-(UIButton*)createBtn:(NSString*)strName frame:(CGRect)frame selector:(SEL)selctor
{
    UIButton  *btn = [[UIButton alloc] initWithFrame:frame];
    [btn addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundImage:[PublicClass getImageAccordName:strName] forState:UIControlStateNormal];
    return btn;
}

-(UIView*)CreateViewaccordTime:(int)seconds
{
    NSString  *strSecond = [NSString stringWithFormat:@"%02d",seconds%60];
    NSString  *strMin = [NSString stringWithFormat:@"%02d",seconds/60];
    NSString *strConStrint = [NSString stringWithFormat:@"%@:%@",strMin,strSecond];
    
    CGFloat fwidth = 0;
    CGFloat fheight = 0;
    CGFloat fxpoint = 0;
    
    UIView  *bgView = [[UIView alloc] initWithFrame:CGRectZero];
    for (int i = 0; i < [strConStrint length]; i++)
    {
        NSString  *strContent = [strConStrint substringWithRange:NSMakeRange(i, 1)];
        NSString  *strName = nil;
        if ([strContent isEqualToString:@":"])
        {
            strName = @"freegoldNumber_timesep.png";
        }else
        {
            strName = [NSString stringWithFormat:@"freegoldNumber%@.png",strContent];
        }
        UIImage  *Image = [PublicClass getImageAccordName:strName];
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, 0,Image.size.width/2, Image.size.height/2)];
        imageView.image = Image;
        if (fheight < Image.size.height/2)
        {
            fheight = Image.size.height/2;
        }
        fxpoint += Image.size.width/2;
        fwidth = fxpoint;
        [bgView addSubview:imageView];
        [imageView release];
    }
    
    [bgView setFrame:CGRectMake(0, 0, fwidth, fheight)];
    return bgView;
}

-(void)replaceViewAccordTime:(int)second
{
    UIView  *bgView = (UIView*)[self viewWithTag:VIEWTIMETAG];
    CGFloat fYpoint = bgView.frame.origin.y;
    [bgView removeFromSuperview];
    if (second <= 0)
    {
        [self addViewAccordImageName:@"freegold_word.png" frame:CGRectMake((self.frame.size.width-45)/2, fYpoint, 45, 18) superView:self tag:VIEWTIMETAG];
        return;
    }
    UIView  *viewTime = [self CreateViewaccordTime:second];
    viewTime.tag = VIEWTIMETAG;
    [viewTime setFrame:CGRectMake((self.frame.size.width-viewTime.frame.size.width)/2, fYpoint, viewTime.frame.size.width, viewTime.frame.size.height)];
    [self addSubview:viewTime];
    [viewTime release];
    
}

-(void)stopTimer
{
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
}

-(void)dealloc
{
    [self stopTimer];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [m_btntreasure release];
    m_btntreasure = nil;
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