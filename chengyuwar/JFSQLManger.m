//
//  JFSQLManger.m
//  chengyuwar
//
//  Created by ran on 13-12-18.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFSQLManger.h"
#import "JFIdiomModel.h"
#import "JFDownUrlModel.h"
#import "JFPhaseXmlData.h"
#import "UtilitiesFunction.h"

@implementation JFSQLManger
+(void)CreateDataTable
{
    [[SQLOperation sharedSQLOperation] createTable];
    //[JFSQLManger testUserInfo];
}

+(void)testUserInfo
{
  
   // NSMutableArray  *array = [NSMutableArray array];
    NSMutableArray  *array  =   [[SQLOperation sharedSQLOperation] queryUserInfoByUserID:10010];
    
    if (![array count])
    {
        [[SQLOperation sharedSQLOperation] insertToUSERINFO:@"10010" userIDType:1 lastLogintime:@"1234567890" nickName:@"你是我的缘" roletype:0 winConut:100 losecount:2 goldNumber:99999 score:56 maxconwinnumber:60 gamecenterID:@"我是一个人" gameCenterDisplayName:@"费单号给" LastBeatleatLevel:12  ispayedUser:0];
        
    }
    
    NSMutableArray  *arrayIdiom = [[SQLOperation sharedSQLOperation] queryIdiomInfoAccordType:1 userID:@"10010"];
    if (![arrayIdiom count])
    {
        for (int i = 0; i < 100; i++)
        {
            [[SQLOperation sharedSQLOperation] insertToIdiom:1 secondIndex:2 levelIndex:i+1 answer:@"王八是你" optionStr:@"王八是你我是一只小小看怎么非也飞不高好人一生平安" IsAnswer:0 Type:1 explain:@"王八是你我是一只小小鸟怎么非也飞不高好人一生平安王八是你我是一只小小鸟怎么非也飞不高好人一生平安王八是你我是一只小小鸟怎么非也飞不高好人一生平安王八是你我是一只小小鸟怎么非也飞不高好人一生平安" source:@"王八是你我是一只小小鸟怎么非也飞不高好人一生平安" picName:@"123.png" isUnlock:NO userID:@"10010"];
        }
        [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:1 isUnlocked:YES userID:@"10010"];
        
        
    }
    DLOG(@"testUserInfo:%@",array);
}


+(void)UpdateUserInfoToDB:(JFLocalPlayer*)player
{
    if (!player.userID  || [player.userID length] < 1)
    {
        
        DLOG(@"UpdateUserInfo fail:%@",player);
        return;
    }
    
    NSMutableArray  *array  =   [[SQLOperation sharedSQLOperation] queryUserInfoByUserID:[player.userID intValue]];
    
    if (![array count])
    {
        
        NSTimeInterval  timer = [[NSDate date] timeIntervalSince1970];
        [[SQLOperation sharedSQLOperation] insertToUSERINFO:player.userID userIDType:0 lastLogintime:[NSString stringWithFormat:@"%0.0f",timer] nickName:player.nickName    roletype:1 winConut:player.winNumber losecount:player.loseNumber goldNumber:player.goldNumber score:player.score maxconwinnumber:player.maxConWinNumber gamecenterID:[player.GamePlayerInfo valueForKey:@"playerID"] gameCenterDisplayName:[player.GamePlayerInfo valueForKey:@"displayName"] LastBeatleatLevel:player.lastLevel ispayedUser:player.isPayedUser];
        
    }else
    {
        NSTimeInterval  timer = [[NSDate date] timeIntervalSince1970];
        [[SQLOperation sharedSQLOperation] UpdateUSERINFO:player.userID userIDType:0 lastLogintime:[NSString stringWithFormat:@"%0.0f",timer] nickName:player.nickName    roletype:1 winConut:player.winNumber losecount:player.loseNumber goldNumber:player.goldNumber score:player.score maxconwinnumber:player.maxConWinNumber gamecenterID:[player.GamePlayerInfo valueForKey:@"playerID"] gameCenterDisplayName:[player.GamePlayerInfo valueForKey:@"displayName"] LastBeatleatLevel:player.lastLevel isPayed:player.isPayedUser];
        
    }
    
}

+(void)updateUserGoldNumberToDB:(int)goldNumber playerID:(NSString*)userID
{
    [[SQLOperation sharedSQLOperation] UpdateUSERINFO:userID GoldNumber:goldNumber];
}
+(void)updateUserLevelNumberToDB:(int)goldNumber playerID:(NSString*)userID
{
    
    [[SQLOperation sharedSQLOperation] UpdateUSERINFO:userID levelNumber:goldNumber];
}


+(BOOL)getDataForUserInfoFromDB:(JFLocalPlayer*)player
{
    NSMutableArray  *array  =   [[SQLOperation sharedSQLOperation] queryAllUserInfo];
    
    
    //     NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@(userIDType),@"userIDType",lastLogintime,@"lastLogintime",nickName,@"nickName",@(roleType),@"roleType",@(wincount),@"wincount",@(losecount),@"losecount",@(goldnumber),@"goldnumber",@(score),@"score",@(maxconwinnumber),@"maxconwinnumber",GameCenterID,@"GameCenterID",gamedisplayname,@"gamedisplayname",@(lastBeatLevel),@"lastBeatLevel",nil];
    if (![array count])
    {
        DLOG(@"user has no data");
        return NO;
    }
    
    NSDictionary  *dicTemp = nil;
    
    for (NSDictionary  *dicinfo in array)
    {
        if ([[dicinfo valueForKey:@"userID"] isEqualToString:player.userID])
        {
            dicTemp =dicinfo;
            break;
            
        }
        
    }
    
    if (dicTemp == nil)
    {
       dicTemp = [array objectAtIndex:0];
    }
   
    player.userID = [dicTemp valueForKey:@"userID"];
    player.goldNumber = [[dicTemp valueForKey:@"goldnumber"] intValue];
    player.nickName = [dicTemp valueForKey:@"nickName"];
    player.winNumber = [[dicTemp valueForKey:@"wincount"] intValue];
    player.loseNumber = [[dicTemp valueForKey:@"losecount"] intValue];
    player.score = [[dicTemp valueForKey:@"score"] intValue];
    player.maxConWinNumber = [[dicTemp valueForKey:@"maxconwinnumber"] intValue];
    player.lastLevel = [[dicTemp valueForKey:@"lastBeatLevel"] intValue];
    player.isPayedUser = [[dicTemp valueForKey:@"ispayed"] intValue];
    NSDictionary  *dicgameInfo = [NSDictionary dictionaryWithObjectsAndKeys:[dicTemp valueForKey:@"GameCenterID"],@"playerID",[dicTemp valueForKey:@"displayName"],@"displayName",nil];
    player.GamePlayerInfo = dicgameInfo;
    
    return YES;
}


// NSDictionary *infoDic = [NSDictionary dictionaryWithObjectsAndKeys:@(packgeindex),@"packgeindex",@(secondIndex),@"secondIndex",@(levelIndex),@"levelIndex",idiomAnswer,@"idiomAnswer",idiomOptstr,@"idiomOptstr",@(isAnswer),@"isAnswer",@(ididomType),@"ididomType",idiomExplain,@"idiomExplain",idiomSorce,@"idiomSorce",nil];
+(NSMutableArray*)getAllIdiomInfo:(JFIdiomType)type
{
    NSMutableArray  *arrayInfo = [[SQLOperation sharedSQLOperation] queryIdiomInfoAccordType:type userID:[[JFLocalPlayer shareInstance] userID]];
    NSMutableArray  *arrayModel = [NSMutableArray array];
    
    for (NSDictionary *dicInfo  in arrayInfo)
    {
        JFIdiomModel    *model = [[JFIdiomModel alloc] init];
        
        model.idiomAnswer = [dicInfo valueForKey:@"idiomAnswer"];
        model.idiomDespcription = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomImageName = [dicInfo valueForKey:@"idiomPicName"];
        model.idiomlevelString = [dicInfo valueForKey:@"levelIndex"];
        model.idiomOptionstr = [dicInfo valueForKey:@"idiomOptstr"];
        model.isAnswed = [[dicInfo valueForKey:@"isAnswer"] boolValue];
        model.packageIndex = [[dicInfo valueForKey:@"packgeindex"] intValue];
        model.index = [[dicInfo valueForKey:@"secondIndex"] intValue];
        model.isUnlocked = [[dicInfo valueForKey:@"isUnlocked"] boolValue];
        model.idiomExplain = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomFrom = [dicInfo valueForKey:@"idiomFrom"];
        
        [arrayModel addObject:model];
        [model release];
        
        
       // DLOG(@"level:%d isanswer:%d isunlocked:%d",[model.idiomlevelString intValue],model.isAnswed,model.isUnlocked);
    }
    
 //   DLOG(@"getAllIdiomInfo:%@",arrayModel);
    return arrayModel;
    
}


+(NSMutableArray*)getAllIdiomInfo:(JFIdiomType)type  userID:(NSString*)userID
{
    NSMutableArray  *arrayInfo = [[SQLOperation sharedSQLOperation] queryIdiomInfoAccordType:type userID:userID];
    NSMutableArray  *arrayModel = [NSMutableArray array];
    
    for (NSDictionary *dicInfo  in arrayInfo)
    {
        JFIdiomModel    *model = [[JFIdiomModel alloc] init];
        
        model.idiomAnswer = [dicInfo valueForKey:@"idiomAnswer"];
        model.idiomDespcription = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomImageName = [dicInfo valueForKey:@"idiomPicName"];
        model.idiomlevelString = [dicInfo valueForKey:@"levelIndex"];
        model.idiomOptionstr = [dicInfo valueForKey:@"idiomOptstr"];
        model.isAnswed = [[dicInfo valueForKey:@"isAnswer"] boolValue];
        model.packageIndex = [[dicInfo valueForKey:@"packgeindex"] intValue];
        model.index = [[dicInfo valueForKey:@"secondIndex"] intValue];
        model.isUnlocked = [[dicInfo valueForKey:@"isUnlocked"] boolValue];
        model.idiomExplain = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomFrom = [dicInfo valueForKey:@"idiomFrom"];
        
        [arrayModel addObject:model];
        [model release];
        
        
        // DLOG(@"level:%d isanswer:%d isunlocked:%d",[model.idiomlevelString intValue],model.isAnswed,model.isUnlocked);
    }
    
    //   DLOG(@"getAllIdiomInfo:%@",arrayModel);
    return arrayModel;
    
}


+(int)getAllIdiomCountAccordTypeFromSql:(JFIdiomType)type
{
    int count = 0;
    if (type == JFIdiomTypeNormal)
    {
        count = [[SQLOperation sharedSQLOperation] queryIdiomCountAccordType:1 userID:[[JFLocalPlayer shareInstance] userID]];
    }else
    {
        count = [[SQLOperation sharedSQLOperation] queryIdiomCountAccordType:2 userID:nil];
    }
    
    DLOG(@"getAllIdiomCountAccordType:type%d %d",type,count);
    return count;
}


+(id)getIdiomInfoAccordLevelIndex:(int)levelIndex
{
    NSMutableArray  *arrayInfo = [[SQLOperation sharedSQLOperation] queryIdiomInfoAccordLevelIndex:levelIndex userID:[[JFLocalPlayer shareInstance] userID]];
    NSMutableArray  *arrayModel = [NSMutableArray array];
    
    for (NSDictionary *dicInfo  in arrayInfo)
    {
        JFIdiomModel    *model = [[JFIdiomModel alloc] init];
        
        model.idiomAnswer = [dicInfo valueForKey:@"idiomAnswer"];
        model.idiomDespcription = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomExplain = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomFrom = [dicInfo valueForKey:@"idiomFrom"];
        model.idiomImageName = [dicInfo valueForKey:@"idiomPicName"];
        model.idiomlevelString = [dicInfo valueForKey:@"levelIndex"];
        model.idiomOptionstr = [dicInfo valueForKey:@"idiomOptstr"];
        model.isAnswed = [[dicInfo valueForKey:@"isAnswer"] boolValue];
        model.packageIndex = [[dicInfo valueForKey:@"packgeindex"] intValue];
        model.index = [[dicInfo valueForKey:@"secondIndex"] intValue];
        model.isUnlocked = [[dicInfo valueForKey:@"isUnlocked"] boolValue];
        [arrayModel addObject:model];
        [model release];
    }
    
 //   DLOG(@"getIdiomInfoAccordLevelIndex:%@",arrayModel);
    if ([arrayModel count])
    {
        return [arrayModel objectAtIndex:0];
    }
    
    return nil;
}

+(id)getIdiomAccordPackage:(int)packageindex secondeIndex:(int)secondIndex
{
    NSMutableArray  *arrayInfo = [[SQLOperation sharedSQLOperation] queryIdiomInfoAccordpackageIndex:packageindex secondIndex:secondIndex];
    NSMutableArray  *arrayModel = [NSMutableArray array];
    
    for (NSDictionary *dicInfo  in arrayInfo)
    {
        JFIdiomModel    *model = [[JFIdiomModel alloc] init];
        
        model.idiomAnswer = [dicInfo valueForKey:@"idiomAnswer"];
        model.idiomDespcription = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomExplain = [dicInfo valueForKey:@"idiomExplain"];
        model.idiomFrom = [dicInfo valueForKey:@"idiomFrom"];
        model.idiomImageName = [dicInfo valueForKey:@"idiomPicName"];
        model.idiomlevelString = [dicInfo valueForKey:@"levelIndex"];
        model.idiomOptionstr = [dicInfo valueForKey:@"idiomOptstr"];
        model.isAnswed = [[dicInfo valueForKey:@"isAnswer"] boolValue];
        model.packageIndex = [[dicInfo valueForKey:@"packgeindex"] intValue];
        model.index = [[dicInfo valueForKey:@"secondIndex"] intValue];
        model.isUnlocked = [[dicInfo valueForKey:@"isUnlocked"] boolValue];
        [arrayModel addObject:model];
        [model release];
    }
    
 //   DLOG(@"getIdiomInfoAccordLevelIndex:%@",arrayModel);
    if ([arrayModel count])
    {
        return [arrayModel objectAtIndex:0];
    }
    
    return nil;
    
}

+(void)setLevelAnswerAndUnlocked:(int)level
{
    [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:level isAnswer:YES userID:[[JFLocalPlayer shareInstance] userID]];
}
+(void)setLevelUnlocked:(int)level
{
    [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:level isUnlocked:YES userID:[[JFLocalPlayer shareInstance] userID]];
}


+(NSString*)getUserIDAccordGameCenterInfo:(NSString*)gamecterID
{
    return [[SQLOperation sharedSQLOperation] queryUserAccordGameCenteID:gamecterID];
}
+(BOOL)updateGameCenterLoginInfo:(NSString*)gameCenterID userID:(NSString*)userID
{
    
    NSString    *queryID = [[SQLOperation sharedSQLOperation] queryUserAccordGameCenteID:gameCenterID];
    if ([userID intValue] <= 0)
    {
        return NO;
        DLOG(@"updateGameCenterLoginInfo fail");
    }else
    {
        if ([queryID intValue] > 0)
        {
             [[SQLOperation sharedSQLOperation] UpdateLoginTime:gameCenterID];
        }else
        {
            [[SQLOperation sharedSQLOperation] insertGameCenterID:gameCenterID userID:userID];
        }
        return YES;
    }
}






+(void)insertIdiomTotable:(JFIdiomModel*)idiomModel type:(JFIdiomType)type
{
    idiomModel.idiomExplain = [idiomModel.idiomExplain stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    idiomModel.idiomFrom = [idiomModel.idiomFrom stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    idiomModel.idiomAnswer = [idiomModel.idiomAnswer stringByReplacingOccurrencesOfString:@"'" withString:@"‘"];
    
    if (type == JFIdiomTypeNormal)
    {
        JFIdiomModel    *dataModel =  nil;//[JFSQLManger getIdiomInfoAccordLevelIndex:[idiomModel.idiomlevelString intValue]];
        
        if (!dataModel)
        {
            [[SQLOperation sharedSQLOperation] insertToIdiom:idiomModel.packageIndex secondIndex:idiomModel.index levelIndex:[idiomModel.idiomlevelString intValue] answer:idiomModel.idiomAnswer optionStr:idiomModel.idiomOptionstr IsAnswer:idiomModel.isAnswed Type:idiomModel.type explain:idiomModel.idiomExplain source:idiomModel.idiomFrom picName:idiomModel.idiomImageName isUnlock:idiomModel.isUnlocked userID:[[JFLocalPlayer shareInstance] userID]];
  
        }else
        {
            [[SQLOperation sharedSQLOperation] UpdateIdiom:idiomModel.packageIndex secondIndex:idiomModel.index levelIndex:[idiomModel.idiomlevelString intValue] answer:idiomModel.idiomAnswer optionStr:idiomModel.idiomOptionstr IsAnswer:dataModel.isAnswed Type:idiomModel.type explain:idiomModel.idiomExplain source:idiomModel.idiomFrom picName:idiomModel.idiomImageName isUnlock:dataModel.isUnlocked userID:[[JFLocalPlayer shareInstance] userID]];
        }
        
    }else
    {
        
        JFIdiomModel    *model = [JFSQLManger getIdiomAccordPackage:idiomModel.packageIndex secondeIndex:idiomModel.index];
        if (!model)
        {
           // DLOG(@"insertIdiomTotable:%@",idiomModel);
            [[SQLOperation sharedSQLOperation] insertToIdiom:idiomModel.packageIndex secondIndex:idiomModel.index levelIndex:[idiomModel.idiomlevelString intValue] answer:idiomModel.idiomAnswer optionStr:idiomModel.idiomOptionstr IsAnswer:idiomModel.isAnswed Type:idiomModel.type explain:idiomModel.idiomExplain source:idiomModel.idiomFrom picName:idiomModel.idiomImageName isUnlock:idiomModel.isUnlocked userID:[[JFLocalPlayer shareInstance] userID]];
        }
    
        
    }
    
}


+(void)deleteAllItiomAccordType:(JFIdiomType)type
{
     NSString  *userid = [[JFLocalPlayer shareInstance] userID];
     [[SQLOperation sharedSQLOperation] DeleteAllIdiomAccorduserID:userid type:type];
}

+(void)resetNormalLevelInfo
{
    NSMutableArray  *array = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal];
    NSString  *userid = [[JFLocalPlayer shareInstance] userID];
    for (JFIdiomModel *idiomModel in array)
    {
        int lelev = [idiomModel.idiomlevelString intValue];
        //DLOG(@"idiomModel:%@",idiomModel);
        if (lelev <= array.count)
        {
            if (lelev == 1)
            {
                [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:lelev isAnswer:0 isunlock:1 userID:userid];
            }else
            {
                [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:lelev isAnswer:0 isunlock:0 userID:userid];
                //[[SQLOperation sharedSQLOperation] UpdateIdiomLevel:lelev isAnswer:NO userID:userid];
              //  [[SQLOperation sharedSQLOperation] UpdateIdiomLevel:lelev isUnlocked:NO userID:userid];
            }
            
        }else
        {
             [[SQLOperation sharedSQLOperation] DeleteIdiomAccordLevel:lelev userID:userid type:JFIdiomTypeNormal];
        }
        
    }
    
}



+(void)insertDataToSQLForRace
{
    
    
    if ([JFPhaseXmlData getAllIdiomCountFromDownloadFiles] <= [JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeRace])
    {
        DLOG(@"insertDataToSQLForRace return");
        return;
    }
    
    

    NSMutableArray  *arraySQL = [JFSQLManger getAllIdiomInfo:JFIdiomTypeRace];
    
    NSMutableArray  *arrayAll = [NSMutableArray array];
    
    
    NSMutableArray  *arrZip = [JFPhaseXmlData phaseUrlInfoAccordPath:[UtilitiesFunction getNormalXmlPath:DOWNXMLFILENAME] xmlType:JFPhaseXmlDataTypeNormalXml rootPath:nil];
    for (JFDownUrlModel *model in arrZip)
    {
        NSMutableArray  *arrayTemp = [JFPhaseXmlData phaseUrlInfoAccordPath:[[UtilitiesFunction getNormalQustionZip:model.md5String] stringByAppendingPathComponent:DOWNDEScription] xmlType:JFPhaseXmlDataTypeNormalIdiom rootPath:[UtilitiesFunction getNormalQustionZip:model.md5String]];
        [arrayAll addObjectsFromArray:arrayTemp];
    }
    
   
    
    for (JFIdiomModel  *idiomModel in arrayAll)
    {
        if (![JFSQLManger checkHasSameModel:idiomModel inarray:arraySQL])
        {
            idiomModel.idiomlevelString = @"-1";
            idiomModel.type = JFIdiomTypeRace;
            
            [JFSQLManger insertIdiomTotable:idiomModel type:JFIdiomTypeRace];
        }
    }

    
}


+(BOOL)checkHasSameModel:(JFIdiomModel*)Tempmodel inarray:(NSMutableArray*)array
{
    for (JFIdiomModel  *temp in array)
    {
        if (temp.index == Tempmodel.index && Tempmodel.packageIndex == temp.packageIndex)
        {
            return YES;
        }
    }
    return NO;
}

+(void)UpdateUndealchargeInfo:(NSString*)payID channelID:(int)chanelID  orderReceipt:(NSString*)receipt
{
    NSString  *userID = [[JFLocalPlayer shareInstance] userID];
    if (chanelID <= 0)
    {
        chanelID = 400;
    }
    NSMutableArray  *arrHas = [[SQLOperation sharedSQLOperation] queryAllUnchargeInfobyUserID:userID andPayID:payID];
    if (![arrHas count])
    {
        [[SQLOperation sharedSQLOperation] inserchargeUnDealTable:userID PayID:payID ChanelID:chanelID receipt:receipt];
    }else
    {
        [[SQLOperation sharedSQLOperation] UpdatechargeUnDealTable:userID PayID:payID ChanelID:chanelID receipt:receipt];
    }
    
}
+(BOOL)isHasUnDealChargeinfo
{
     NSString  *userID = [[JFLocalPlayer shareInstance] userID];
    return [[SQLOperation sharedSQLOperation] queryIsHasUnchargeInfo:userID];
}

+(NSDictionary*)getUndealChargeInfoAccordbyPayID:(NSString*)payID
{
    NSString  *userID = [[JFLocalPlayer shareInstance] userID];
    NSMutableArray  *array = [[SQLOperation sharedSQLOperation] queryAllUnchargeInfobyUserID:userID andPayID:payID];
    if ([array count])
    {
        return [array objectAtIndex:0];
    }
    
    return nil;
}
+(NSDictionary*)getUndealChargeInfoAccordbyUserID
{
    NSString  *userID = [[JFLocalPlayer shareInstance] userID];
    NSMutableArray  *array = [[SQLOperation sharedSQLOperation] queryAllUnchargeInfobyUserID:userID];
    if ([array count])
    {
        return [array objectAtIndex:0];
    }
    
    return nil;
}
+(void)deleteInfoByPayID:(NSString*)payId
{
    [[SQLOperation sharedSQLOperation] deleteUndealInfoByPayID:payId];
}

+(int)getIdiomCountAccordIdiomModel:(JFIdiomModel*)idiomModel type:(JFIdiomType)type
{
    return [[SQLOperation sharedSQLOperation] queryIdiomCountAccordType:type userID:[[JFLocalPlayer shareInstance] userID] index:idiomModel.index packageIndex:idiomModel.packageIndex];
}

+(BOOL)levelIsPurchased:(int)level
{
    return [[SQLOperation sharedSQLOperation] queryLevelIspurchased:level];
}


+(void)updatePuchased:(int)isPurchased accordLevel:(int)level
{
    BOOL  bhasinfo = [[SQLOperation sharedSQLOperation] queryhasLevelpurchasedinfo:level];
    if (!bhasinfo)
    {
        [[SQLOperation sharedSQLOperation] insertToUnlockPurchaseTableLevel:level ispurchade:isPurchased];
    }else
    {
        [[SQLOperation sharedSQLOperation] UpdateUnlockPurchaseTableAccordLevel:level ispurchade:isPurchased];
    }
}


+(void)setIdiomInfoFromZeroToNowUser:(JFLocalPlayer*)player
{
    int count = [JFSQLManger getAllIdiomCountAccordTypeFromSql:JFIdiomTypeNormal];
    if (count)
    {
        return;
    }
    NSMutableArray  *array = [JFSQLManger getAllIdiomInfo:JFIdiomTypeNormal userID:@"0"];
    if ([array count])
    {
        DLOG(@"setIdiomInfoFromZeroToNowUser:%d",[array count]);
        for (JFIdiomModel * model in array)
        {
             [JFSQLManger insertIdiomTotable:model type:JFIdiomTypeNormal];
        }
       
    }
}
@end
