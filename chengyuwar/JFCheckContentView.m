//
//  JFcheckContentView.m
//  chengyuwar
//
//  Created by ran on 13-12-13.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFCheckContentView.h"
#import "PublicClass.h"
@implementation JFCheckContentView
@synthesize delegate;
@synthesize contentType = m_icontentType;

- (id)initWithFrame:(CGRect)frame  withdataArray:(NSMutableArray*)arrayData withType:(JFIdiomContentType)type
{
    
    if (frame.size.width < 300)
    {
        NSLog(@"frame is too small:%@",[NSValue valueWithCGRect:frame]);
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self)
    {
        m_scorllView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self addSubview:m_scorllView];
        
        m_arrayData = [[NSMutableArray alloc] init];
        [m_arrayData addObjectsFromArray:arrayData];
        m_icontentType = type;
        [self loadwithArrayData:arrayData   withType:type];
        
        // Initialization code
    }
    return self;
}


-(void)loadwithArrayData:(NSMutableArray*)data  withType:(JFIdiomContentType)type
{
    
    
    DLOG(@"loadwithArrayData:%d",type);
    self.userInteractionEnabled = NO;
    [m_arrayData removeAllObjects];
    [m_arrayData addObjectsFromArray:data];
    
   
    CGRect    frame = self.frame;
    
    //m_ int rowcount = 3;
    int columcount = 6;
    CGFloat  fwidth = 50;
    CGFloat  fheight = 50;
    
    CGFloat   fXsep = (frame.size.width-fwidth*columcount)/(columcount+1);
    CGFloat   fYsep =  10;//(frame.size.width-fheight*rowcount)/();
    CGFloat   fXpoint = fXsep;
    CGFloat   fYpoint = fYsep;
    
 //   int ycount = 0;
    
   
    for (int i = 0; i < [m_arrayData count]; i++)
    {
        
        if (i != 0)
        {
            fYpoint = fYsep + ((i/columcount)%3 * (fheight+fYsep));
            
            fXpoint = (frame.size.width*(i/(columcount*3)))+fXsep+(fwidth+fXsep)*(i%columcount);
            
        }
      //  ycount = i/columcount+(i%columcount==0?1:0);
        
        
        
       // DLOG(@"fXpoint:%f fYpoint:%f i:%d",fXpoint,fYpoint,i);
        
        
      /*  dispatch_queue_t queue = dispatch_queue_create("gcdtest.rongfzh.yc", NULL);
        dispatch_async(queue, ^
                       {
                     
                           //  NSTimeInterval time1 = [[NSDate date] timeIntervalSince1970];
                        

                       });
        dispatch_release(queue);*/
        
        
        
        JFSinglecheckView  *checkView = (JFSinglecheckView*)[m_scorllView viewWithTag:100000+i];
        if (!checkView)
        {
            //   NSTimeInterval time1 = [[NSDate date] timeIntervalSince1970];
            checkView = [[JFSinglecheckView alloc] initWithFrame:CGRectMake(fXpoint, fYpoint, fwidth, fheight)];
            checkView.delegate = self;
            [m_scorllView addSubview:checkView];
            checkView.tag = 100000+i;
            [checkView release];
            //    NSTimeInterval time2 = [[NSDate date] timeIntervalSince1970];
            
            //   DLOG(@"time2:%f",time2-time1);
        }
        [checkView setFrame:CGRectMake(fXpoint, fYpoint, fwidth, fheight)];
        [checkView updateViewWithDatamodel:[m_arrayData objectAtIndex:i]];
        
       
    //     NSTimeInterval time2 = [[NSDate date] timeIntervalSince1970];
        
      //   DLOG(@"time2 update:%f",time2-time1);
      
    }
    
    
    m_totlapages = ([m_arrayData count]/18+([m_arrayData count]%18==0?1:0)+2);
 //   DLOG(@"m_totlapages:%d m_arrayData：%d",m_totlapages,[m_arrayData count]);
    [m_scorllView setContentSize:CGSizeMake(m_totlapages*frame.size.width, frame.size.height)];
    m_scorllView.showsHorizontalScrollIndicator = NO;
    [m_scorllView setContentOffset:CGPointMake(0, 0)];
    [m_scorllView setPagingEnabled:YES];
    [m_scorllView setDelegate:self];
    
    m_icontentType = type;
   // m_icontentType = JFidiomContentTypeUnlockedAll;
    [self addViewWithContentType:m_icontentType];
    
    self.userInteractionEnabled = YES;
    
}


-(void)addViewWithContentType:(JFIdiomContentType)type
{
    
    
      DLOG(@"addViewWithContentType:%d",type);
    m_icontentType = type;
    
    if (!m_labelContent)
    {
        m_labelContent = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        [m_labelContent setBackgroundColor:[UIColor clearColor]];
        [m_labelContent setTextAlignment:NSTextAlignmentCenter];
        [m_labelContent setFont:TEXTFONTWITHSIZE(23)];
        [m_labelContent setTextColor:TEXTCOMMONCOLORSecond];
        [m_labelContent setNumberOfLines:2];
        [m_labelContent setShadowColor:[UIColor colorWithRed:0xD9*1.0/255.0 green:0xB0*1.0/255.0 blue:0x8C*1.0/255.0 alpha:1.0]];
      //  [m_labelContent setCenter:CGPointMake(m_scorllView.frame.size.width-self.frame.size.width/2, self.frame.size.height/2)];
        [m_labelContent setFrame:CGRectMake(m_scorllView.contentSize.width-self.frame.size.width, (self.frame.size.height-m_labelContent.frame.size.height)/2, self.frame.size.width, 60)];
        [m_scorllView addSubview:m_labelContent];
    }
    
    NSString    *strMsg = @"通关后即可解锁更多关卡!";
    [m_progressView setHidden:YES];
    if (m_icontentType == JFidiomContentTypeNeedloadMore)
    {
        [m_progressView setHidden:NO];
        
        if (!m_progressView)
        {
            m_progressView = [[MCProgressBarView alloc] initWithFrame:CGRectMake((m_scorllView.contentSize.width-self.frame.size.width+(self.frame.size.width-206)/2), m_labelContent.frame.size.height+m_labelContent.frame.origin.y+20, 206, 18) backgroundImage:[PublicClass getImageAccordName:@"check_loadprogress_mintrack.png" ] foregroundImage:[PublicClass getImageAccordName:@"check_loadprogress_maxtrack.png"]];
            
            UILabel  *labelProgress = [[UILabel alloc] initWithFrame:m_progressView.bounds];
            [labelProgress setBackgroundColor:[UIColor clearColor]];
            [labelProgress setTextAlignment:NSTextAlignmentCenter];
            [labelProgress setTextColor:[UIColor whiteColor]];
            labelProgress.tag = 1000;
            [labelProgress setText:@"Loading...0%"];
            [m_progressView setProgress:0];
            [labelProgress setFont:TEXTFONTWITHSIZE(11)];
            [labelProgress setNumberOfLines:2];
            [m_progressView addSubview:labelProgress];
            [labelProgress release];
            
            [m_scorllView addSubview:m_progressView];
        }
        strMsg = @"一大波关卡来袭中";
    }else if (m_icontentType == JFidiomContentTypeUnlockedAll)
    {
        [self setLoadProgress:0];
        strMsg = @"恭喜！已完成全部关卡。\n更多关卡，敬请期待...";
    }else
    {
        [self setLoadProgress:0];
    }
    
      [m_labelContent setText:strMsg];
    
   
      [m_labelContent setFrame:CGRectMake(m_scorllView.contentSize.width-m_scorllView.frame.size.width, (m_scorllView.frame.size.height-m_labelContent.frame.size.height)/2, m_scorllView.frame.size.width, 60)];
      [m_progressView setFrame:CGRectMake((m_scorllView.contentSize.width-self.frame.size.width+(self.frame.size.width-206)/2), m_labelContent.frame.size.height+m_labelContent.frame.origin.y+20, 206, 18)];
    
    DLOG(@"m_labelContent:%@  m_progressView:%@ m_scroview:%@",m_labelContent,m_progressView,m_scorllView);
}

-(void)dealloc
{
    [m_progressView release];
    m_progressView = nil;
    [m_scorllView release];
    m_scorllView = nil;
    [m_arrayData release];
    m_arrayData  = nil;
    [m_labelContent release];
    m_labelContent = nil;
    
    self.delegate = nil;
    [super dealloc];
}

-(void)setLoadProgress:(CGFloat)fprogress
{
    UILabel  *label = (UILabel*)[m_progressView viewWithTag:1000];
    [m_progressView setProgress:fprogress];
    [label setText:[NSString stringWithFormat:@"Loading...%0.2f%%",fprogress*100]];
    
    if (!CGPointEqualToPoint(m_scorllView.contentOffset, CGPointMake(m_scorllView.contentSize.width-m_scorllView.frame.size.width, 0)) && fprogress > 0)
    {
        [m_scorllView setContentOffset:CGPointMake(m_scorllView.contentSize.width-m_scorllView.frame.size.width,0)];
    }
    
}

-(void)setProgress:(CGFloat)fprogress
{
    
    JFIdiomModel    *model = [m_arrayData lastObject];
    if (!model.isAnswed)
    {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        m_icontentType = JFidiomContentTypeNeedloadMore;
        [self addViewWithContentType:m_icontentType];
        
        [self setLoadProgress:fprogress];
    });

    DLOG(@"");    
}

-(void)setContentOffsetMax:(id)Thread
{
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [m_scorllView setContentOffset:CGPointMake(m_scorllView.contentSize.width-m_scorllView.frame.size.width, 0)];
       // [self scrollToIndexInTotal:[m_arrayData count]];
        if (delegate && [delegate respondsToSelector:@selector(scrollViewDidProgress:)])
        {
            [delegate scrollViewDidProgress:1];
        }
    });
    
}

-(void)scrollToIndexInTotal:(int)index
{
    int page = index/18;
    if (index%18 > 0)
    {
        page++;
    }
    
    if (page <= 0)
    {
        page = 1;
    }
    
    
    CGPoint offest = CGPointMake(m_scorllView.frame.size.width*(page-1), 0);
    [m_scorllView setContentOffset:offest];

}

#pragma mark scrollViewdelegate
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView// called on finger up as we are moving
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat  fprogress = page*1.0/(m_totlapages*1.0);
    if (page == m_totlapages-1)
    {
        fprogress = 1;
    }
    if (delegate && [delegate respondsToSelector:@selector(scrollViewDidProgress:)])
    {
        [delegate scrollViewDidProgress:fprogress];
    }
    DLOG(@"scrollViewDidEndDecelerating:%@",scrollView);
    
}// called when scroll view grinds to a halt


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat  fprogress = page*1.0/(m_totlapages*1.0);
    if (page == m_totlapages-1)
    {
        fprogress = 1;
    }
    if (delegate && [delegate respondsToSelector:@selector(scrollViewDidProgress:)])
    {
        [delegate scrollViewDidBeginProgress:fprogress];
    }
     DLOG(@"scrollViewWillBeginDragging");
}

// called on finger up if the user dragged. decelerate is true if it will continue moving afterwards
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat  fprogress = page*1.0/(m_totlapages*1.0);
    if (page == m_totlapages-1)
    {
        fprogress = 1;
    }
    if (delegate && [delegate respondsToSelector:@selector(scrollViewDidProgress:)])
    {
        [delegate scrollViewDidBeginProgress:fprogress];
    }
     DLOG(@"scrollViewDidEndDragging");
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/scrollView.frame.size.width;
    CGFloat  fprogress = page*1.0/(m_totlapages*1.0);
    if (page == m_totlapages-1)
    {
        fprogress = 1;
    }
    if (delegate && [delegate respondsToSelector:@selector(scrollViewDidProgress:)])
    {
        [delegate scrollViewDidBeginProgress:fprogress];
    }
    DLOG(@"scrollViewWillBeginDecelerating");
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)chooseIdiomModel:(JFIdiomModel*)model
{
    if (delegate && [delegate respondsToSelector:@selector(chooseIdiomModel:)])
    {
        [delegate chooseIdiomModel:model];
    }
}

@end
