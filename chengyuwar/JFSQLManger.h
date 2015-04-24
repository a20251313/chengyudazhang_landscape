//
//  JFSQLManger.h
//  chengyuwar
//
//  Created by ran on 13-12-18.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLOperation.h"
#import "JFLocalPlayer.h"
#import "JFIdiomModel.h"




@interface JFSQLManger : NSObject


+(void)CreateDataTable;
+(void)UpdateUserInfoToDB:(JFLocalPlayer*)player;
+(BOOL)getDataForUserInfoFromDB:(JFLocalPlayer*)player;
+(void)updateUserGoldNumberToDB:(int)goldNumber playerID:(NSString*)userID;
+(void)updateUserLevelNumberToDB:(int)goldNumber playerID:(NSString*)userID;

//


+(NSMutableArray*)getAllIdiomInfo:(JFIdiomType)type;
+(id)getIdiomInfoAccordLevelIndex:(int)levelIndex;
+(void)setLevelAnswerAndUnlocked:(int)level;
+(void)setLevelUnlocked:(int)level;
+(void)insertIdiomTotable:(JFIdiomModel*)idiomModel type:(JFIdiomType)type;
+(id)getIdiomAccordPackage:(int)packageindex secondeIndex:(int)secondIndex;
+(int)getAllIdiomCountAccordTypeFromSql:(JFIdiomType)type;
+(void)resetNormalLevelInfo;
+(void)deleteAllItiomAccordType:(JFIdiomType)type;
+(int)getIdiomCountAccordIdiomModel:(JFIdiomModel*)idiomModel type:(JFIdiomType)type;
//
+(NSString*)getUserIDAccordGameCenterInfo:(NSString*)gamecterID;
+(BOOL)updateGameCenterLoginInfo:(NSString*)gameCenterID userID:(NSString*)userID;





//
+(void)insertDataToSQLForRace;


//
+(void)UpdateUndealchargeInfo:(NSString*)payID channelID:(int)chanelID  orderReceipt:(NSString*)receipt;
+(BOOL)isHasUnDealChargeinfo;
+(NSDictionary*)getUndealChargeInfoAccordbyPayID:(NSString*)payID;
+(void)deleteInfoByPayID:(NSString*)payId;
+(NSDictionary*)getUndealChargeInfoAccordbyUserID;

+(BOOL)levelIsPurchased:(int)level;
+(void)updatePuchased:(int)isPurchased accordLevel:(int)level;
@end
