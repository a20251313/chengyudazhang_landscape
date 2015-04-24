//
//  JFChargeNet.h
//  chengyuwar
//
//  Created by ran on 14-1-2.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RechargeHTTPRequestManger.h"
#import "JFChargeProductModel.h"
#import "InAppPurchaseManager.h"


@protocol JFChargeNetDelegate <NSObject>

@optional
-(void)getPayIDFail:(NSDictionary*)dicInfo;
-(void)chargeGoldSuc:(JFChargeProductModel*)model;
-(void)chargeGoldFail:(int )status;
-(void)getServerRemainChargeFail:(int)status;
-(void)getServerRemainChargeSuc:(int)goldNum isFirstCharge:(BOOL)isfirstCharge;
-(void)getShopListInAppStoreSuccess:(id)thread;
-(void)getShopListInAppStoreFail:(id)Thread;
@optional
-(void)networkOccurError:(NSString*)statusCode;
@end
@interface JFChargeNet : NSObject<RechargeHTTPRequestMangerDelegate,InAppPurchaseManagerDelegate,JFChargeNetDelegate>
{
    id<JFChargeNetDelegate> deleagte;
    
    RechargeHTTPRequestManger   *m_httpsManger;
}
@property(nonatomic,assign)id<JFChargeNetDelegate> delegate;
@property(nonatomic,retain)JFChargeProductModel *chargemodel;
@property(nonatomic,copy)NSString   *payID;
@property(nonatomic,copy)NSString   *channelID;
@property(nonatomic,copy)NSString   *receipt;

-(void)requestChanel:(JFChargeProductModel*)tempchargeModel;
-(void)requestChargeResult:(JFChargeProductModel*)model order:(NSString*)orderReceipt;
-(void)requestChargeResultWithPayID:(NSString*)strpayID chanelID:(int)mychannelID;
@end
