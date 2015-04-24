//
//  JFPlayRaceManger.m
//  chengyuwar
//
//  Created by ran on 13-12-31.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFPlayRaceManger.h"
#import "PublicClass.h"
#define TIMESEP         0.15f
@implementation JFPlayRaceManger
@synthesize delegate;

-(void)playReadyAni
{
    if (m_bStop)
    {
        return;
    }
    if (![m_arrayBeforeAni count])
    {
        for (int i = 0; i < 14; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"race_begin_%d.png",i+1];
            UIImage *image = [PublicClass getImageAccordName:strName];
            [m_arrayBeforeAni addObject:image];
        }
    }
    
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView *imageBefore = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-320)/2, (frame.size.width-240)/2, 320, 240)];
    imageBefore.animationDuration = TIMESEP*[m_arrayBeforeAni count];
    imageBefore.animationImages = m_arrayBeforeAni;
    imageBefore.animationRepeatCount = 1;
    [imageBefore startAnimating];
    
    
    UIWindow    *wind = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [wind addSubview:imageBefore];
    [imageBefore release];
    imageBefore.tag = 1201;
    imageBefore.center =  wind.center;
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    imageBefore.transform = CGAffineTransformMakeRotation(fValue);
    
    [imageBefore performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:TIMESEP*[m_arrayBeforeAni count]];
    [self performSelector:@selector(playCountDown) withObject:nil afterDelay:TIMESEP*[m_arrayBeforeAni count]];
}



-(void)playCountDown
{
    if (m_bStop)
    {
        return;
    }
    NSMutableArray  *array = [NSMutableArray array];
    if (![array count])
    {
        for (int i = 0; i < 3; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"race_begin_count%d.png",i+1];
            UIImage *image = [PublicClass getImageAccordName:strName];
            [array addObject:image];
        }
    }
    
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView *imageBefore = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-320)/2, (frame.size.width-240)/2, 320, 240)];
    imageBefore.animationDuration = 1*[array count];
    imageBefore.animationImages = array;
    imageBefore.animationRepeatCount = 1;
    [imageBefore startAnimating];
    
    
    UIWindow    *wind = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [wind addSubview:imageBefore];
    [imageBefore release];
    imageBefore.center =  wind.center;
    imageBefore.tag = 1202;
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    imageBefore.transform = CGAffineTransformMakeRotation(fValue);
    [imageBefore performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:1*[array count]];
    [self performSelector:@selector(playAfterAni) withObject:nil afterDelay:1*[array count]];
    
}
-(void)playAfterAni
{
    if (m_bStop)
    {
        return;
    }
    if (![m_arrayAfter count])
    {
        for (int i = 0; i < 6; i++)
        {
            NSString *strName = [NSString stringWithFormat:@"race_begin_%d.png",i+15];
            UIImage *image = [PublicClass getImageAccordName:strName];
            [m_arrayAfter addObject:image];
        }
    }
    
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView *imageBefore = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-320)/2, (frame.size.width-240)/2, 320, 240)];
    imageBefore.animationDuration = TIMESEP*([m_arrayAfter count]);
    imageBefore.animationImages = m_arrayAfter;
    imageBefore.animationRepeatCount = 1;
    
    
    
    UIWindow    *wind = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [wind addSubview:imageBefore];
    [imageBefore release];
    imageBefore.center =  wind.center;
    imageBefore.tag = 1203;
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    imageBefore.transform = CGAffineTransformMakeRotation(fValue);
    [imageBefore startAnimating];
    [imageBefore performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:TIMESEP*[m_arrayAfter count]];
    [self performSelector:@selector(playAniFinish) withObject:nil afterDelay:TIMESEP*([m_arrayAfter count])];
    
}

-(void)stopAni
{
    m_bStop = YES;
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIView  *view = [window viewWithTag:1201];
    [view removeFromSuperview];
    view = [window viewWithTag:1202];
    [view removeFromSuperview];
    view = [window viewWithTag:1203];
    [view removeFromSuperview];
    
    
    [m_arrayAfter removeAllObjects];
    [m_arrayBeforeAni removeAllObjects];
    
}

-(void)playAniFinish
{
    
    if (delegate  && [delegate respondsToSelector:@selector(playAniFinish:)])
    {
        [delegate playAniFinish:nil];
    }
    
}
-(id)init
{
    self = [super init];
    if (self)
    {
        m_arrayAfter = [[NSMutableArray alloc] init];
        m_arrayBeforeAni = [[NSMutableArray alloc] init];
        
    }
    return self;
}

-(void)dealloc
{
    [m_arrayBeforeAni release];
    m_arrayBeforeAni = nil;
    [m_arrayAfter release];
    m_arrayAfter = nil;
    [super dealloc];
}

-(void)playSucAni:(CGFloat)aniDuction
{
    NSMutableArray  *arrayAni = [NSMutableArray array];
    for (int i = 0; i < 13; i++)
    {
        NSString    *strName = [NSString stringWithFormat:@"race_win_ani%d.png",i+1];
        [arrayAni addObject:[PublicClass getImageAccordName:strName]];
    }
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView *imageBefore = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-320)/2, (frame.size.width-240)/2, 320, 240)];
    imageBefore.animationDuration = aniDuction;
    imageBefore.animationImages = arrayAni;
    imageBefore.animationRepeatCount = 1;
    [imageBefore startAnimating];
    
    
    UIWindow    *wind = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [wind addSubview:imageBefore];
    [imageBefore release];
    imageBefore.center =  wind.center;
    imageBefore.tag = 1203;
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    imageBefore.transform = CGAffineTransformMakeRotation(fValue);
    [imageBefore performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:aniDuction];
    
}

-(void)playFailAni:(CGFloat)aniDuction
{
    NSMutableArray  *arrayAni = [NSMutableArray array];
    for (int i = 0; i < 13; i++)
    {
        NSString    *strName = [NSString stringWithFormat:@"race_fail_ani%d.png",i+1];
        [arrayAni addObject:[PublicClass getImageAccordName:strName]];
    }
    
    CGRect  frame = [UIScreen mainScreen].bounds;
    UIImageView *imageBefore = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.height-320)/2, (frame.size.width-240)/2, 320, 240)];
    imageBefore.animationDuration = aniDuction;
    imageBefore.animationImages = arrayAni;
    imageBefore.animationRepeatCount = 1;
    [imageBefore startAnimating];
    
    
    UIWindow    *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:imageBefore];
    [imageBefore release];
    imageBefore.center =  window.center;
    imageBefore.tag = 1203;
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    imageBefore.transform = CGAffineTransformMakeRotation(fValue);
    [imageBefore performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:aniDuction];
    
}
@end
