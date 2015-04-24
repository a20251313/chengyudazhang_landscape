//
//  JFIdiomDetailView.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFIdiomDetailView.h"
#import "PublicClass.h"
#import "JFBlowFreshDecode.h"

@implementation JFIdiomDetailView
@synthesize delegate;
@synthesize model;
@synthesize viewStatus = m_iViewStatus;
@synthesize viewType = m_iViewType;
@synthesize remainCountDown = m_iSecond;
@synthesize answerRight = m_bisAnswerRight;
@synthesize isFailed = m_bIsFailed;


-(void)defaultInit
{
    m_arrayOption = [[NSMutableArray alloc] init];
    m_arrayBtnAnswer = [[NSMutableArray alloc] init];
    m_arrayBtnOption = [[NSMutableArray alloc] init];
    m_bIsNeedCount = YES;
    m_bIsFailed = NO;
   // UIApplication
  /*  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];*/
    
}

-(void)WillEnterForeground:(NSNotification*)note
{
   
    if (m_oldTimeInter > 0)
    {
      int  nowtimer = [[NSDate date] timeIntervalSince1970];
      m_iSecond  =  m_iSecond -(nowtimer-m_oldTimeInter);
      [self startAnswer:m_iSecond];
        
    }
    m_oldTimeInter = CGFLOAT_MAX;
    DLOG(@"WillEnterForeground:%@   m_iSecond:%d",note,m_iSecond);
}

-(void)WillResignActive:(NSNotification*)note
{
    
    
    if (m_iViewStatus == JFIdiomDetailViewStatusCounting)
    {
        m_oldTimeInter = [[NSDate date] timeIntervalSince1970];
    }else
    {
        m_oldTimeInter = CGFLOAT_MAX;
    }
    DLOG(@"WillResignActive:%@  m_iSecond:%d",note,m_iSecond);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
        m_lock = [[NSLock alloc] init];
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame  withModel:(JFIdiomModel*)tempModel
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        m_iViewStatus = JFIdiomDetailViewStatusDefault;
        [self defaultInit];
         m_lock = [[NSLock alloc] init];
         self.model = tempModel;
        [self updateViewAccordModel:tempModel];
        // Initialization code
    }
    return self;
}

-(void)updateViewAccordModel:(JFIdiomModel*)tempModel
{
    
    [m_audioManger pausePlay];
    self.model = tempModel;
    if ([tempModel.idiomOptionstr length ] < 24)
    {
        DLOG(@"updateViewAccordModel  fail optionstr unleagl:%@",tempModel.idiomOptionstr);
        
        
       // return;
    }
    
    
    DLOG(@"tempModel:%@",self.model);
    m_iTotalSecond = 30;
    m_bIsFailed = NO;
    [m_arrayOption removeAllObjects];
    for (int i = 0; i <  [tempModel.idiomOptionstr length]; i++)
    {
        NSString  *strInfo = [tempModel.idiomOptionstr substringWithRange:NSMakeRange(i, 1)];
        [m_arrayOption addObject:strInfo];
    }
    
    //CGFloat         fxpoint =  10;
    CGFloat         fypoint =  22;
    CGFloat         fysep = 5;
    UIImageView     *picbg = (UIImageView*)[self viewWithTag:1222];
    if (!picbg)
    {
        picbg = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-133)/2, fypoint, 133, 110)];
        picbg.image = [PublicClass getImageAccordName:@"answer_pic_bg.png"];
        picbg.userInteractionEnabled = YES;
        [self addSubview:picbg];
        picbg.tag = 1222;
        
        UIImageView  *imageSlice = [[UIImageView alloc] initWithFrame:picbg.bounds];
        imageSlice.image = [PublicClass getImageAccordName:@"answer_pic_slice.png"];
        [picbg addSubview:imageSlice];
        imageSlice.tag = 1223;
        [imageSlice release];
        [picbg release];
        
    }
    
    if (!m_imageAnswer)
    {
        m_imageAnswer = [[UIImageView alloc] initWithFrame:CGRectMake((picbg.frame.size.width-100)/2, (picbg.frame.size.height-100)/2, 100, 100)];
        m_imageAnswer.userInteractionEnabled = YES;
        [picbg addSubview:m_imageAnswer];
    }
    
    
    
    NSData  *data  = [JFBlowFreshDecode getDataAccordFilePath:self.model.idiomImageName];
    if (data == nil)
    {
        DLOG(@"self.model.idiomImageName:%@",data);
    }
    UIImage *image = [UIImage imageWithData:data];
    [m_imageAnswer setImage:image];
    
    UIImageView *sliceView =(UIImageView*)[picbg viewWithTag:1223];
    if (image)
    {
        sliceView.hidden = YES;
    }else
    {
        sliceView.hidden = NO;
         DLOG(@"image is not geted path:%@",self.model.idiomImageName);
    }
    
    fypoint += 110+fysep;
    
    if (!m_progressView)
    {
        m_progressView = [[MCProgressBarView alloc] initWithFrame:CGRectMake((self.frame.size.width-130)/2, fypoint, 130, 8) backgroundImage:[PublicClass getImageAccordName:@"answer_slider_bg.png"] foregroundImage:[PublicClass getImageAccordName:@"answer_slider_yellow.png"]];
        [self addSubview:m_progressView];
        [m_progressView setProgress:1];
    }
    
    fypoint += 8+fysep;
    
    if (![m_arrayBtnAnswer count])
    {
        CGFloat  fXpoint = m_progressView.frame.origin.x - 15;
        CGFloat  fXsep = 3;
        UIImageView *leftSlice = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint-15, fypoint+3, 19, 18)];
        leftSlice.image = [PublicClass getImageAccordName:@"answer_slice_left.png"];
        [self addSubview:leftSlice];
        [leftSlice release];
        
        
        UIImageView *rightSlice = [[UIImageView alloc] initWithFrame:CGRectMake(fXpoint+m_progressView.frame.size.width+30, fypoint+3, 19, 18)];
        rightSlice.image = [PublicClass getImageAccordName:@"answer_slice_right.png"];
        [self addSubview:rightSlice];
        [rightSlice release];
        
        fXpoint = m_progressView.frame.origin.x;
        fXsep = (m_progressView.frame.size.width-24*4)/3;
        for (int i = 0; i < 4; i++)
        {
            UIButton    *btnanswer = [[UIButton alloc] initWithFrame:CGRectMake(fXpoint, fypoint, 24, 24)];
            [btnanswer setBackgroundImage:[UIImage imageNamed:@"answer_btn_bg.png"] forState:UIControlStateNormal];
            [btnanswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btnanswer setTitle:@"" forState:UIControlStateNormal];
            [btnanswer addTarget:self action:@selector(clickAnswerBtn:) forControlEvents:UIControlEventTouchUpInside];
            [[btnanswer titleLabel] setFont:TEXTHEITIWITHSIZE(17)];
            btnanswer.tag = 10000+i;
            [self addSubview:btnanswer];
            [m_arrayBtnAnswer addObject:btnanswer];
            [btnanswer release];
            fXpoint += 24+fXsep;
        }
    }
    
    
    for (int i = 0; i < [m_arrayBtnAnswer count]; i++)
    {
        UIButton  *btnAnswer = [m_arrayBtnAnswer objectAtIndex:i];
        [btnAnswer setBackgroundImage:[UIImage imageNamed:@"answer_btn_bg.png"] forState:UIControlStateNormal];
        [btnAnswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnAnswer setTitle:@"" forState:UIControlStateNormal];
        [[btnAnswer titleLabel] setFont:TEXTHEITIWITHSIZE(17)];
    
    }
    
    //answer_optionbtn_bg
    fypoint +=  24+fysep;
    
    if (![m_arrayBtnOption count])
    {
        UIImageView   *optionBg = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-399)/2, fypoint, 399, 100)];
        optionBg.image = [PublicClass getImageAccordName:@"answer_option_bg.png"];
        optionBg.userInteractionEnabled = YES;
        optionBg.tag =  11223344;
        [self addSubview:optionBg];
        
        
        
        CGFloat   fxxPoint = 30;
        CGFloat   fyypoint = 10;
        CGFloat   fwwidth = 25;
        
        CGFloat   fxxSep = (optionBg.frame.size.width-fwwidth*8-fxxPoint*2)/7;
        CGFloat   fyySep = (optionBg.frame.size.height-fwwidth*3-fyypoint*2)/2;
        
        for (int i = 0; i < 24; i++)
        {
            
            CGFloat  fxxxpoint = fxxPoint+(fwwidth+fxxSep)*(i%8);
            CGFloat  fyyypoint = fyypoint;
            if (i >= 16)
            {
                fyyypoint += (fwwidth+fyySep)*2;
            }else if (i >= 8)
            {
                fyyypoint += (fwwidth+fyySep)*1;
            }
            
            UIButton  *btnOption = [[UIButton alloc] initWithFrame:CGRectMake(fxxxpoint, fyyypoint, fwwidth, fwwidth)];
            [btnOption setBackgroundImage:[PublicClass getImageAccordName:@"answer_optionbtn_bg.png"] forState:UIControlStateNormal];
            [btnOption setTitle:nil forState:UIControlStateNormal];
            [btnOption setTitleColor:[UIColor  colorWithRed:0x4B*1.0/255.0 green:0x26*1.0/255.0 blue:0x12*1.0/255.0 alpha:1] forState:UIControlStateNormal];
            [btnOption.titleLabel setFont:TEXTHEITIWITHSIZE(17)];
            [btnOption addTarget:self action:@selector(clickOptionBtn:) forControlEvents:UIControlEventTouchUpInside];
            [optionBg addSubview:btnOption];
            btnOption.tag = 10000+i;
            [m_arrayBtnOption addObject:btnOption];
            [btnOption release];
            
            
        }
        
        
        [optionBg release];
    }
    
    [self randomArrayData:m_arrayOption];
    for (int i = 0;i < [m_arrayBtnOption count];i++)
    {
        UIButton  *btnOption = [m_arrayBtnOption objectAtIndex:i];
        if (i < [m_arrayOption count])
        {
           [btnOption setTitle:[m_arrayOption objectAtIndex:i] forState:UIControlStateNormal];
        }else
        {
            [btnOption setTitle:nil forState:UIControlStateNormal];
        }
        
        btnOption.hidden = NO;
    }
    
    m_ianswercount = 0;
}



-(BOOL)isRightAnswerInForm
{
    BOOL  isright = YES;
    
    if ([self.model.idiomAnswer length] >=4)
    {
        for (int i = 0;i < [m_arrayBtnAnswer count];i++)
        {
            
            if (![[[m_arrayBtnAnswer objectAtIndex:i] titleForState:UIControlStateNormal] isEqualToString:[self.model.idiomAnswer substringWithRange:NSMakeRange(i, 1)]])
            {
                isright = NO;
                break;
            }
        }
        
    }else
    {
        isright = NO;
    }
   
    return isright;
}


-(void)clickOptionBtn:(UIButton*)sender
{
    
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (m_ianswercount >= 4)
    {
        return;
    }
    NSString  *strInfo = [sender titleForState:UIControlStateNormal];
    
    BOOL  bhasFill = NO;
    for (int i = 0; i < [m_arrayBtnAnswer count]; i++)
    {
        UIButton  *btnAnsewr = [m_arrayBtnAnswer objectAtIndex:i];
        NSString  *strAnswer = [btnAnsewr titleForState:UIControlStateNormal];
        if ([strAnswer isEqualToString:@""] || !strAnswer )
        {
            [btnAnsewr setTitle:strInfo forState:UIControlStateNormal];
            m_ianswercount++;
            bhasFill = YES;
            break;
        }
    }
    
    if (bhasFill)
    {
         [sender setHidden:YES];
    }else
    {
        DLOG(@"clickOptionBtn  no result");
         return;
    }
   
    
    
    [self judgeIsRightAnswer];
    
    
    DLOG(@"clickOptionBtn:%@",sender);
}

-(void)judgeIsRightAnswer
{
    if (m_ianswercount == 4)
    {
        if ([self isRightAnswer])
        {
            [self stopTimer:nil];
          
            [self performSelector:@selector(showRightAnswer) withObject:nil afterDelay:0.5];
        }else
        {
            [self answerErrorAni:nil];
        }
    }
    
}

-(void)showRightAnswer
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        if (m_bisAnswerRight)
        {
            return;
        }
        if (delegate && [delegate respondsToSelector:@selector(answerIdiomSuc:isUsedAvoidprop:isTimeOut:)])
        {
            [delegate answerIdiomSuc:self.model isUsedAvoidprop:NO isTimeOut:(m_iSecond < 0)];
        }
        m_bisAnswerRight = YES;
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeNormalRight];
    });

    
}

-(void)startAnswer:(int)totalTimer
{
  
    
   /* [m_audioManger pausePlay];
    
    if (totalTimer <= 0)
    {
        m_iSecond = -1;
        [m_progressView setProgress:0*1.0f/(m_iTotalSecond*1.0)];
        [self answerIdiomOverTime];
        
        DLOG(@"startAnswer by totalTimer is %d",totalTimer);
        return;
    }
    
    */
     totalTimer = CGFLOAT_MAX;
     [self stopTimer:nil];
     m_bIsNeedCount = NO;
     m_bisAnswerRight = NO;
    m_iViewStatus = JFIdiomDetailViewStatusCounting;
    m_iSecond = totalTimer;
    
    /*
    if (totalTimer <= 10 && m_bIsNeedCount)
    {
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeCountDownbegin];
        [self performSelector:@selector(PlayMainCountMedia) withObject:nil afterDelay:1];
    }
    m_timer = [[NSTimer alloc] initWithFireDate:[NSDate date]
                                       interval:1
                                         target:self
                                       selector:@selector(timeDelete:)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:m_timer forMode:NSRunLoopCommonModes];*/
}


-(void)stopTimer:(id)Thread
{
    if (m_timer)
    {
        [m_timer invalidate];
        [m_timer release];
        m_timer = nil;
    }
    [JFIdiomDetailView cancelPreviousPerformRequestsWithTarget:self selector:@selector(PlayMainCountMedia) object:nil];
    [m_audioManger pausePlay];
    m_iViewStatus = JFIdiomDetailViewStatusCounted;
    
}

-(void)answerIdiomOverTime
{
    [self stopTimer:nil];
    
    if (m_bIsNeedCount)
    {
        if (!m_bIsFailed && delegate  && [delegate respondsToSelector:@selector(answerIdiomOverTime:)])
        {
            [delegate answerIdiomOverTime:self.model];
            m_bIsFailed = YES;
            
        }
    }
    
}
-(void)timeDelete:(id)thread
{
    m_iSecond--;
    if (m_iSecond < 0)
    {
        [m_audioManger pausePlay];
        if (m_iViewType == JFIdiomDetailViewTypeRace)
        {
            [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeCountDownBoom];
        }
        [self answerIdiomOverTime];
      
        return;
    }
    
    if (m_iSecond == 10 && m_bIsNeedCount)
    {
        [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeCountDownbegin];
        [self performSelector:@selector(PlayMainCountMedia) withObject:nil afterDelay:1];
    }
    if (m_iSecond <= 10)
    {
        [m_progressView setForeViewAccordName:@"answer_slider_red.png"];
    }else
    {
         [m_progressView setForeViewAccordName:@"answer_slider_yellow.png"];
    }
    
    if (m_iSecond > 30)
    {
        [m_progressView setProgress:1];
    }else
    {
       [m_progressView setProgress:m_iSecond*1.0f/(30*1.0)];
    }
    
    
    
    
}


-(void)addCoverView:(id)Thread
{
    
   
    UIImageView *view = (UIImageView*)[self viewWithTag:1254];
    
    if (!view)
    {
        UIImageView *optionBg = (UIImageView*)[self viewWithTag:11223344];
        view =  [[UIImageView alloc] initWithFrame:optionBg.frame];
        view.tag = 1254;
        view.image = [PublicClass getImageAccordName:@"change_cover_bg.png"];
        [self addSubview:view];
        
        
        UILabel *labelAns = [[UILabel alloc] initWithFrame:CGRectMake(0, (view.frame.size.height-21)/2, view.frame.size.width, 21)];
        [labelAns setBackgroundColor:[UIColor clearColor]];
        [labelAns setTextColor:TEXTCOMMONCOLORSecond];
        [labelAns setFont:TEXTFONTWITHSIZE(20)];
        [labelAns setShadowOffset:CGSizeMake(1, 1)];
        [labelAns setText:@"对方答题中..."];
        [labelAns setTextAlignment:NSTextAlignmentCenter];
        [labelAns setShadowColor:[UIColor colorWithRed:0xD9*1.0/255.0 green:0xB0*1.0/255.0 blue:0x8C*1.0/255.0 alpha:1]];
        [view addSubview:labelAns];
        [labelAns release];
        [view release];
    }
    view.hidden = NO;
    
}

-(void)removeCoverView:(id)thread
{
    UIImageView *view = (UIImageView*)[self viewWithTag:1254];
    view.hidden = YES;
}

-(void)usePropWithType:(JFPropModelType)modelType
{
    switch (modelType)
    {
        case JFPropModelTypeTrash:
            [self randomTrashThreeOption];
            break;
        case JFPropModelTypeIdeaShow:
            [self randomOneRightAnswer];
            break;
        case JFPropModelTypeAvoidAnswer:
            [self avoidAnswerPropUsed];
            break;
        case JFPropModelTypeTimeMachine:
            [self userTimeMachine];
            break;
        default:
            break;
    }
}


-(NSString*)getNowOptionStr
{
    NSString    *strReturn = @"";
    
    for (int i = 0;i < [m_arrayBtnOption count];i++)
    {
        UIButton *btnOption = [m_arrayBtnOption objectAtIndex:i];
        NSString    *strOption = [btnOption titleForState:UIControlStateNormal];
        if (btnOption.hidden || !strOption || [strOption isEqualToString:@""])
        {
            continue;
        }
        
        strReturn = [strReturn stringByAppendingString:strOption];
        
    }
    
    return strReturn;
}
-(NSString*)getNowAnswerStr
{
    NSString    *strReturn = @"";
    
    for (int i = 0;i < [m_arrayBtnAnswer count];i++)
    {
        UIButton *btnAnswer= [m_arrayBtnAnswer objectAtIndex:i];
        NSString    *strAnswer = [btnAnswer titleForState:UIControlStateNormal];
        
        if (!strAnswer || [strAnswer isEqualToString:@""])
        {
            strAnswer = @"0";
        }
        
        strReturn = [strReturn stringByAppendingString:strAnswer];
        
    }
    return strReturn;
}



-(void)setStringAfterLoadModel:(NSString*)optionStr answerStr:(NSString*)strAnswer
{
 
    
    for (UIButton *btnOption in m_arrayBtnOption)
    {
        NSString    *strOption = [btnOption titleForState:UIControlStateNormal];
        
        BOOL  bneedHidden = NO;
        for (int i = 0; i < [optionStr length]; i++)
        {
            NSString    *subString = [optionStr substringWithRange:NSMakeRange(i, 1)];
            if ([subString isEqualToString:strOption])
            {
                [btnOption setHidden:NO];
                bneedHidden = YES;
                break;
            }
            
        }
        
        if (!bneedHidden)
        {
            [btnOption setHidden:YES];
        }
        
    }
    
    
    m_ianswercount = 0;
    for (int i = 0; i < [strAnswer length]; i++)
    {
        NSString    *strSubString = [strAnswer substringWithRange:NSMakeRange(i, 1)];
        if ([strSubString isEqualToString:@"0"])
        {
            [[m_arrayBtnAnswer objectAtIndex:i] setTitle:@"" forState:UIControlStateNormal];
        }else
        {
            [[m_arrayBtnAnswer objectAtIndex:i] setTitle:strSubString forState:UIControlStateNormal];
            m_ianswercount++;
        }
    }
    
}

-(void)userTimeMachine
{
 
    m_iTotalSecond += 30;
    
    if (m_iSecond < 0)
    {
        m_iSecond  = 30;
    }else
    {
        m_iSecond += 30;
       
    }
     [self startAnswer:m_iSecond];
   
    [JFIdiomDetailView cancelPreviousPerformRequestsWithTarget:self selector:@selector(PlayMainCountMedia) object:nil];
    [m_audioManger pausePlay];
    
}

-(void)avoidAnswerPropUsed
{
    
    [self stopTimer:nil];
    if (m_bisAnswerRight)
    {
        return;
    }
    if (delegate && [delegate respondsToSelector:@selector(answerIdiomSuc:isUsedAvoidprop:isTimeOut:)])
    {
        [delegate answerIdiomSuc:self.model isUsedAvoidprop:YES isTimeOut:(m_iSecond < 0)];
    }
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeNormalRight];
    m_bisAnswerRight = YES;
    [self stopTimer:nil];
}

-(void)randomOneRightAnswer
{
    [m_lock lock];
    DLOG(@"m_ianswercount:%d",m_ianswercount);
    if (m_ianswercount >= 4)
    {
        for (int i = 0;i < [m_arrayBtnAnswer count];i++)
        {
            UIButton  *btnAnswer = [m_arrayBtnAnswer objectAtIndex:i];
            [btnAnswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            NSString    *strTitle = [btnAnswer titleForState:UIControlStateNormal];
            NSString   *strSubString = [self.model.idiomAnswer substringWithRange:NSMakeRange(i, 1)];
            if (![strSubString isEqualToString:strTitle])
            {
                [btnAnswer setTitle:@"" forState:UIControlStateNormal];
                m_ianswercount--;
                
                for (UIButton *btnOption in m_arrayBtnOption)
                {
                    if (btnOption.hidden && [[btnOption titleForState:UIControlStateNormal] isEqualToString:strTitle])
                    {
                        [btnOption setHidden:NO];
                        break;
                    }
                }
                
            }
            
        }
            //DLOG(@"randomOneRightAnswer fail");
       // return;
    }
    
    
    
    BOOL   bRandom = NO;
    while (!bRandom && m_ianswercount < 4)
    {
        
        srandom(time(NULL));
        int randIndex = random()%[m_arrayBtnAnswer count];
        while (!bRandom)
        {
            UIButton    *btn = [m_arrayBtnAnswer objectAtIndex:randIndex];
            NSString    *strTitle = [btn titleForState:UIControlStateNormal];
            if ([strTitle isEqualToString:@""] || !strTitle)
            {
                strTitle = [self.model.idiomAnswer substringWithRange:NSMakeRange(randIndex, 1)];
                [btn setTitle:strTitle forState:UIControlStateNormal];
                for (UIButton *btnOption in m_arrayBtnOption)
                {
                    if (!btnOption.hidden && [[btnOption titleForState:UIControlStateNormal] isEqualToString:strTitle])
                    {
                        [btnOption setHidden:YES];
                        break;
                    }
                }
                m_ianswercount++;
                bRandom = YES;
            }else
            {
               
                randIndex = (randIndex+1)%[m_arrayBtnAnswer count];
            }
            
        }
       
    }
    

    DLOG(@"judgeIsRightAnswer......");
    [self judgeIsRightAnswer];
    [m_lock unlock];
}
-(void)randomTrashThreeOption
{
    int  count = 3;
    

    while (count)
    {
        srandom(time(NULL)+count);
        int randIndex = random()%[m_arrayBtnOption count];
        DLOG(@"randomTrashThreeOption index:%d  time(NULL)：%ldd",randIndex,time(NULL));
        BOOL  bget = NO;
        while (!bget)
        {
            UIButton   *btn = [m_arrayBtnOption objectAtIndex:randIndex];
            if (!btn.hidden)
            {
                BOOL  bIsRightAnswer = NO;
                for (int i = 0;i < [self.model.idiomAnswer length];i++)
                {
                    NSString   *strAnswerTemp = [self.model.idiomAnswer substringWithRange:NSMakeRange(i, 1)];
                    if ([strAnswerTemp isEqualToString:[btn titleForState:UIControlStateNormal]])
                    {
                        bIsRightAnswer = YES;
                        break;
                    }
                }
                
                if (!bIsRightAnswer)
                {
                    btn.hidden = YES;
                    count--;
                    bget = YES;
                    break;
                }else
                {
                   randIndex = (randIndex+1)%[m_arrayBtnOption count];
                }
                
                
                
            }else
            {
                randIndex = (randIndex+1)%[m_arrayBtnOption count];
            }
            
            
        }
     
    }

}
-(void)PlayMainCountMedia
{
    JFAudioPlayerMangerType  type = JFAudioPlayerMangerTypeCountDown;
    if (!m_audioManger)
    {
        m_audioManger = [[JFAudioPlayerManger alloc] initWithType:type];
    }
    [m_audioManger playWithLoops:YES];
    
}

-(void)answerErrorAni:(id)thread
{

    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeNormalWrong];
    [self flash];
}
-(void)flash
{
    for (UIButton  *btnanswer in m_arrayBtnAnswer)
    {
        [btnanswer.titleLabel setAlpha:0];
          [btnanswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
    }
    
    [UIView beginAnimations:@"flash screen" context:nil];
    [UIView setAnimationDuration:0.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationRepeatCount:3];
  //  [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
//    [UIView setAnimationDelegate:self];
    for (UIButton  *btnanswer in m_arrayBtnAnswer)
    {
         [btnanswer.titleLabel setAlpha:1];
         [btnanswer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    [UIView commitAnimations];
}


-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    for (UIButton  *btnanswer in m_arrayBtnAnswer)
    {
        [btnanswer setAlpha:1];
        [btnanswer setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
}

-(void)randomArrayData:(NSMutableArray*)array
{
    NSMutableArray *temparray = [NSMutableArray array];
    
    
    while ([array count])
    {
        srandom(time(NULL)+[array count]);
        int index = random()%[array count];
        [temparray addObject:[array objectAtIndex:index]];
        [array removeObjectAtIndex:index];
    }
    
    [array addObjectsFromArray:temparray];
    
}
-(BOOL)isRightAnswer
{
    
    if (m_ianswercount < 4)
    {
        return NO;
    }
    
    NSString  *strAnswer = @"";
    for (UIButton  *btnAnswer in m_arrayBtnAnswer)
    {
        strAnswer = [strAnswer stringByAppendingString:[btnAnswer titleForState:UIControlStateNormal]];
    }
    
    return [strAnswer isEqualToString:self.model.idiomAnswer];

}
-(void)clickAnswerBtn:(UIButton*)sender
{
    
    
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    NSString  *strInfo = [sender titleForState:UIControlStateNormal];
    if (!strInfo || [strInfo isEqualToString:@""])
    {
        return;
    }
    
    
    for (UIButton  *btnanswer in m_arrayBtnAnswer)
    {
        [btnanswer setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    [sender setTitle:@"" forState:UIControlStateNormal];
  // int  index = 0;
    for (int i = 0; i < [m_arrayBtnOption count]; i++)
    {
        UIButton  *btnoption = [m_arrayBtnOption objectAtIndex:i];
        NSString  *strAnswer = [btnoption titleForState:UIControlStateNormal];
        if ([strAnswer isEqualToString:strInfo] && btnoption.hidden)
        {
            [btnoption setHidden:NO];
            m_ianswercount--;
            break;
        }
    }
  
    
 //   [sender setHidden:YES];
    DLOG(@"clickAnswerBtn:%@",sender);
}

-(void)dealloc
{
    [m_lock release];
    m_lock = nil;
    
    self.model = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer:nil];
    [m_audioManger stopPlay];
    [m_audioManger release];
    m_audioManger = nil;
    [m_arrayBtnAnswer release];
    m_arrayBtnAnswer = nil;
    [m_arrayBtnOption release];
    m_arrayBtnOption = nil;
    [m_arrayOption release];
    m_arrayOption = nil;
    [m_imageAnswer release];
    m_imageAnswer = nil;
    [m_progressView release];
    m_progressView = nil;
    [super dealloc];
}


-(void)setProgreViewHidden:(BOOL)bHide
{
    m_bIsNeedCount = !bHide;
    [m_progressView setHidden:bHide];
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
