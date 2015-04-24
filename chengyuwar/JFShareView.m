//
//  JFShareView.m
//  chengyuwar
//
//  Created by ran on 13-12-25.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFShareView.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"
#import "JFAudioPlayerManger.h"

@implementation JFShareModel

@synthesize title;
@synthesize imageName;
@synthesize type;



-(id)initWithType:(JFShareModelType)modelType
{
    self = [super init];
    if (self)
    {
        self.type = modelType;
        
        switch (modelType)
        {
            case JFShareModelTypeSina:
                self.title = @"新浪微博";
                self.imageName = @"alert_share_sinaicon.png";
                break;
            case JFShareModelTypeTencent:
                self.title = @"腾讯微博";
                self.imageName = @"alert_share_qqicon.png";
                break;
            case JFShareModelTypeWeiXin:
                self.title = @"微信";
                self.imageName = @"alert_share_weixinicon.png";
                break;
            case JFShareModelTypePengyouquan:
                self.title = @"朋友圈";
                self.imageName = @"alert_share_pengyouquanicon.png";
                break;
            default:
                break;
        }
    }
    return self;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.title = nil;
    self.imageName = nil;
    [super dealloc];
}
@end

@implementation JFShareView
@synthesize delegate;

- (id)initWithLeaveCount:(int)count
{
    CGRect frame = [UIScreen mainScreen].bounds;
    
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.height, frame.size.width)];
    if (self)
    {
        m_arrayData = [[NSMutableArray alloc] init];
        m_ileaveCount = count;
        [self defaultInit];
        
        // Initialization code
    }
    
    return self;
}





-(void)addDatasource:(id)Thread
{
    JFShareModel    *modelsina = [[JFShareModel alloc] initWithType:JFShareModelTypeSina];
    JFShareModel    *modelTen = [[JFShareModel alloc] initWithType:JFShareModelTypeTencent];
    JFShareModel    *modelWeiXin = [[JFShareModel alloc] initWithType:JFShareModelTypeWeiXin];
    JFShareModel    *modelPengYouQuan = [[JFShareModel alloc] initWithType:JFShareModelTypePengyouquan];
    [m_arrayData addObject:modelsina];
    [m_arrayData addObject:modelTen];
    [m_arrayData addObject:modelWeiXin];
    [m_arrayData addObject:modelPengYouQuan];
    [modelsina release];
    [modelTen release];
    [modelPengYouQuan release];
    [modelWeiXin release];
    
}



-(void)defaultInit
{
    
    [self addDatasource:nil];
    self.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-280)/2, (self.frame.size.height-228)/2, 280, 228)];
    bgView.image = [PublicClass getImageAccordName:@"alert_bg.png"];
    bgView.userInteractionEnabled = YES;
    bgView.clipsToBounds = YES;
    [self addSubview:bgView];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeselfFromSuperview:)];
    [self addGestureRecognizer:tap];
    [tap release];
    
    
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
    

    
    
    CGFloat     fxpoint = 0;
    CGFloat     fyPoint = 20;
    UIImage     *TempImage = nil;
    if ([m_arrayData count])
    {
        TempImage = [PublicClass getImageAccordName:[[m_arrayData objectAtIndex:0] imageName]];
    }
    CGFloat     fbtnwidth  =  TempImage.size.width/2;
    CGFloat     fsep = (imagebg2.frame.size.width-fbtnwidth*[m_arrayData count])/([m_arrayData count]+1);
    fxpoint = fsep;
    
    for (int i = 0; i < [m_arrayData count]; i++)
    {
        JFShareModel    *model = [m_arrayData objectAtIndex:i];
        
        UIImageView     *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(fxpoint, fyPoint, fbtnwidth, TempImage.size.height/2)];
        imageView.image = [PublicClass getImageAccordName:model.imageName];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickShareAction:)];
        [imageView addGestureRecognizer:tap];
        [tap release];
        [imagebg2 addSubview:imageView];
        imageView.tag = model.type;
        
        UILabel     *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(fxpoint-30, fyPoint+TempImage.size.height/2+10, fbtnwidth+30*2, 21)];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        [labelTitle setTextColor:[UIColor colorWithRed:0x59*1.0/255.0 green:0x37*1.0/255.0 blue:0x22*1.0/255.0 alpha:1]];
        [labelTitle setBackgroundColor:[UIColor clearColor]];
        [labelTitle setFont:TEXTFONTWITHSIZE(12)];
        [imagebg2 addSubview:labelTitle];
        [labelTitle setText:model.title];
        
        [labelTitle release];
        [imageView release];
        fxpoint += fsep+fbtnwidth;
    }
    
    
    
    
    UIButton    *btnBack = [[UIButton alloc] initWithFrame:CGRectMake((bgView.frame.size.width-92)/2, bgView.frame.size.height-42, 92, 31)];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [btnBack setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [btnBack setImage:[UtilitiesFunction getImageAccordTitle:@"返回"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnBack];
    
    
    UIImageView  *imageTitle = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-68)/2, 0, 68, 36)];
    imageTitle.image = [PublicClass getImageAccordName:@"alert_title_share.png"];
    [bgView addSubview:imageTitle];
    
    
    
    UILabel *labelCount = [[UILabel alloc] initWithFrame:CGRectMake(10, imagebg2.frame.size.height-40, imagebg2.frame.size.width-10, 21)];
    labelCount.textAlignment = NSTextAlignmentLeft;
    [labelCount setTextColor:[UIColor colorWithRed:0x59*1.0/255.0 green:0x37*1.0/255.0 blue:0x22*1.0/255.0 alpha:1]];
    [labelCount setBackgroundColor:[UIColor clearColor]];
    [labelCount setFont:TEXTFONTWITHSIZE(15)];
    [imagebg2 addSubview:labelCount];
    [labelCount setText:[NSString stringWithFormat:@"剩余有奖分享次数:%d",m_ileaveCount]];
    
    
    
    [labelCount release];
    [btnBack release];
    [imageBg1 release];
    [imagebg2 release];
    [bgView release];
    [imageTitle release];

    
    

}

-(void)removeselfFromSuperview:(UITapGestureRecognizer*)tap
{
    
    [self removeFromSuperview];
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


-(void)clickShareAction:(UITapGestureRecognizer*)gest
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    UIView  *view = gest.view;
    if (delegate && [delegate respondsToSelector:@selector(shareWithType:)])
    {
        [delegate shareWithType:view.tag];
    }
     DLOG(@"clickShareAction:%@",gest);
     [self removeFromSuperview];

}

-(void)clickbackButton:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self removeFromSuperview];
}

-(void)dealloc
{
    [m_arrayData release];
    m_arrayData = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
