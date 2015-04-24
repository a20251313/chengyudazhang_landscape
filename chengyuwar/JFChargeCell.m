//
//  JFChagreCell.m
//  chengyuwar
//
//  Created by ran on 13-12-14.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFChargeCell.h"
#import "PublicClass.h"
#import "JFAudioPlayerManger.h"
@implementation JFChargeCell
@synthesize model;
@synthesize delegate;
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

-(void)updateDataWithModel:(JFChargeProductModel*)tempModel
{
    self.model = tempModel;
    
    
    if (tempModel.productType == JFChargeProductModelTypeExchange)
    {
        UIButton    *btnExchange =  (UIButton*)[self.contentView viewWithTag:10001];
        
        if (!btnExchange)
        {
            btnExchange = [[UIButton alloc] initWithFrame:CGRectMake(220,(45-24)/2, 74, 24)];
            [btnExchange setBackgroundImage:[PublicClass getImageAccordName:@"exchange_bg.png"] forState:UIControlStateNormal];
            [btnExchange setImage:[PublicClass getImageAccordName:@"exchange_greenword.png"] forState:UIControlStateNormal];
            [self.contentView addSubview:btnExchange];
            btnExchange.tag = 10001;
            [btnExchange addTarget:self action:@selector(clickChargeBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btnExchange release];
        }
        btnExchange.hidden = NO;
        
        m_imageIcon.hidden = YES;
        m_labelMoney.hidden = YES;
        m_btnPurchase.hidden = YES;
        return;
      
    }else
    {
        UIButton    *btnExchange =  (UIButton*)[self.contentView viewWithTag:10001];
        btnExchange.hidden = YES;
        m_imageIcon.hidden = NO;
        m_labelMoney.hidden = NO;
        m_btnPurchase.hidden = NO;
        
    }
    if (!m_imageIcon)
    {
        m_imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(7, (45-15)/2, 27, 15)];
        [self.contentView addSubview:m_imageIcon];
    }
    
    m_imageIcon.image  = [PublicClass getImageAccordName:@"check_gold_icon.png"];

    if (!m_labelMoney)
    {
        m_labelMoney = [[UILabel alloc] initWithFrame:CGRectMake(25+30, (45-20)/2, 100, 20)];
        [m_labelMoney setTextColor:TEXTCOMMONCOLOR];
        [m_labelMoney setFont:TEXTFONTWITHSIZE(20)];
        [m_labelMoney setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:m_labelMoney];
        
    }
    
    [m_labelMoney setText:[NSString stringWithFormat:@"%0.0f",self.model.productValue]];
    
    if (!m_btnPurchase)
    {
        m_btnPurchase = [[UIButton alloc] initWithFrame:CGRectMake(220, (45-24)/2, 74, 24)];
        [m_btnPurchase setBackgroundImage:[PublicClass getImageAccordName:@"charge_btn.png"] forState:UIControlStateNormal];
        [m_btnPurchase setBackgroundImage:[PublicClass getImageAccordName:@"charge_btn_pressed.png"] forState:UIControlStateHighlighted];
        [m_btnPurchase addTarget:self action:@selector(clickChargeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:m_btnPurchase];
    }
    
    [m_btnPurchase setImage:[PublicClass getImageAccordName:[NSString stringWithFormat:@"charge_money%0.0f.png",self.model.productMoney]] forState:UIControlStateNormal];
    
    
}

-(void)clickChargeBtn:(id)sender
{
     [JFAudioPlayerManger playWithMediaType:JFAudioPlayerMangerTypeButtonClick];
    if (delegate && [delegate respondsToSelector:@selector(chargeProductModel:)])
    {
        [delegate chargeProductModel:self.model];
    }
    
}

-(void)dealloc
{
    [m_btnPurchase release];
    m_btnPurchase = nil;
    [m_labelMoney release];
    m_labelMoney = nil;
    [m_imageIcon release];
    m_imageIcon = nil;
    self.model = nil;
    [super dealloc];
}

@end
