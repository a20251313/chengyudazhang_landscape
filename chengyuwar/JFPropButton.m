//
//  JFPropButton.m
//  chengyuwar
//
//  Created by ran on 13-12-17.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFPropButton.h"
#import "PublicClass.h"

#define GOLDBGVIEWTAG       11111111
#define GOLDICONTAG         11121111

@implementation JFPropButton
@synthesize delegate;
@synthesize propModel;

- (id)initWithFrame:(CGRect)frame  withModel:(JFPropModel*)model
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self updatePropBtn:model];
        
        [self addTarget:self action:@selector(clickSelf:) forControlEvents:UIControlEventTouchUpInside];
        // Initialization code
    }
    return self;
}



-(void)setGoldIconGray:(BOOL)bIsGray
{
    UIView  *view = [self viewWithTag:GOLDBGVIEWTAG];
    UIImageView *goldIconview =(UIImageView*) [view viewWithTag:GOLDICONTAG];
    if (goldIconview)
    {
        if (bIsGray)
        {
            [goldIconview setImage:[PublicClass getImageAccordName:@"answer_goldgray_icon.png"]];
        }else
        {
            [goldIconview setImage:[PublicClass getImageAccordName:@"answer_gold_icon.png"]];
        }
    }
    
}
-(void)dealloc
{
   [m_imageIcon release];
    m_imageIcon = nil;
    self.propModel  = nil;
    [super dealloc];
}

-(void)clickSelf:(id)sender
{
    if (delegate  && [delegate respondsToSelector:@selector(clickPropButton:button:)])
    {
     
        [delegate clickPropButton:self.propModel button:self];
    }
}

-(void)updatePropBtn:(JFPropModel*)model
{
    self.propModel = model;
    
    
    UIImageView  *imageiconbg = (UIImageView*)[self viewWithTag:1111];
    if (!imageiconbg)
    {
        imageiconbg = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-34)/2, 0, 34, 34)];
        imageiconbg.image = [PublicClass  getImageAccordName:@"answer_prop_bg.png"];
        [self addSubview:imageiconbg];
        imageiconbg.tag = 1111;
       // imageiconbg.userInteractionEnabled = YES;
        [imageiconbg release];
    }
    
    UIImage  *imageicon = [PublicClass getImageAccordName:self.propModel.propImageName];
    if (!m_imageIcon)
    {
        
       
        m_imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake((imageiconbg.frame.size.width-imageicon.size.width/2)/2, (imageiconbg.frame.size.height-imageicon.size.height/2)/2, imageicon.size.width/2, imageicon.size.height/2)];
        [imageiconbg addSubview:m_imageIcon];
      //  m_imageIcon.userInteractionEnabled = YES;
    }
    
    m_imageIcon.image = imageicon;
    
    
    UIImageView   *goldbg = (UIImageView *) [self viewWithTag:GOLDBGVIEWTAG];
    
    if (!goldbg)
    {
        goldbg = (UIImageView*)[self viewWithTag:GOLDBGVIEWTAG];
        
        if (!goldbg)
        {
          goldbg =   [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width-35)/2, imageiconbg.frame.size.height-5, 35, 10)];
            goldbg.image = [PublicClass getImageAccordName:@"answer_word_bg.png"];
            [self addSubview:goldbg];
            //  goldbg.userInteractionEnabled = YES;
            goldbg.tag = GOLDBGVIEWTAG;
            [goldbg release];
        }
    }
    
    
    for (UIView  *view in goldbg.subviews)
    {
        if (view == goldbg)
        {
            continue;
        }
        [view removeFromSuperview];
    }
    
    if (self.propModel.modelType != JFPropModelTypeShareForHelp)
    {
        UIImageView  *imageGoldicon = (UIImageView*)[goldbg viewWithTag:GOLDICONTAG];;
        if (!imageGoldicon)
        {
            imageGoldicon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 11, 6)];
            imageGoldicon.image = [PublicClass getImageAccordName:@"answer_gold_icon.png"];
            [goldbg addSubview:imageGoldicon];
            imageGoldicon.tag = GOLDICONTAG;
            //  imageGoldicon.userInteractionEnabled = YES;
            [imageGoldicon release];
            
            
            UIImage  *imageNumber = [PublicClass getImageAccordName:[NSString stringWithFormat:@"answer_%d.png",self.propModel.propPrice]];
            UIImageView  *imageNumberView = [[UIImageView alloc] initWithFrame:CGRectMake(5+11+(goldbg.frame.size.width-16-imageNumber.size.width/2)/2,(goldbg.frame.size.height-imageNumber.size.height/2)/2, imageNumber.size.width/2, imageNumber.size.height/2)];
            imageNumberView.image = imageNumber;
            //    imageNumberView.userInteractionEnabled = YES;
            [goldbg addSubview:imageNumberView];
            [imageNumberView release];
            
        }
        
        
      
    }else
    {
        UIImage  *imageNumber = [PublicClass getImageAccordName:[NSString stringWithFormat:@"answer_shareword.png"]];
        UIImageView  *imageNumberView = [[UIImageView alloc] initWithFrame:CGRectMake((goldbg.frame.size.width-imageNumber.size.width/2)/2,(goldbg.frame.size.height-imageNumber.size.height/2)/2, imageNumber.size.width/2, imageNumber.size.height/2)];
        imageNumberView.image = imageNumber;
     //   imageNumberView.userInteractionEnabled = YES;
        [goldbg addSubview:imageNumberView];
        [imageNumberView release];
        
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
