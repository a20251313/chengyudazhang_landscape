//
//  JFSetCell.m
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSetCell.h"
#import "PublicClass.h"

@implementation JFSetModel

@synthesize type;
@synthesize name;
@synthesize descriptionInfo;
@synthesize fprogress;


-(id)initwithName:(NSString *)strName despcription:(NSString*)strdespcription type:(JFSetModelType)modaltype
{
    self = [super init];
    if (self)
    {
        self.name = strName;
        self.descriptionInfo = strdespcription;
        self.type = modaltype;
        
    }
    return self;
}
-(void)dealloc
{
    self.name = nil;
    self.descriptionInfo = nil;
    [super dealloc];
}

@end

@implementation JFSetCell
@synthesize setmodel;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellModel:(JFSetModel*)model
{
    self.setmodel = model;
    
    if (!m_labelName)
    {
        
        m_labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 100, 20)];
        [m_labelName setFont:TEXTFONTWITHSIZE(13)];
        [m_labelName setText:model.name];
        [m_labelName setBackgroundColor:[UIColor clearColor]];
        m_labelName.shadowColor = [UIColor whiteColor];
        m_labelName.shadowOffset =CGSizeMake(1, 1);
        [m_labelName setTextColor:TEXTCOMMONCOLORSecond];
        [self.contentView addSubview:m_labelName];
    }
    [m_labelName setText:model.name];
    
    
 
    
    
    if (model.type == JFSetModelTypeNormalType)
    {
        m_sliderInfo.hidden = YES;
        m_labelDescrition.hidden = NO;
        m_viewLogo.hidden = NO;
        
        
        if (!m_labelDescrition)
        {
            m_labelDescrition = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 100, 25)];
            [m_labelDescrition setFont:TEXTFONTWITHSIZE(9)];
            [m_labelDescrition setText:model.descriptionInfo];
            [m_labelDescrition setBackgroundColor:[UIColor clearColor]];
            [m_labelDescrition setNumberOfLines:2];
            [m_labelDescrition setTextColor:TEXTCOMMONCOLOR];
            [self.contentView addSubview:m_labelDescrition];
            
        }
        [m_labelDescrition setText:model.descriptionInfo];
        
        
        if (!m_viewLogo)
        {
            m_viewLogo = [[UIImageView alloc] initWithFrame:CGRectMake(150, 15, 14, 16)];
            m_viewLogo.image = [UIImage imageNamed:@"set_angel.png"];
            [self.contentView addSubview:m_viewLogo];
            m_viewLogo.userInteractionEnabled = YES;
        }
        
        
    }else
    {
        m_sliderInfo.hidden = NO;
        m_labelDescrition.hidden = YES;
        m_viewLogo.hidden = YES;
        
        if (!m_sliderInfo)
        {
            m_sliderInfo = [[ZVolumeSlide alloc] initWithFrame:CGRectMake(43, 17, 117, 11) withBgImage:[PublicClass getImageAccordName:@"set_slider_mintrack.png"] foreGroundImage:[PublicClass getImageAccordName:@"set_slide_maxtrack.png"]];
            
            [m_sliderInfo setThumaImage:[PublicClass getImageAccordName:@"set_slider_thuma.png"]];
            m_sliderInfo.delegate = self;
            /*
            [m_sliderInfo setThumbImage:[PublicClass getImageAccordName:@"set_slider_thuma.png"] forState:UIControlStateNormal];
            [m_sliderInfo setMinimumTrackImage:[PublicClass getImageAccordName:@"set_slider_mintrack.png"] forState:UIControlStateNormal];
            [m_sliderInfo setMaximumTrackImage:[PublicClass getImageAccordName:@"set_slide_maxtrack.png"] forState:UIControlStateNormal];
            
            [m_sliderInfo setMinimumValue:0];
            [m_sliderInfo setMaximumValue:1];
            [m_sliderInfo addTarget:self action:@selector(sliderValueChange:) forControlEvents:UIControlEventValueChanged];*/
            
            [self.contentView addSubview:m_sliderInfo];
            [m_sliderInfo setSizeSliderYpoint:0];
        }
        
        [m_sliderInfo setSlideValue:model.fprogress];
    }
    
    
}




#pragma mark ZVolumeSlideDelegate
-(void)slideValueChange:(CGFloat) value
{
    self.setmodel.fprogress = value;
    if (delegate && [delegate respondsToSelector:@selector(sliderValueChange:cell:)])
    {
        [delegate sliderValueChange:value cell:self];
    }
    
}

-(void)setSlideValue:(CGFloat)fvalue
{
    [m_sliderInfo setSlideValue:fvalue];
}


-(void)dealloc
{
    [m_labelDescrition release];
    m_labelDescrition = nil;
    [m_labelName release];
    m_labelName = nil;
    [m_sliderInfo release];
    m_sliderInfo = nil;
    [m_viewLogo release];
    m_viewLogo = nil;
    self.setmodel = nil;
    [super dealloc];
}

@end
