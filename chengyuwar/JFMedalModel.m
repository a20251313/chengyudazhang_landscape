//
//  JFMedalModel.m
//  chengyuwar
//
//  Created by ran on 13-12-16.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFMedalModel.h"
#import "JFLocalPlayer.h"

@implementation JFMedalModel

@synthesize medalDesription;
@synthesize medalGrayImageName;
@synthesize medalGrayNameImageName;
@synthesize medalImageName;
@synthesize medalName;
@synthesize medalNameImageName;
@synthesize medalNoticeTitleImageName;
@synthesize medalType;
@synthesize isGained;
@synthesize rewardGold;
@synthesize isRewarded;



+(NSMutableArray*)getMedalModelArrayAccordtype:(JFMedalModelGetType)type
{
    NSMutableArray  *array = [NSMutableArray array];
/*
#if USETESTDATA
    if (type == JFMedalModelGetTypeNormalMode)
    {
        int lastLevel = [[JFLocalPlayer shareInstance] lastLevel];
        if (lastLevel >= 5)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyucainiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyucainiao] autorelease]];
            }
        }
        if (lastLevel >= 10)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudaren])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudaren] autorelease]];
            }
        }
        if (lastLevel >= 15)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyugaoshou])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyugaoshou] autorelease]];
            }
        }
        if (lastLevel >= 20)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudashi])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudashi] autorelease]];
            }
        }
        
    }else
    {
        int maxconwinnumber = [[JFLocalPlayer shareInstance] maxconwinNumber];
        if (maxconwinnumber >= 1)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypezanlutoujiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypezanlutoujiao] autorelease]];
            }
        }
        if (maxconwinnumber >= 3)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypemingdongyifang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypemingdongyifang] autorelease]];
            }
        }
        if (maxconwinnumber >= 5)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypegaoshoujimo])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypegaoshoujimo] autorelease]];
            }
        }
        if (maxconwinnumber >= 7)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypetiaozhanzhiwang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypetiaozhanzhiwang] autorelease]];
            }
        }
        
        
        int winNumber = [[JFLocalPlayer shareInstance] winNumber];
        if (winNumber >= 2)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeshirenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeshirenzhan] autorelease]];
            }
        }
        if (winNumber >= 4)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypebairenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypebairenzhan] autorelease]];
            }
        }
        if (winNumber >= 6)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeqianrenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeqianrenzhan] autorelease]];
            }
        }
    }
#else
    if (type == JFMedalModelGetTypeNormalMode)
    {
        int lastLevel = [[JFLocalPlayer shareInstance] lastLevel];
        if (lastLevel >= 10)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyucainiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyucainiao] autorelease]];
            }
        }
        if (lastLevel >= 50)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudaren])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudaren] autorelease]];
            }
        }
        if (lastLevel >= 200)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyugaoshou])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyugaoshou] autorelease]];
            }
        }
        if (lastLevel >= 500)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudashi])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudashi] autorelease]];
            }
        }
        
    }else
    {
        int maxconwinnumber = [[JFLocalPlayer shareInstance] maxConWinNumber];
        if (maxconwinnumber >= 5)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypezanlutoujiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypezanlutoujiao] autorelease]];
            }
        }
        if (maxconwinnumber >= 15)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypemingdongyifang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypemingdongyifang] autorelease]];
            }
        }
        if (maxconwinnumber >= 30)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypegaoshoujimo])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypegaoshoujimo] autorelease]];
            }
        }
        if (maxconwinnumber >= 50)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypetiaozhanzhiwang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypetiaozhanzhiwang] autorelease]];
            }
        }
        
        
        int winNumber = [[JFLocalPlayer shareInstance] winNumber];
        if (winNumber >= 10)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeshirenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeshirenzhan] autorelease]];
            }
        }
        if (winNumber >= 100)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypebairenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypebairenzhan] autorelease]];
            }
        }
        if (winNumber >= 1000)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeqianrenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeqianrenzhan] autorelease]];
            }
        }
    }
#endif*/
    
    
    
    if (type == JFMedalModelGetTypeNormalMode)
    {
        int lastLevel = [[JFLocalPlayer shareInstance] lastLevel];
        if (lastLevel >= 10)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyucainiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyucainiao] autorelease]];
            }
        }
        if (lastLevel >= 50)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudaren])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudaren] autorelease]];
            }
        }
        if (lastLevel >= 200)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyugaoshou])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyugaoshou] autorelease]];
            }
        }
        if (lastLevel >= 500)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypechengyudashi])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypechengyudashi] autorelease]];
            }
        }
        
    }else
    {
        int maxconwinnumber = [[JFLocalPlayer shareInstance] maxConWinNumber];
        if (maxconwinnumber >= 5)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypezanlutoujiao])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypezanlutoujiao] autorelease]];
            }
        }
        if (maxconwinnumber >= 15)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypemingdongyifang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypemingdongyifang] autorelease]];
            }
        }
        if (maxconwinnumber >= 30)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypegaoshoujimo])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypegaoshoujimo] autorelease]];
            }
        }
        if (maxconwinnumber >= 50)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypetiaozhanzhiwang])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypetiaozhanzhiwang] autorelease]];
            }
        }
        
        
        int winNumber = [[JFLocalPlayer shareInstance] winNumber];
        if (winNumber >= 10)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeshirenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeshirenzhan] autorelease]];
            }
        }
        if (winNumber >= 100)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypebairenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypebairenzhan] autorelease]];
            }
        }
        if (winNumber >= 1000)
        {
            if (![JFMedalModel GetUserisRewardedBytype:JFMedalModelTypeqianrenzhan])
            {
                [array addObject:[[[JFMedalModel alloc] initWithMedalType:JFMedalModelTypeqianrenzhan] autorelease]];
            }
        }
    }
    

    return array;
}

+(void)storeUserRewarded:(BOOL)bisreward type:(JFMedalModelType)type
{
    NSString    *strStorekey = [NSString stringWithFormat:@"%d%@medal",type,[[JFLocalPlayer shareInstance] userID]];
    [[NSUserDefaults standardUserDefaults] setValue:@(bisreward) forKey:strStorekey];
    BOOL bsuc =  [[NSUserDefaults standardUserDefaults] synchronize];
    if (!bsuc)
    {
        DLOG(@"storeUserRewarded fail:%d strStorekey:%@",bsuc,strStorekey);
    }else
    {
        DLOG(@"storeUserRewarded suc:%d strStorekey:%@",bsuc,strStorekey);
    }
}

+(BOOL)GetUserisRewardedBytype:(JFMedalModelType)type
{
    NSString    *strStorekey = [NSString stringWithFormat:@"%d%@medal",type,[[JFLocalPlayer shareInstance] userID]];
    BOOL  reward = [[[NSUserDefaults standardUserDefaults] valueForKey:strStorekey] boolValue];
    return reward;
}

-(id)initWithMedalType:(JFMedalModelType)type
{
    self = [super init];
    if (self)
    {
        self.medalType = type;
        
        switch (type)
        {
            case JFMedalModelTypebairenzhan:
                self.medalName = @"百人斩";
                self.medalDesription = @"竞赛模式击败一百个对手。";
                self.medalGrayNameImageName = @"medal_bairenzhan_namegray.png";
                self.medalNameImageName = @"medal_bairenzhan_name.png";
                self.medalNoticeTitleImageName = @"medal_bairenzhan_noticetitle.png";
                self.medalGrayImageName = @"medal_bairenzhan_imagegray.png";
                self.medalImageName = @"medal_bairenzhan_image.png";
                self.rewardGold = 200;
                break;
            case JFMedalModelTypeshirenzhan:
                self.medalName = @"十人斩";
                self.medalDesription = @"竞赛模式击败十个对手。";
                self.medalGrayNameImageName = @"medal_shirenzhan_namegray.png";
                self.medalNameImageName = @"medal_shirenzhan_name.png";
                self.medalNoticeTitleImageName = @"medal_shirenzhan_noticetitle.png";
                self.medalGrayImageName = @"medal_shirenzhan_imagegray.png";
                self.medalImageName = @"medal_shirenzhan_image.png";
                self.rewardGold = 100;
                
                break;
            case JFMedalModelTypeqianrenzhan:
                self.medalName = @"千人斩";
                self.medalDesription = @"竞赛模式击败一千个对手。";
                self.medalGrayNameImageName = @"medal_qianrenzhan_namegray.png";
                self.medalNameImageName = @"medal_qianrenzhan_name.png";
                self.medalNoticeTitleImageName = @"medal_qianrenzhan_noticetitle.png";
                self.medalGrayImageName = @"medal_qianrenzhan_imagegray.png";
                self.medalImageName = @"medal_qianrenzhan_image.png";
                self.rewardGold = 500;
                break;
            case JFMedalModelTypechengyucainiao:
                self.medalName = @"成语菜鸟";
                self.medalDesription = @"闯关模式完成10个小关卡。";
                self.medalGrayNameImageName = @"medal_chengyucainiao_namegray.png";
                self.medalNameImageName = @"medal_chengyucainiao_name.png";
                self.medalNoticeTitleImageName = @"medal_chengyucainiao_noticetitle.png";
                self.medalGrayImageName = @"medal_chengyucainiao_imagegray.png";
                self.medalImageName = @"medal_chengyucainiao_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypechengyudaren:
                self.medalName = @"成语达人";
                self.medalDesription = @"闯关模式完成50个小关卡。";
                self.medalGrayNameImageName = @"medal_chengyudaren_namegray.png";
                self.medalNameImageName = @"medal_chengyudaren_name.png";
                self.medalNoticeTitleImageName = @"medal_chengyudaren_noticetitle.png";
                self.medalGrayImageName = @"medal_chengyudaren_imagegray.png";
                self.medalImageName = @"medal_chengyudaren_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypechengyugaoshou:
                self.medalName = @"成语高手";
                self.medalDesription = @"闯关模式完成200个小关卡。";
                self.medalGrayNameImageName = @"medal_chengyugaoshou_namegray.png";
                self.medalNameImageName = @"medal_chengyugaoshou_name.png";
                self.medalNoticeTitleImageName = @"medal_chengyugaoshou_noticetitle.png";
                self.medalGrayImageName = @"medal_chengyugaoshou_imagegray.png";
                self.medalImageName = @"medal_chengyugaoshou_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypechengyudashi:
                self.medalName = @"成语大师";
                self.medalDesription = @"闯关模式完成500个小关卡。";
                self.medalGrayNameImageName = @"medal_chengyudashi_namegray.png";
                self.medalNameImageName = @"medal_chengyudashi_name.png";
                self.medalNoticeTitleImageName = @"medal_chengyudashi_noticetitle.png";
                self.medalGrayImageName = @"medal_chengyudashi_imagegray.png";
                self.medalImageName = @"medal_chengyudashi_image.png";
                self.rewardGold = 200;
                break;
            case JFMedalModelTypezanlutoujiao:
                self.medalName = @"崭露头角";
                self.medalDesription = @"竞赛达到5连胜。";
                self.medalGrayNameImageName = @"medal_zanlutoujiao_namegray.png";
                self.medalNameImageName = @"medal_zanlutoujiao_name.png";
                self.medalNoticeTitleImageName = @"medal_zanlutoujiao_noticetitle.png";
                self.medalGrayImageName = @"medal_zanlutoujiao_imagegray.png";
                self.medalImageName = @"medal_zanlutoujiao_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypemingdongyifang:
                self.medalName = @"名动一方";
                self.medalDesription = @"竞赛达到15连胜。";
                self.medalGrayNameImageName = @"medal_mingdongyifang_namegray.png";
                self.medalNameImageName = @"medal_mingdongyifang_name.png";
                self.medalNoticeTitleImageName = @"medal_mingdongyifang_noticetitle.png";
                self.medalGrayImageName = @"medal_mingdongyifang_imagegray.png";
                self.medalImageName = @"medal_mingdongyifang_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypegaoshoujimo:
                self.medalName = @"高手寂寞";
                self.medalDesription = @"竞赛达到30连胜。";
                self.medalGrayNameImageName = @"medal_gaoshoujimo_namegray.png";
                self.medalNameImageName = @"medal_gaoshoujimo_name.png";
                self.medalNoticeTitleImageName = @"medal_gaoshoujimo_noticetitle.png";
                self.medalGrayImageName = @"medal_gaoshoujimo_imagegray.png";
                self.medalImageName = @"medal_gaoshoujimo_image.png";
                self.rewardGold = 100;
                break;
            case JFMedalModelTypetiaozhanzhiwang:
                self.medalName = @"挑战之王";
                self.medalDesription = @"竞赛达到50连胜。";
                self.medalGrayNameImageName = @"medal_tiaozhanzhiwang_namegray.png";
                self.medalNameImageName = @"medal_tiaozhanzhiwang_name.png";
                self.medalNoticeTitleImageName = @"medal_tiaozhanzhiwang_noticetitle.png";
                self.medalGrayImageName = @"medal_tiaozhanzhiwang_imagegray.png";
                self.medalImageName = @"medal_tiaozhanzhiwang_image.png";
                self.rewardGold = 200;
                break;
                
            default:
                break;
        }
        
        
        self.isRewarded = [JFMedalModel GetUserisRewardedBytype:self.medalType];
        
    }

    return self;
}

-(void)dealloc
{
    self.medalDesription = nil;
    self.medalGrayImageName = nil;
    self.medalGrayNameImageName = nil;
    self.medalImageName = nil;
    self.medalName = nil;
    self.medalNameImageName = nil;
    self.medalNoticeTitleImageName = nil;
    [super dealloc];
}
@end
