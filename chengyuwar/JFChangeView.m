//
//  JFChangeView.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFChangeView.h"
#import "PublicClass.h"
#import "JFAlertView.h"
@implementation JFChangeView
@synthesize roleType;

-(id)initWithRoleType:(JFRoleModelType)type
{
    
    self.roleType = type;
    CGSize  size = CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    
    
    
    return self;
}

-(void)appEnterForeground:(NSNotification*)note
{
    
    NSMutableArray  *arrayRight = [NSMutableArray array];
    NSMutableArray  *arrayMid = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        NSString  *strName = [NSString stringWithFormat:@"change_role%d_right.png",i+1];
        [arrayRight addObject:[PublicClass getImageAccordName:strName]];
    }
    /*   for (int i = 0; i < 7; i++)
     {
     NSString  *strName = [NSString stringWithFormat:@"change_role%d_left.png",i+1];
     [arrayleft addObject:[PublicClass getImageAccordName:strName]];
     }*/
    for (int i = 0; i < 4; i++)
    {
        NSString  *strName = [NSString stringWithFormat:@"change_link_word%d.png",i+1];
        [arrayMid addObject:[PublicClass getImageAccordName:strName]];
    }
    
    
    
    UIImageView *imageView = (UIImageView*)[self viewWithTag:1111];
    imageView.animationImages = arrayMid;
    imageView.animationDuration  = 3;
    imageView.animationRepeatCount = CGFLOAT_MAX;
    [imageView startAnimating];
    
    m_rightAniView.animationImages = arrayRight;
    m_rightAniView.animationDuration  = 0.5;
    m_rightAniView.animationRepeatCount = CGFLOAT_MAX;
    [m_rightAniView startAnimating];
    
}

-(id)init
{
    CGSize  size = CGSizeMake([[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    CGRect  frame = CGRectMake(0, 0, size.width, size.height);
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defaultInit];
        // Initialization code
    }
    return self;
}


-(void)defaultInit
{
    
    CGSize size = self.frame.size;
    if (iPhone5)
    {
        self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
        //main_bg_withnothing
    }else
    {
        self.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
    }
    
//    NSMutableArray  *arrayleft = [NSMutableArray array];
    NSMutableArray  *arrayRight = [NSMutableArray array];
    NSMutableArray  *arrayMid = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        NSString  *strName = [NSString stringWithFormat:@"change_role%d_right.png",i+1];
        [arrayRight addObject:[PublicClass getImageAccordName:strName]];
    }
 /*   for (int i = 0; i < 7; i++)
    {
        NSString  *strName = [NSString stringWithFormat:@"change_role%d_left.png",i+1];
        [arrayleft addObject:[PublicClass getImageAccordName:strName]];
    }*/
    for (int i = 0; i < 4; i++)
    {
        NSString  *strName = [NSString stringWithFormat:@"change_link_word%d.png",i+1];
        [arrayMid addObject:[PublicClass getImageAccordName:strName]];
    }
    
    
    
    UIImageView  *imageclouds = [[UIImageView alloc] initWithFrame:CGRectMake((size.width-479)/2, size.height-90, 479, 60)];
    imageclouds.image = [PublicClass getImageAccordName:@"main_bg_clouds.png"];
    [self addSubview:imageclouds];
    
    
    if (!m_leftAniView)
    {
        m_leftAniView = [[UIImageView alloc] initWithFrame:CGRectMake(5, (size.height-200)/2, 200, 200)];
        [self addSubview:m_leftAniView];

        switch (self.roleType)
        {
            case JFRoleModelTypebaijingjing:
                m_leftAniView.image = [PublicClass getImageAccordName:@"change_role_baijingjing.png"];
                break;
            case JFRoleModelTypeshaheshang:
                m_leftAniView.image = [PublicClass getImageAccordName:@"change_role_shaheshang.png"];
                break;
            case JFRoleModelTypesundashen:
                m_leftAniView.image = [PublicClass getImageAccordName:@"change_role_sundashen.png"];
                break;
            case JFRoleModelTypetangxiaozang:
                m_leftAniView.image = [PublicClass getImageAccordName:@"change_role_tangxiaozang.png"];
                break;
            case JFRoleModelTypezhuyuanshuai:
                m_leftAniView.image = [PublicClass getImageAccordName:@"change_role_zhubajie.png"];
                break;
                
            default:
                break;
        }
    }
    
    
    if (!m_rightAniView)
    {
        m_rightAniView = [[UIImageView alloc] initWithFrame:CGRectMake(size.width-200-5, (size.height-200)/2, 200, 200)];
        m_rightAniView.animationDuration = 0.5;
        m_rightAniView.animationImages = arrayRight;
        m_rightAniView.animationRepeatCount = CGFLOAT_MAX;
        [self addSubview:m_rightAniView];
        [m_rightAniView startAnimating];
    }
    
    
    UIImageView   *vsview = [[UIImageView alloc] initWithFrame:CGRectMake((size.width-90)/2, (size.height-47)/2, 90, 47)];
    vsview.image = [PublicClass getImageAccordName:@"change_VS.png"];
    [self addSubview:vsview];
    
    
    UIImageView  *wordsview = [[UIImageView alloc] initWithFrame:CGRectMake((size.width-119)/2+5, vsview.frame.size.height+vsview.frame.origin.y+20, 119, 20)];
    [self addSubview:wordsview];
    wordsview.tag = 1111;
    wordsview.animationImages = arrayMid;
    wordsview.animationDuration = 3;
    wordsview.animationRepeatCount = CGFLOAT_MAX;
    [wordsview startAnimating];
    
    
   
    
    [imageclouds release];
    [vsview release];
    [wordsview release];
    
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
    self.center =  window.center;
    [window addSubview:self];
    self.transform = CGAffineTransformMakeRotation(fValue);
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    UIImageView *imageView = (UIImageView*)[self viewWithTag:1111];
    [imageView stopAnimating];
    
    [m_rightAniView stopAnimating];
    [m_rightAniView release];
    m_rightAniView = nil;
    [m_leftAniView release];
    m_leftAniView = nil;
    [super dealloc];
}


-(void)setRightRoleImage:(JFRoleModelType)type
{
    NSString    *strImageName = nil;
    switch (type)
    {
        case JFRoleModelTypebaijingjing:
            strImageName = @"change_role8_right.png";
            break;
        case JFRoleModelTypezhuyuanshuai:
            strImageName = @"change_role7_right.png";
            break;
        case JFRoleModelTypeshaheshang:
            strImageName = @"change_shaheshang.png";
            break;
        case JFRoleModelTypesundashen:
            strImageName = @"change_sundashen.png";
            break;
        case JFRoleModelTypetangxiaozang:
            strImageName = @"change_tangxiaozang.png";
            break;
            
        default:
            break;
    }
    
    [m_rightAniView stopAnimating];
    [m_rightAniView setImage:[PublicClass getImageAccordName:strImageName]];
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
