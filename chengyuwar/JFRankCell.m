//
//  JFRankCell.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFRankCell.h"
#import "PublicClass.h"
#import "UtilitiesFunction.h"

@implementation JFRankCell
@synthesize model;
@synthesize cellHeight;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCellWithModel:(JFRankModel*)tempmodel
{
    self.model = tempmodel;
    if (model.rankIndex < 4)
    {
        m_rankLabel.hidden = YES;
        m_rankView.hidden = NO;
        
        if (!m_rankView)
        {
            m_rankView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (self.cellHeight-30)/2, 30, 30)];
            [self.contentView addSubview:m_rankView];
        }
        switch (model.rankIndex)
        {
            case 1:
                m_rankView.image = [PublicClass getImageAccordName:@"rank_first.png"];
                break;
            case 2:
                m_rankView.image = [PublicClass getImageAccordName:@"rank_second.png"];
                break;
            case 3:
                m_rankView.image = [PublicClass getImageAccordName:@"rank_third.png"];
                break;
                
            default:
                break;
        }
        
    }else
    {
        m_rankLabel.hidden = NO;
        m_rankView.hidden = YES;
        
        if (!m_rankLabel)
        {
            m_rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, (self.cellHeight-21)/2, 80, 21)];
            [m_rankLabel setTextColor:TEXTCOMMONCOLOR];
            [m_rankLabel setFont:TEXTHEITIWITHSIZE(17)];
            [m_rankLabel setBackgroundColor:[UIColor clearColor]];
            [self.contentView addSubview:m_rankLabel];
        
        }
        [m_rankLabel setText:[NSString stringWithFormat:@"%d",model.rankIndex]];
        if (model.rankIndex > 100)
        {
            [m_rankLabel setText:@"100+"];
        }
        
    }
    
    if (!m_labelName)
    {
        m_labelName = [[UILabel alloc] initWithFrame:CGRectMake(80, (self.cellHeight-21)/2, 160, 21)];
        [m_labelName setTextColor:TEXTCOMMONCOLOR];
        [m_labelName setBackgroundColor:[UIColor clearColor]];
        [m_labelName setFont:TEXTHEITIWITHSIZE(17)];
        [self.contentView addSubview:m_labelName];
    }
    [m_labelName setText:model.nickName];
    
    
    
    if (!m_rankLevel)
    {
        m_rankLevel = [[UIImageView alloc] initWithFrame:CGRectMake(80+140,  (self.cellHeight-21)/2, 50, 20)];
        [self.contentView addSubview:m_rankLevel];
    }
    [m_rankLevel setImage:[UtilitiesFunction getImageAccordTitle:[UtilitiesFunction getLevelStringAccordWinCount:model.userRankScore/3]]];
    
    if (!m_labelGold)
    {
        m_labelGold = [[UILabel alloc] initWithFrame:CGRectMake(80+80+80+40+40, (self.cellHeight-21)/2, 80, 21)];
        [m_labelGold setTextColor:[UIColor colorWithRed:0xC6*1.0/255.0 green:0x75*1.0/255.0 blue:0x23*1.0/255.0 alpha:1]];
        [m_labelGold setBackgroundColor:[UIColor clearColor]];
        [m_labelGold setFont:TEXTHEITIWITHSIZE(17)];
        [self.contentView addSubview:m_labelGold];
        
    }
    
    [m_labelGold setText:[NSString stringWithFormat:@"%d",model.userRankScore]];

    
}

-(void)dealloc
{
    [m_labelGold release];
    m_labelGold = nil;
    [m_labelName release];
    m_labelName = nil;
    [m_rankLabel release];
    m_rankLabel = nil;
    [m_rankView release];
    m_rankView = nil;
    
    self.model = nil;
    [super dealloc];
}

@end
