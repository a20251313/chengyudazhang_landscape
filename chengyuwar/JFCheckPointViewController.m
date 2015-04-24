//
//  JFCheckPointViewController.m
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFCheckPointViewController.h"

#import "PublicClass.h"
#import "JFChargeView.h"
#import "JFMedalViewController.h"
#import "JFNormalAnswerViewController.h"
#import "UtilitiesFunction.h"
//#import "YouMiWallSpot.h"
@interface JFCheckPointViewController ()

@end

@implementation JFCheckPointViewController
@synthesize showMaxPage;

-(id)init
{
    self = [super init];
    if (self)
    {
        
        m_arrayData = [[NSMutableArray alloc] init];
        m_bIsLoading = NO;
        JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
        
        
        [player addObserver:self forKeyPath:@"goldNumber" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    }
    return self;
}




-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self refreshSelfView:nil];
}


-(void)refreshSelfView:(id)Thread
{
    
    UIView   *supergoldview = [self.view viewWithTag:10001011];//[m_goldView superview];
    UIView  *view = [supergoldview viewWithTag:1001];
    [view removeFromSuperview];
    UIImageView  *goldviewgold = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    [goldviewgold setFrame:CGRectMake(5, (supergoldview.frame.size.height-goldviewgold.frame.size.height)/2, goldviewgold.frame.size.width, goldviewgold.frame.size.height)];
    [supergoldview addSubview:goldviewgold];
    goldviewgold.tag = 1001;
    [goldviewgold release];
    DLOG(@"refreshSelfView in JFCheckPointViewController");
}

-(void)dealloc
{
    JFLocalPlayer   *player = [JFLocalPlayer shareInstance];
    [player removeObserver:self forKeyPath:@"goldNumber"];
    
    [m_contentView release];
    m_contentView = nil;
    [m_arrayData release];
    m_arrayData = nil;
    
    [m_sliderProgress release];
    m_sliderProgress = nil;
    
    [m_labelBeatScore release];
    m_labelBeatScore = nil;
    
    [m_downZip release];
    m_downZip = nil;
    

   // [JFYouMIManger removeYouMiView];
    [DownloadHttpFile CleanDelegateOfObject:self];
    [super dealloc];
}
-(void)loadView
{
    [super loadView];
    
    
    
    [self initview];
    
    
}


-(void)LoadArray:(NSMutableArray*)array
{
    
    if (![array count])
    {
        DLOG(@"Load array empty occour");
        return;
    }
    JFIdiomContentType  type = JFidiomContentTypeNeedUnlock;
    
    JFIdiomModel    *modelLast = [array lastObject];
    if (modelLast.isAnswed)
    {
        type = JFidiomContentTypeNeedloadMore;
    }
    
    
    [m_contentView loadwithArrayData:array withType:type];
    
    
    DLOG(@"LoadArray:%d",type);
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self addData];
   
    int lastLevle = [[JFLocalPlayer shareInstance] lastLevel];
    if (self.showMaxPage)
    {
        
        self.showMaxPage = NO;
        [self setContentMax];
        //[self performSelector:@selector(setContentMax) withObject:nil afterDelay:0.05];
    }else
    {
        m_bIsLoading = NO;
        [self scrollToIndex:lastLevle];
    }
    
    [self setLabelBeatProgress:lastLevle*1.0/([m_arrayData count]*1.0)];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    m_bIsStartDown = NO;
    [self setLabelBeatProgress:0];
    
    
  
    //  [self LoadArray:m_arrayData];
    
  
    
  //  [JFYouMIManger shareInstanceWithUserID:[[[JFLocalPlayer shareInstance] userID] intValue]];
   // [JFYouMIManger showSpotView];
}


-(void)addLoadProgressView
{
    m_contentView.userInteractionEnabled = NO;
    CGRect frame = [[UIScreen mainScreen] bounds];
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width-25)/2, (frame.size.height-25)/2, 25, 25)];
    view.tag = 12001;
    [self.view addSubview:view];
    [view startAnimating];
    [view release];
}


-(void)removeLoadProgressView
{
    UIActivityIndicatorView  *view = (UIActivityIndicatorView*)[self.view viewWithTag:12001];
    [view removeFromSuperview];
     m_contentView.userInteractionEnabled = YES;
}


-(void)setContentMax
{
    m_bIsLoading = NO;
    [m_contentView setContentOffsetMax:nil];
}
-(void)scrollToIndex:(int)index
{
    [m_contentView scrollToIndexInTotal:index];
}
-(void)setLabelBeatProgress:(CGFloat)fprogress
{
    [m_labelBeatScore setText:[NSString stringWithFormat:@"您已打败%0.2f%%的玩家",fprogress*100]];
}
-(void)initview
{
    CGSize  size = [[UIScreen mainScreen] bounds].size;
    CGRect  frame = CGRectMake(0, 0, size.width, size.height);
    if (iPhone5)
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing_iphone5.png"].CGImage;
        //main_bg_withnothing
    }else
    {
        self.view.layer.contents = (id)[UIImage imageNamed:@"main_bg_withnothing.png"].CGImage;
    }
    
    
    
    UIImageView  *bgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-472)/2, 25, 472, 291)];
    bgView.image = [PublicClass getImageAccordName:@"check_scrollerbg.png"];
    bgView.userInteractionEnabled = YES;
    [self.view addSubview:bgView];
    
    
    if (!m_contentView)
    {
        m_contentView = [[JFCheckContentView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-400)/2, 25, 400, 180) withdataArray:m_arrayData withType:JFidiomContentTypeNeedUnlock];
        m_contentView.delegate = self;
        [bgView addSubview:m_contentView];
    }
    
    
    if (!m_sliderProgress)
    {
        m_sliderProgress = [[ZVolumeSlide alloc] initWithFrame:CGRectMake((bgView.frame.size.width-125)/2, m_contentView.frame.origin.y+m_contentView.frame.size.height+8, 125, 8) withBgImage:[PublicClass getImageAccordName:@"check_slider_bg.png"] foreGroundImage:[PublicClass getImageAccordName:@"check_slider_bg.png"]];
        [m_sliderProgress setThumaImage:[PublicClass getImageAccordName:@"check_slider_thumamax.png"]];
        [bgView addSubview:m_sliderProgress];
        [m_sliderProgress setUserInteractionEnabled:NO];
         m_sliderProgress.hidden = YES;
    }
    
    /*
     UIButton   *btnGaingold = [[UIButton alloc] initWithFrame:CGRectMake(22, bgView.frame.size.height-60, 40, 48)];
     [btnGaingold setImage:[PublicClass getImageAccordName:@"check_gaingold_btn.png"] forState:UIControlStateNormal];
     [btnGaingold addTarget:self action:@selector(clickGainGoldbtn:) forControlEvents:UIControlEventTouchUpInside];
     [bgView addSubview:btnGaingold];*/
    
    
    UIButton   *btnmedal = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width-20-33, bgView.frame.size.height-55, 28, 43)];
    [btnmedal setImage:[PublicClass getImageAccordName:@"check_medal_btn.png"] forState:UIControlStateNormal];
    [btnmedal addTarget:self action:@selector(clickMedalbtn:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:btnmedal];
    
    UIImageView  *imageScoreBg = [[UIImageView alloc] initWithFrame:CGRectMake((bgView.frame.size.width-155)/2, m_sliderProgress.frame.origin.y+m_sliderProgress.frame.size.height+10, 155, 25)];
    [imageScoreBg setImage:[PublicClass getImageAccordName:@"check_bottomword_bg.png"]];
    [bgView addSubview:imageScoreBg];
    
    if (!m_labelBeatScore)
    {
        m_labelBeatScore = [[UILabel alloc] initWithFrame:CGRectMake(0, (imageScoreBg.frame.size.height-21)/2, imageScoreBg.frame.size.width, 21)];
        [m_labelBeatScore setTextColor:[UIColor colorWithRed:0x69*1.0/255.0 green:0x46*1.0/255.0 blue:0x2F*1.0/255.0 alpha:1]];
        [m_labelBeatScore setFont:TEXTFONTWITHSIZE(11)];
        [m_labelBeatScore setText:[NSString stringWithFormat:@"您已打败10.24%%的玩家"]];
        [m_labelBeatScore setBackgroundColor:[UIColor clearColor]];
        [m_labelBeatScore setTextAlignment:NSTextAlignmentCenter];
        [imageScoreBg addSubview:m_labelBeatScore];
    }
    
    
    UIButton      *btnback = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 27+40, 22+4)];
    [btnback setImageEdgeInsets:UIEdgeInsetsMake(2, 20, 2, 20)];
    [btnback setImage:[PublicClass getImageAccordName:@"about_back.png"] forState:UIControlStateNormal];
    [btnback addTarget:self action:@selector(clickBackbtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnback];
    
    
    UIImageView     *imagegoldbg = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-115, 10, 87, 23)];
    imagegoldbg.image = [PublicClass getImageAccordName:@"check_goldnumber_bg.png"];
    imagegoldbg.userInteractionEnabled = YES;
    [self.view addSubview:imagegoldbg];
    imagegoldbg.tag = 10001011;
    
    
    UIButton      *btnaddgold = [[UIButton alloc] initWithFrame:CGRectMake(imagegoldbg.frame.size.width-22, (imagegoldbg.frame.size.height-20)/2, 20, 20)];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add.png"] forState:UIControlStateNormal];
    [btnaddgold setBackgroundImage:[PublicClass getImageAccordName:@"check_add_pressed.png"] forState:UIControlStateHighlighted];
    [btnaddgold addTarget:self action:@selector(clickAddGold:) forControlEvents:UIControlEventTouchUpInside];
    [imagegoldbg addSubview:btnaddgold];
    
    UITapGestureRecognizer  *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAddGold:)];
    [imagegoldbg addGestureRecognizer:tap];
    [tap release];
    
    
    UIImageView  *goldviewgold = [[UtilitiesFunction getImagewithNumber:[[JFLocalPlayer shareInstance] goldNumber] type:JFPicNumberTypeGoldNumber] retain];
    
    [goldviewgold setFrame:CGRectMake(5, (imagegoldbg.frame.size.height-goldviewgold.frame.size.height)/2, goldviewgold.frame.size.width, goldviewgold.frame.size.height)];
    [imagegoldbg addSubview:goldviewgold];
    goldviewgold.tag = 1001;
    
    
    
    UIImageView  *goldIcon = [[UIImageView alloc] initWithFrame:CGRectMake((imagegoldbg.frame.origin.x-35), 15, 28, 15)];
    goldIcon.image = [PublicClass getImageAccordName:@"check_gold_icon.png"];
    [self.view addSubview:goldIcon];
    
    
    [bgView release];
    [goldIcon release];
    [goldviewgold release];
    [btnaddgold release];
    [imagegoldbg release];
    [btnback release];
    [imageScoreBg release];
    [btnmedal release];
    //  [btnGaingold release];
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
-(void)writeIdiomToDB:(NSMutableArray*)arrayHave   arrayAll:(NSMutableArray*)arrayAll
{
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       m_contentView.userInteractionEnabled = NO;
                       
                       //  [m_contentView addViewWithContentType:JFidiomContentTypeNeedUnlock];
                   });
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
    
    int level = [arrayHave count]+1;
    int  maxcount = LEVELIMPORTCOUNT;
    while (maxcount > 0)
    {
        
        srandom(time(NULL)+maxcount);
        int  index = random()%[arrayAll count];
        DLOG(@"maxcount:%d index:%d level:%d",maxcount,index,level);
        BOOL bGet = NO;
        while (!bGet)
        {
            JFIdiomModel *ididomModel = [arrayAll objectAtIndex:index];
            if (![self checkHasSameModel:ididomModel inarray:arrayHave])
            {
                
                ididomModel.type = JFIdiomTypeNormal;
                ididomModel.isAnswed = NO;
                ididomModel.isUnlocked = NO;
                ididomModel.idiomlevelString = [NSString stringWithFormat:@"%d",level];
                [JFSQLManger insertIdiomTotable:ididomModel type:JFIdiomTypeNormal];
                
                if (!m_bIsStartDown)
                {
                   [m_contentView setProgress:(LEVELIMPORTCOUNT-maxcount)*1.0/(LEVELIMPORTCOUNT*1.0)];
                }
                [arrayHave addObject:ididomModel];
              //  [arrayAll removeObject:ididomModel];
                maxcount--;
                level++;
                bGet = YES;
            }else
            {
                index = (index+1)%[arrayAll count];
            }
            
        }
        
        
    }
    
    [m_arrayData removeAllObjects];
    [m_arrayData addObjectsFromArray:arrayHave];
    
    // m_bIsDownload = NO;
    
    
    int lasetlevelindex = [[JFLocalPlayer shareInstance] lastLevel];
    
    for (JFIdiomModel *model in m_arrayData)
    {
        if (!model.isAnswed)
        {
            model.isUnlocked = YES;
            [JFSQLManger setLevelUnlocked:[model.idiomlevelString intValue]];
            break;
        }
    }
    
    
  
   
    
    if ([JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeRace] < [JFPhaseXmlData getAllIdiomCountFromDownloadFiles])
    {
        [JFSQLManger insertDataToSQLForRace];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^
                   {
                       [self LoadArray:m_arrayData];
                       [m_contentView scrollToIndexInTotal:lasetlevelindex];
                       [self setLabelBeatProgress:lasetlevelindex*1.0/([m_arrayData count]*1.0)];
                       m_contentView.userInteractionEnabled = YES;
                       
                       //  [m_contentView addViewWithContentType:JFidiomContentTypeNeedUnlock];
                   });
  
   
    
    
    DLOG(@"writeIdiomToDB:%d",JFidiomContentTypeNeedUnlock);
    // [m_contentView setContentOffsetMax:nil];
}



-(BOOL)check
{
    return YES;
    int lasetlevelindex = [[JFLocalPlayer shareInstance] lastLevel];
    [m_contentView scrollToIndexInTotal:lasetlevelindex];
    NSMutableArray  *arrayIdiom = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    NSMutableArray  *arrayAllcount = [NSMutableArray array];
    for (JFDownUrlModel *model in arrZip)
    {
        NSMutableArray  *arrayTemp = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:model.md5String]];
        [arrayAllcount addObjectsFromArray:arrayTemp];
    }
    
    if ([arrayAllcount count] >= [arrayIdiom count]+LEVELIMPORTCOUNT)
    {
      //  [self setProgress:0.2];
        

        [self writeIdiomToDB:arrayIdiom arrayAll:arrayAllcount];
        return YES;
    }
    
    
    
    /*
    JFLanchModel    *lanchModel = [[JFLocalPlayer shareInstance] lanchModel];
    int     version = [JFPhaseXmlData phaseXml:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml];
    if (version != lanchModel.question_db_xml_ver)
    {
        
        [UtilitiesFunction deleteNomalXmlPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME]];
        DownloadHttpInfo    *object = [[DownloadHttpInfo alloc] initWithDelegate:self fileUrl:lanchModel.question_db_xml_url fileName:DOWNXMLFILENAME downType:DownloadHttpFileDownTypeNormalXml];
        [DownloadHttpFile addDownFileObjects:object];
        [object release];
        return YES;
        
    }else
    {
        NSMutableArray  *outArray = [NSMutableArray array];
        BOOL    bNeed = [JFPhaseXmlData checkArrayZip:arrZip outArray:outArray];
        if (bNeed && [outArray count])
        {
            m_bIsStartDown = YES;
            [m_contentView setProgress:0];
            [self startDownLoadQustions:outArray];
            return YES;
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
            [m_contentView addViewWithContentType:JFidiomContentTypeUnlockedAll];
             m_contentView.userInteractionEnabled = YES;
            });
         
        }
        
    }*/
    
    dispatch_async(dispatch_get_main_queue(), ^{
        m_contentView.userInteractionEnabled = YES;
    });
    return NO;
    
}
-(BOOL)checkNeedLoadProgressView
{

   
    dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", NULL);
    dispatch_async(queue, ^{
        [self check];});
    dispatch_release(queue);
    return YES;
}



-(void)setProgress:(float)newProgress
{
    [m_contentView setProgress:newProgress];
    DLOG(@"setProgress:%f",newProgress);
}

-(void)startDownLoadQustions:(NSMutableArray*)arrayInfo
{
    [m_contentView setProgress:0.0];
    
    if (!m_downZip)
    {
        m_downZip = [[JFDownZipManger alloc] init];
        m_downZip.delegate = self;
        
    }
    [m_downZip startDownLoadZip:arrayInfo];
    
}



-(void)clickAddGold:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFChargeView  *chargeView = [[JFChargeView alloc] initWithFrame:CGRectZero];
    [chargeView show];
    [chargeView release];
    DLOG(@"clickAddGold:%@",sender);
}

-(void)clickBackbtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)clickGainGoldbtn:(id)sender
{
    
    DLOG(@"clickGainGoldbtn:%@",sender);
}
-(void)clickMedalbtn:(id)sender
{
    [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    JFMedalViewController  *contrlller = [[JFMedalViewController alloc] init];
    [self.navigationController pushViewController:contrlller animated:YES];
    [contrlller release];
    DLOG(@"clickMedalbtn:%@",sender);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    /*
     CGRect frame = [UIScreen mainScreen].bounds;
     
     if (![[JFLocalPlayer shareInstance] isPayedUser])
     {
     [JFYouMIManger addYouMiadView:self.view frame:CGRectMake((frame.size.height-320)/2, 0, 320, 50)];
     }*/
    
    
	// Do any additional setup after loading the view.
}

-(void)addData
{
    
  //  [self addLoadProgressView];
    [m_arrayData removeAllObjects];
 
    NSMutableArray  *arraydata = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    [m_arrayData addObjectsFromArray:arraydata];
    
    

   /* for (int i = [m_arrayData count]-1;i < [m_arrayData count];i--)
    {
        JFIdiomModel  *model = [m_arrayData objectAtIndex:i];
        if (model.isAnswed)
        {
            if ([model.idiomlevelString intValue]+1 < [m_arrayData count])
            {
                model.isUnlocked = YES;
                JFIdiomModel    *temomodel = [m_arrayData objectAtIndex:[model.idiomlevelString intValue]+1];
                [JFSQLManger setLevelUnlocked:[temomodel.idiomlevelString intValue]];
            }
        }
        
    }*/


    /*
     for (JFIdiomModel *model in m_arrayData)
     {
     if (!model.isAnswed)
     {
     model.isUnlocked = YES;
     [JFSQLManger setLevelUnlocked:[model.idiomlevelString intValue]];
     break;
     }
     }*/
    
    [self LoadArray:m_arrayData];
    
  //  [self removeLoadProgressView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  JFSinglecheckViewDelegate
-(void)chooseIdiomModel:(JFIdiomModel*)model
{
    if (!model.isUnlocked)
    {
        return;
    }
    if ([model.idiomlevelString intValue]%120 == 1 && [model.idiomlevelString intValue] > 1)
    {
        if (![JFSQLManger levelIsPurchased:[model.idiomlevelString intValue]-1])
        {
            JFUnlockView    *unview = [[JFUnlockView alloc] initWithFrame:CGRectZero withLevel:[model.idiomlevelString intValue]-1];
            [unview show];
            [unview release];
            return;
        }
    }
    
    JFNormalAnswerViewController  *controller = [[JFNormalAnswerViewController alloc] initWithWithIdiomModel:model arrayIdioms:m_arrayData];
    [self.navigationController pushViewController:controller animated:YES];
    [controller release];
    
    
}

#pragma mark  JFCheckContentViewDelegate
-(void)scrollViewDidProgress:(CGFloat)fprogress
{
    
    
    [m_sliderProgress setSlideValue:fprogress];
    m_sliderProgress.hidden = YES;
    if (fprogress == 1)
    {
        if (m_contentView.contentType == JFidiomContentTypeNeedloadMore  && !m_bIsLoading)
        {
            m_bIsLoading = YES;
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               m_contentView.userInteractionEnabled = NO;
                               
                               //  [m_contentView addViewWithContentType:JFidiomContentTypeNeedUnlock];
                           });
            [self performSelector:@selector(checkNeedLoadProgressView) withObject:nil afterDelay:0.5];
            //[self checkNeedLoadProgressView];
        }
        
    }
    
}

-(void)scrollViewDidBeginProgress:(CGFloat)fprogress
{
    
    [m_sliderProgress setSlideValue:fprogress];
   // [m_sliderProgress setValue:fprogress animated:YES];
    m_sliderProgress.hidden = NO;
    if (fprogress == 1)
    {
        
        if (m_contentView.contentType == JFidiomContentTypeNeedloadMore  && !m_bIsLoading)
        {
            m_bIsLoading = YES;
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               m_contentView.userInteractionEnabled = NO;
                               
                               //  [m_contentView addViewWithContentType:JFidiomContentTypeNeedUnlock];
                           });
            [self checkNeedLoadProgressView];
        }
        
    }
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


- (BOOL)shouldAutorotate
{
    DLOG(@"shouldAutorotate");
    return YES;
}


- (NSUInteger)supportedInterfaceOrientations
{
    return  UIInterfaceOrientationMaskLandscape;
}

#pragma mark
- (void)downLoadZipSuc:(NSMutableArray*)arrDownload
{
    [self checkNeedLoadProgressView];
}





#pragma mark    DownloadHttpFileDelegate

-(void)downNormalXmlSuc:(DownloadHttpInfo*)object
{
    [self checkNeedLoadProgressView];
    DLOG(@"downNormalXmlSuc:%@",object);
}

@end
