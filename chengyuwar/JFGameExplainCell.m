//
//  JFGameExplainCell.m
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFGameExplainCell.h"
#import "PublicClass.h"
@implementation JFGameExplainCell
@synthesize model;

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

-(void)updateCellWithPropModel:(JFPropModel*)tempModel
{
    self.model = tempModel;
    
    
    if (!m_propicon)
    {
        m_propicon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 31, 31)];
        [self.contentView addSubview:m_propicon];
        
    }
    m_propicon.image = [PublicClass getImageAccordName:model.propImageName];
    
    if (!m_labelDescrption)
    {
        m_labelDescrption = [[UILabel alloc] initWithFrame:CGRectMake(42, 8, 120, 24)];
        m_labelDescrption.adjustsFontSizeToFitWidth = YES;
        [m_labelDescrption setBackgroundColor:[UIColor clearColor]];
        [m_labelDescrption setTextColor:TEXTCOMMONCOLOR];
        [m_labelDescrption setFont:TEXTFONTWITHSIZE(9)];
        [m_labelDescrption setNumberOfLines:3];
        [self.contentView addSubview:m_labelDescrption];
    }
    
    [m_labelDescrption setText:self.model.actionDescription];
}

-(void)dealloc
{
    [m_labelDescrption release];
    m_labelDescrption = nil;
    [m_propicon release];
    m_propicon = nil;
    self.model = nil;
    [super dealloc];
}

@end
