//
//  JFSetCell.h
//  chengyuwar
//
//  Created by ran on 13-12-12.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZVolumeSlide.h"
typedef enum
{
    JFSetModelTypeSwitchType,
    JFSetModelTypeNormalType,
}JFSetModelType;

@interface JFSetModel : NSObject



@property(nonatomic,copy)NSString  *name;
@property(nonatomic,copy)NSString  *descriptionInfo;
@property(nonatomic)JFSetModelType type;
@property(nonatomic)CGFloat        fprogress;



-(id)initwithName:(NSString *)strName despcription:(NSString*)strdespcription type:(JFSetModelType)modaltype;
//@property(nonatomic)
@end

@protocol JFSetCellDelegate <NSObject>

-(void)sliderValueChange:(CGFloat)value cell:(UITableViewCell*)cell;

@end

@interface JFSetCell : UITableViewCell<ZVolumeSlideDelegate>
{
    UILabel         *m_labelName;
    ZVolumeSlide    *m_sliderInfo;
    UILabel         *m_labelDescrition;
    UIImageView     *m_viewLogo;
    id<JFSetCellDelegate>  delegate;
}

@property(nonatomic,retain)JFSetModel  *setmodel;
@property(nonatomic,assign)id<JFSetCellDelegate>  delegate;

-(void)updateCellModel:(JFSetModel*)model;
-(void)setSlideValue:(CGFloat)fvalue;

@end
