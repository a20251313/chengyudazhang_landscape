//
//  JFAlertUpdateView.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFAlertUpdateView.h"
#import "JFAlertView.h"
#import "UtilitiesFunction.h"
#import "PublicClass.h"
#import "JFPhaseXmlData.h"
#import "JFAudioPlayerManger.h"

@implementation JFAlertUpdateView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self)
    {
        
        [self defaultInit];
        // Initialization code
    }
    return self;
}



-(void)loadDownZipArray:(NSMutableArray*)array
{
    if (!m_downZip)
    {
        m_downZip = [[JFDownZipManger alloc] init];
        m_downZip.delegate = self;
        
    }
    [m_downZip startDownLoadZip:array];
}

- (void)defaultInit
{
    _overlayView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CGRect  frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width);
    [_overlayView setFrame:frame];
    [self setFrame:frame];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    
    _backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 228)];
    _backgroundImageView.center = self.center;
    _backgroundImageView.image = [UIImage imageNamed:@"alert_bg.png"];
    _backgroundImageView.userInteractionEnabled = YES;
    [self addSubview:_backgroundImageView];
    
    
    CGFloat   fwidth = 280-40;
    CGFloat   fheight = 228-70;
    UIView  *bg1View = [[UIView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-fwidth)/2, (_backgroundImageView.frame.size.height-fheight)/2+5, fwidth, fheight)];
    bg1View.backgroundColor = [UIColor colorWithRed:0xB7*1.0/255.0 green:0x8E*1.0/255.0 blue:0x66*1.0/255.0 alpha:1];
    [_backgroundImageView addSubview:bg1View];
    bg1View.layer.masksToBounds = YES;
    bg1View.layer.cornerRadius = 10;
    
    UIView  *bg2View = [[UIView alloc] initWithFrame:CGRectMake(8, 8, fwidth-16, fheight-16)];
    bg2View.backgroundColor = [UIColor colorWithRed:0xE5*1.0/255.0 green:0xC8*1.0/255.0 blue:0x9C*1.0/255.0 alpha:1];
    [bg1View addSubview:bg2View];
    bg2View.layer.masksToBounds = YES;
    bg2View.layer.cornerRadius = 10;
 
    
    
    
    
    UIImage  *imageTitle = [UIImage imageNamed:@"alert_title_notice.png"];
    UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake((_backgroundImageView.frame.size.width-imageTitle.size.width/2)/2, 0, imageTitle.size.width/2, imageTitle.size.height/2)];
    titleView.image = imageTitle;
    [_backgroundImageView addSubview:titleView];
    [titleView release];
    
    
    
  
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(15,40, bg2View.frame.size.width, 24)];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.textColor = TEXTCOMMONCOLORSecond;
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(245, 82);
    _contentLabel.text = @"题库更新中，%0";
    _contentLabel.textAlignment = UITextAlignmentLeft;
    _contentLabel.numberOfLines = 1;
    _contentLabel.font = TEXTFONTWITHSIZE(17);
    _contentLabel.shadowColor = [UIColor whiteColor];
    _contentLabel.shadowOffset = CGSizeMake(0.5, 0.5);
    [bg2View addSubview:_contentLabel];
    
    
    _progressView = [[MCProgressBarView alloc] initWithFrame:CGRectMake((bg2View.frame.size.width-192)/2, _contentLabel.frame.origin.y+_contentLabel.frame.size.height+5, 192, 15) backgroundImage:[PublicClass getImageAccordName:@"alert_background_progress.png"] foregroundImage:[PublicClass getImageAccordName:@"alert_foreground_progress.png"]];
    [bg2View addSubview:_progressView];
    [_progressView setProgress:0.5];
    
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake((bg2View.frame.size.width-92)/2, bg2View.frame.size.height-35, 92, 31)];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg.png"] forState:UIControlStateNormal];
    [_backButton setBackgroundImage:[UIImage imageNamed:@"alert_btn_bg_pressed.png"] forState:UIControlStateHighlighted];
    [_backButton setImage:[UtilitiesFunction getImageAccordTitle:@"取消"] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(clickbackButton:) forControlEvents:UIControlEventTouchUpInside];
    [bg2View addSubview:_backButton];
    
    
    [bg2View release];
    [bg1View release];
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





-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_overlayView release];
    _overlayView = nil;
    [_backButton release];
    _backButton = nil;
    [_progressView release];
    _progressView = nil;
    [_contentLabel release];
    _contentLabel = nil;
    [m_downZip release];
    m_downZip = nil;
    [_backgroundImageView release];
    _backgroundImageView = nil;
    
    [super dealloc];
    
}



-(void)clickbackButton:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(clickCancelUpdateAction:)])
    {
        [delegate clickCancelUpdateAction:sender];
    }
    [_overlayView removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark    JFDownZipMangerDelegate
-(void)setProgress:(CGFloat)fprogress
{
    [_progressView setProgress:fprogress];
    NSString  *strPro = [NSString stringWithFormat:@"题库更新中，%0.2f%%",fprogress*100];
    [_contentLabel setText:strPro];
}


- (void)downLoadZipSuc:(NSMutableArray*)arrDownload
{
    NSMutableArray  *arrayHave = [JFSQLManger getAllIdiomInfo:JFIdiomTypeRace];
    NSMutableArray  *arrayAll = [NSMutableArray array];
    
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    for (JFDownUrlModel *model in arrZip)
    {
        NSMutableArray  *arrayTemp = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:model.md5String]];
        [arrayAll addObjectsFromArray:arrayTemp];
    }
    
    [self writeIdiomToDB:arrayHave arrayAll:arrayAll];
   
}


-(void)writeIdiomToDB:(NSMutableArray*)arrayHave   arrayAll:(NSMutableArray*)arrayAll
{
    if (![arrayAll count])
    {
        
        NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
        for (JFDownUrlModel *model in arrZip)
        {
            NSMutableArray  *arrayTemp = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:model.md5String]];
            [arrayAll addObjectsFromArray:arrayTemp];
        }
        
    }
    
    if (![arrayHave count])
    {
        arrayHave = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    }
    
    int level = -1;

    for (JFIdiomModel  *ididomModel in arrayAll)
    {
        if (![self checkHasSameModel:ididomModel inarray:arrayHave])
        {
            
            ididomModel.type = JFIdiomTypeRace;
            ididomModel.isAnswed = NO;
            ididomModel.isUnlocked = NO;
            ididomModel.idiomlevelString = [NSString stringWithFormat:@"%d",level];
            [JFSQLManger insertIdiomTotable:ididomModel type:JFIdiomTypeRace];
            [arrayHave addObject:ididomModel];
        }
    }
    
    
    if (delegate && [delegate respondsToSelector:@selector(downLoadUpdateInfoSuc:)])
    {
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
        
            [delegate downLoadUpdateInfoSuc:nil];
        });
        
        
    }
    
    
     [_overlayView removeFromSuperview];
     [self removeFromSuperview];
}

-(BOOL)checkHasSameModel:(JFIdiomModel*)Tempmodel inarray:(NSMutableArray*)array
{
    for (JFIdiomModel  *temp in array)
    {
        if (temp.index == Tempmodel.index && Tempmodel.packageIndex == temp.packageIndex)
        {
            return YES;
        }
    }
    return NO;
}



- (void)show
{
    [self addobserverForBarOrientationNotification];
    UIInterfaceOrientation type = [UIApplication sharedApplication].statusBarOrientation;
    CGFloat  fValue = (type == UIInterfaceOrientationLandscapeLeft?M_PI_2*3:-3*M_PI_2);
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
                       _overlayView.transform = CGAffineTransformMakeRotation(fValue);
                       self.transform = CGAffineTransformMakeRotation(fValue);
                       _overlayView.center = window.center;
                       self.center = window.center;
                       [window addSubview:_overlayView];
                       [window addSubview:self];
                   });
    
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
