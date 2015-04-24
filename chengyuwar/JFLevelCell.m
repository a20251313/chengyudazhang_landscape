//
//  JFLevelCell.m
//  chengyuwar
//
//  Created by ran on 14-1-10.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFLevelCell.h"

@implementation JFLevelCell
@synthesize model;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateViewAccordCell:(JFLevelModel*)levelModel
{
    self.model = levelModel;
    
    
    if (!m_labelName)
    {
        
        m_labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, (40-20)/2, 100, 20)];
        [m_labelName setFont:TEXTFONTWITHSIZE(13)];
        [m_labelName setText:model.levelName];
        [m_labelName setBackgroundColor:[UIColor clearColor]];
        m_labelName.shadowColor = [UIColor whiteColor];
        m_labelName.shadowOffset =CGSizeMake(1, 1);
        [m_labelName setTextColor:TEXTCOMMONCOLORSecond];
        [self.contentView addSubview:m_labelName];
    }
    [m_labelName setText:model.levelName];
    
    
    if (!m_labelDescription)
    {
        m_labelDescription = [[UILabel alloc] initWithFrame:CGRectMake(60,(40-24)/2, 120, 24)];
        m_labelDescription.adjustsFontSizeToFitWidth = YES;
        [m_labelDescription setBackgroundColor:[UIColor clearColor]];
        [m_labelDescription setTextColor:TEXTCOMMONCOLOR];
        [m_labelDescription setFont:TEXTFONTWITHSIZE(9)];
        [m_labelDescription setNumberOfLines:3];
        [self.contentView addSubview:m_labelDescription];
    }
    
    [m_labelDescription setText:self.model.levelDescription];
}

-(void)dealloc
{
    self.model = nil;
    [m_labelDescription release];
    m_labelDescription = nil;
    [m_labelName release];
    m_labelName = nil;
    [super dealloc];
}

@end
