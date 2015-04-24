//
//  JFRewardView.m
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import "JFRewardView.h"


//66 * 71
@implementation JFRewardView
@synthesize day;
@synthesize scores;
@synthesize rewardType = m_iType;


- (id)initWithFrame:(CGRect)frame  withType:(JFRewardType)type withDay:(int)tempday withScroes:(int)temscores
{
    self = [super initWithFrame:frame];
    if (self)
    {
         m_iType = type;
         self.day = tempday;
         self.scores = temscores;
        [self loadWithRewardType:type];
        // Initialization code
    }
    return self;
}


-(void)loadWithRewardType:(JFRewardType)type
{
    
    
    CGFloat  fwidth = self.frame.size.width;
  //  CGFloat  fheight = self.frame.size.height;
    CGFloat  fYpoint = 5;
    for (UIView  *view in self.subviews)
    {
        if ([view isEqual:self])
        {
            continue;
        }
        [view removeFromSuperview];
    }
    m_iType = type;
    
     self.layer.contents =(id) [PublicClass getImageAccordName:@"con_login_default_singlebg.png"].CGImage;
    
    
    if (m_iType == JFRewardTypeWillGet)
    {
        
        UIImageView  *coverView = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-70)/2, (self.frame.size.height-75)/2, 70, 75)];
        coverView.image = [PublicClass getImageAccordName:@"con_login_gained_outbg.png"];
        [self addSubview:coverView];
       
        
        UIImageView  *coverbg2 = [[UIImageView alloc] initWithFrame:self.bounds];
        coverbg2.image = [PublicClass getImageAccordName:@"con_login_default_singlebg.png"];
        [self addSubview:coverbg2];
        
        [coverbg2 release];
         [coverView release];
        //self.layer.contents =(id) [PublicClass getImageAccordName:@"con_login_gained_outbg.png"].CGImage;
        
       
    }
    /*
    if (m_iType == JFRewardTypeCover || m_iType == JFRewardTypeNormal)
    {
        self.layer.contents =(id) [PublicClass getImageAccordName:@"con_login_frame_bg.png"].CGImage;
    }else
    {
        self.layer.contents =(id) [PublicClass getImageAccordName:@"con_login_frame_redbg.png"].CGImage;
    }
    */
    
    
    //UILabel  *label = [[UILabel alloc] initWithFrame:CGRectMake(0, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
 
    
    
    UIImageView   *coverImageview = [[UIImageView alloc] initWithFrame:CGRectMake((fwidth-62)/2, fYpoint-3, 62, 66)];
    if (m_iType == JFRewardTypeWillGet)
    {
        coverImageview.image = [PublicClass getImageAccordName:@"con_login_gain_frame_bg.png"];
    }else
    {
        coverImageview.image = [PublicClass getImageAccordName:@"con_login_default_singbg2.png"];
    }
    
    [self addSubview:coverImageview];
    [coverImageview release];
    
    
    NSString  *strdays = @"第一天";
    switch (self.day)
    {
        case 1:
            strdays = @"第一天";
            break;
        case 2:
            strdays = @"第二天";
            break;
        case 3:
            strdays = @"第三天";
            break;
        case 4:
            strdays = @"第四天";
            break;
        case 5:
            strdays = @"第五天";
            break;
        default:
            break;
    }
    
    CGFloat  fcoverYpoint = 2;
    UILabel   *labelDay = [[UILabel alloc] initWithFrame:CGRectMake(0, fcoverYpoint, coverImageview.frame.size.width, 13)];
    [labelDay setText:strdays];
    [labelDay setTextColor:TEXTCOMMONCOLORSecond];
    [labelDay setTextAlignment:NSTextAlignmentCenter];
    [labelDay setFont:TEXTFONTWITHSIZE(11)];
    labelDay.shadowColor = [UIColor whiteColor];
    labelDay.shadowOffset = CGSizeMake(1, 1);
    [labelDay setBackgroundColor:[UIColor clearColor]];
    [coverImageview addSubview:labelDay];
    [labelDay release];
    
    
    fcoverYpoint += 13+2;
    
    
    UIImageView  *viewgoldbg = [[UIImageView alloc] initWithFrame:CGRectMake((coverImageview.frame.size.width-33)/2, fcoverYpoint, 33, 33)];
    viewgoldbg.image = [PublicClass getImageAccordName:@"con_login_goldframe.png"];
    [coverImageview addSubview:viewgoldbg];
    
    UIImageView  *imageviewgold = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 33, 33)];
    imageviewgold.image = [PublicClass getImageAccordName:[NSString stringWithFormat:@"con_login_day%d.png",self.day]];
    [viewgoldbg addSubview:imageviewgold];
    [imageviewgold release];
    [viewgoldbg release];
    
    
    fcoverYpoint += 33+2;
    
    UIImageView *goldNumberbg = [[UIImageView alloc] initWithFrame:CGRectMake((coverImageview.frame.size.width-55)/2, fcoverYpoint, 55, 10)];
    goldNumberbg.image = [PublicClass getImageAccordName:@"con_login_number_bg.png"];
    [coverImageview addSubview:goldNumberbg];
    [goldNumberbg release];
    
    UIImageView *goldnumber = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 10)];
    goldnumber.image = [PublicClass getImageAccordName:[NSString stringWithFormat:@"con_login_%dgold.png",self.scores]];
    [goldNumberbg addSubview:goldnumber];
    [goldnumber release];

    
    
    
    if (m_iType == JFRewardTypeWillGet)
    {
       
        
        UIImageView *checkview = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-15, self.frame.size.height-15, 20, 20)];
        checkview.image = [PublicClass getImageAccordName:@"con_login_goldchecked.png"];
        [self addSubview:checkview];
        [checkview release];
        
        
    }else if (m_iType == JFRewardTypeCover)
    {
        
     /*   UIImageView  *coverView = [[UIImageView alloc] initWithFrame:self.bounds];
        coverView.image = [PublicClass getImageAccordName:@"con_login_hasgained_bg.png"];
        [self addSubview:coverView];*/
        
        UIImageView  *gainedview = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-66)/2, (self.frame.size.height-71)/2, 66, 71)];
       // gainedview.center = coverView.center;
      //  gainedview.center = self.center;
        [self addSubview:gainedview];
        gainedview.image = [PublicClass getImageAccordName:@"con_login_hasgained_cover.png"];
      //  [coverView release];
        [gainedview release];
        
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
