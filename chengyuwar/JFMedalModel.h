//
//  JFMedalModel.h
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum
{
    JFMedalModelTypechengyucainiao = 1000,
    JFMedalModelTypechengyudaren,
    JFMedalModelTypechengyugaoshou,
    JFMedalModelTypechengyudashi,
    
    JFMedalModelTypeshirenzhan,
    JFMedalModelTypebairenzhan,
    JFMedalModelTypeqianrenzhan,
    JFMedalModelTypezanlutoujiao,
    JFMedalModelTypemingdongyifang,
    JFMedalModelTypegaoshoujimo,
    JFMedalModelTypetiaozhanzhiwang,
   
    
}JFMedalModelType;

typedef enum
{
    JFMedalModelGetTypeNormalMode,
    JFMedalModelGetTypeRaceMode
}JFMedalModelGetType;


@interface JFMedalModel : NSObject

@property(nonatomic,copy)NSString *medalName;
@property(nonatomic,copy)NSString *medalDesription;
@property(nonatomic,copy)NSString *medalNoticeTitleImageName;
@property(nonatomic,copy)NSString *medalGrayImageName;
@property(nonatomic,copy)NSString *medalImageName;
@property(nonatomic,copy)NSString *medalGrayNameImageName;
@property(nonatomic,copy)NSString *medalNameImageName;
@property(nonatomic)BOOL        isGained;
@property(nonatomic)BOOL        isRewarded;
@property(nonatomic)JFMedalModelType medalType;
@property(nonatomic)int  rewardGold;


-(id)initWithMedalType:(JFMedalModelType)type;
+(BOOL)GetUserisRewardedBytype:(JFMedalModelType)type;
+(void)storeUserRewarded:(BOOL)bisreward type:(JFMedalModelType)type;
+(NSMutableArray*)getMedalModelArrayAccordtype:(JFMedalModelGetType)type;
@end
