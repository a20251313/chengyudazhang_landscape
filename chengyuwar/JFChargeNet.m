//
//  JFChargeNet.m
//  chengyuwar
//
//  Created by ran on 14-1-2.
//  Copyright (c) 2014年 com.lelechat.chengyuwar. All rights reserved.
//

#import "JFChargeNet.h"
#import "JFLocalPlayer.h"
#import "InAppPurchaseManager.h"
#import "JFSQLManger.h"



NSString    *const      BNRChargeSuc = @"BNRChargeSuc";
@implementation JFChargeNet
@synthesize delegate;
@synthesize chargemodel;
@synthesize payID;
@synthesize channelID;
@synthesize receipt;


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.chargemodel = nil;
    self.payID = nil;
    self.channelID = nil;
    self.receipt = nil;
    DLOG(@"JFChargeNet dealloc");
    [super dealloc];
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [[InAppPurchaseManager sharedAppPurchase] setDelegate:self];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"faliedTransaction" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(failTransaction:)
                                                     name:@"faliedTransaction" object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GetShopListInAppStoreSuccess" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopListInAppStoreSuccess:)
                                                     name:@"GetShopListInAppStoreSuccess" object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"GetShopListInAppStoreFail" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getShopListInAppStoreFail:)
                                                     name:@"GetShopListInAppStoreFail" object:nil];
        
    }
    return self;
}


-(void)cleanChargeInfo
{
 
    if (self.payID)
    {
        [JFSQLManger deleteInfoByPayID:self.payID];
    }
}
-(void)storeChareInfo
{
    if (self.payID)
    {
        [JFSQLManger UpdateUndealchargeInfo:payID channelID:[self.channelID intValue] orderReceipt:self.receipt];
    }
    
}
-(void)failTransaction:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(chargeGoldFail:)])
    {
        [delegate chargeGoldFail:0];
    }
    [self cleanChargeInfo];
}

-(void)getShopListInAppStoreSuccess:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(getShopListInAppStoreSuccess:)])
    {
        [delegate getShopListInAppStoreSuccess:note];
    }

}
-(void)getShopListInAppStoreFail:(NSNotification*)note
{
    if (delegate && [delegate respondsToSelector:@selector(getShopListInAppStoreFail:)])
    {
        [delegate getShopListInAppStoreFail:[[note userInfo] valueForKey:@"error"]];
    }
    [self cleanChargeInfo];
}
/**
 *  设置充值乐豆的产品id
 */
- (NSString*)getProductSerialNumber:(int)charge_Amount
{
    /*
     unsigned char number[24] = {0};
     
     NSLog(@"%s", number);
     
     number[0] = '0';
     number[1] = '0';
     number[2] = 'I';
     number[3] = 'D';
     number[4] = 'O';
     number[5] = 'U';
     number[6] = '0';
     number[7] = '0';
     number[8] = '0';
     number[9] = '0';
     number[10] = '0';
     number[11] = '0';
     number[12] = '0';
     number[13] = '0';
     number[14] = '0';
     number[15] = '0';
     number[16] = '0';
     number[17] = '0';
     number[18] = '0';
     number[19] = '0';
     number[20] = '0';
     number[20] = '3';
     number[21] = '0';
     number[22] = '0';
     number[23] = '0';
     */
    NSString *amount = [NSString stringWithFormat:@"%d", (int)(charge_Amount)];
    NSMutableString *string = [self formatValue:0 forDigits:24];
    [string replaceCharactersInRange:NSMakeRange(2, 4) withString:@"IDOU"];
    [string replaceCharactersInRange:NSMakeRange(24-[amount length], [amount length]) withString:amount];

    return string;
}

/**
 *  设置充值乐豆的产品id
 */
- (NSString*)getProductSerialNumber:(int)charge_Amount  type:(int)type
{
    /*
     unsigned char number[24] = {0};
     
     NSLog(@"%s", number);
     
     number[0] = '0';
     number[1] = '0';
     number[2] = 'I';
     number[3] = 'D';
     number[4] = 'O';
     number[5] = 'U';
     number[6] = '0';
     number[7] = '0';
     number[8] = '0';
     number[9] = '0';
     number[10] = '0';
     number[11] = '0';
     number[12] = '0';
     number[13] = '0';
     number[14] = '0';
     number[15] = '0';
     number[16] = '0';
     number[17] = '0';
     number[18] = '0';
     number[19] = '0';
     number[20] = '0';
     number[20] = '3';
     number[21] = '0';
     number[22] = '0';
     number[23] = '0';
     */
    NSString *amount = [NSString stringWithFormat:@"%d", (int)(charge_Amount)];
    NSMutableString *string = [self formatValue:0 forDigits:24];
    [string replaceCharactersInRange:NSMakeRange(2, 4) withString:@"IDOU"];
    [string replaceCharactersInRange:NSMakeRange(24-[amount length], [amount length]) withString:amount];
    NSString *strtype = [NSString stringWithFormat:@"%06d",type];
    [string replaceCharactersInRange:NSMakeRange(6, 6) withString:strtype];
    
    return string;
}
- (NSMutableString*)formatValue:(int)value forDigits:(int)zeros
{
    NSMutableString * format = [NSMutableString stringWithFormat:@"%%0%dd", zeros];
    return [NSMutableString stringWithFormat:format,value];
}

-(void)requestChargeResult:(JFChargeProductModel*)model order:(NSString*)orderReceipt
{
    
    if (self.payID && model)
    {
        //  self.chargemodel = model;
        NSString *userID = [[JFLocalPlayer shareInstance] userID];
        int platform = CLIENT_PLATFORM;
        int customID = 0;
        int clientVersion = APP_VERSION;
        int amount = chargemodel.productMoney*100;
         NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.channelID,@"recharge_channel",userID,@"user_id",self.payID,@"payid",@(platform),@"platform",@(customID),@"custom_id",@(clientVersion),@"client_ver",@(amount),@"order_amount",orderReceipt,@"receipt",model.chargedescription,@"order_description",nil];
        
        if (!m_httpsManger)
        {
            m_httpsManger = [[RechargeHTTPRequestManger alloc] init];
            m_httpsManger.delegate = self;
        }
        [m_httpsManger startRequestData:dicInfo requestURL:@"recharge_request"];

        
        DLOG(@"requestChargeResult:%@",payID);
    }else
    {
        DLOG(@"requestChargeResult fail :%@\n%@",self.payID,model);
    }
}


-(void)requestChargeResultWithPayID:(NSString*)strpayID chanelID:(int)mychannelID
{
    
    if (mychannelID == 0)
    {
        mychannelID = 400;
    }
    self.channelID = [NSString stringWithFormat:@"%d",mychannelID];
    self.payID = strpayID;
    NSString *userID = [[JFLocalPlayer shareInstance] userID];
    NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id",@(mychannelID),@"recharge_channel",strpayID,@"payid",nil];
    
    
    if (!m_httpsManger)
    {
        m_httpsManger = [[RechargeHTTPRequestManger alloc] init];
        m_httpsManger.delegate = self;
    }

    [m_httpsManger startRequestData:dicInfo requestURL:@"get_recharge_result"];

    DLOG(@"requestChargeResult:%@",dicInfo);
}



-(void)requestChanel:(JFChargeProductModel*)tempchargeModel
{
    self.chargemodel = tempchargeModel;
    NSString *userID = [[JFLocalPlayer shareInstance] userID];
    int platform = CLIENT_PLATFORM;
    int customID = 0;
    int clientVersion = APP_VERSION;
    int amount = chargemodel.productMoney*100;
    int jailBreak = 0;
    NSString   *stringSN  = nil;
    if (tempchargeModel.productType != JFChargeProductModelTypeDefault)
    {
        stringSN = [self getProductSerialNumber:amount type:1];
    }else
    {
        stringSN = [self getProductSerialNumber:amount];
    }
    
    
    NSDictionary  *dicInfo = [NSDictionary dictionaryWithObjectsAndKeys:userID,@"user_id",@(platform),@"platform",@(customID),@"custom_id",@(clientVersion),@"client_ver",@(amount),@"amount",@(jailBreak),@"jail_break",stringSN,@"serial_number",nil];
    
    if (!m_httpsManger)
    {
        m_httpsManger = [[RechargeHTTPRequestManger alloc] init];
        m_httpsManger.delegate = self;
    }

    [m_httpsManger startRequestData:dicInfo requestURL:@"get_recharge_channel"];

}




-(void)getHttpsResult:(NSDictionary*)dicInfo requestString:(NSString *)requestString
{
    
    if ([requestString isEqualToString:@"get_recharge_channel"])
    {
        if ([[dicInfo valueForKey:@"result"] intValue] != 1)
        {
            if ([delegate respondsToSelector:@selector(getPayIDFail:)])
            {
                [delegate getPayIDFail:dicInfo];
            }
        }else
        {
            self.payID = [dicInfo valueForKey:@"payid"];
            NSArray    *arrayTemp = [dicInfo valueForKey:@"channel_list"];
            if ([arrayTemp count])
            {
                NSDictionary     *dicTemp = [arrayTemp objectAtIndex:0];
                self.channelID = [[dicTemp valueForKey:@"channel_id"] description];
            }
        
            if (!self.channelID || [self.channelID isEqualToString:@""])
            {
                self.channelID = @"0";
            }
            
            [[InAppPurchaseManager sharedAppPurchase] requestProUpgradeProductDataWithProductID:self.chargemodel.productID
                                                                                 andOrderNumber:self.payID];
            DLOG(@"get payID success:%@",[dicInfo valueForKey:@"payid"]);
        }
        
    }else if ([requestString isEqualToString:@"recharge_request"])
    {
        if ([[dicInfo valueForKey:@"result"] intValue] != 1)
        {
            if ([delegate respondsToSelector:@selector(chargeGoldFail:)])
            {
                [delegate chargeGoldFail:[[dicInfo valueForKey:@"result"] intValue]];
            }
            [self cleanChargeInfo];
        }else
        {
            /*
            if (delegate && [delegate respondsToSelector:@selector(chargeGoldSuc:)])
            {
                   [delegate chargeGoldSuc:self.chargemodel];
            }*/
            
           [self requestChargeResultWithPayID:self.payID chanelID:[self.channelID intValue]];
         
        
            DLOG(@"get payID success:%@",[dicInfo valueForKey:@"payid"]);
        }
        
    }else if ([requestString isEqualToString:@"get_recharge_result"])
    {
        if ([[dicInfo valueForKey:@"result"] intValue] != 1)
        {
            if ([delegate respondsToSelector:@selector(getServerRemainChargeFail:)])
            {
                [delegate getServerRemainChargeFail:[[dicInfo valueForKey:@"result"] intValue]];
            }
        }else
        {
            if (delegate && [delegate respondsToSelector:@selector(getServerRemainChargeSuc:isFirstCharge:)])
            {
                
                int goldNumber = [[dicInfo valueForKey:@"recharge_amount"] intValue]/100;
                switch (goldNumber)
                {
                    case 6:
                        goldNumber = 300;
                        break;
                    case 12:
                        goldNumber = 780;
                        break;
                    case 30:
                        goldNumber = 2000;
                        break;
                    case 128:
                        goldNumber = 9600;
                        break;
                    case 328:
                        goldNumber = 40000;
                        break;
                        
                    default:
                        break;
                }
               [delegate getServerRemainChargeSuc:goldNumber isFirstCharge:[[dicInfo valueForKey:@"first_pay_flag"] boolValue]];
            }
            [JFSQLManger deleteInfoByPayID:[dicInfo valueForKey:@"payid"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:BNRChargeSuc object:nil];
            //DLOG(@"get payID success:%@",[dicInfo valueForKey:@"payid"]);
        }
        
    }
        
    DLOG(@"getHttpsResult:%@ manger string:%@",dicInfo,requestString);
}
-(void)getHttpNetError:(NSString*)statusCode requestString:(NSString *)requestString
{
     DLOG(@"getHttpNetError:%@ manger string:%@",statusCode,requestString);
    if (delegate && [delegate respondsToSelector:@selector(networkOccurError:)])
    {
        [delegate networkOccurError:statusCode];
    }
    
    
    [self cleanChargeInfo];
}


- (void)completeTransactionWithReceipt:(NSString *)tempreceipt
{
  
    self.receipt =  tempreceipt;
    DLOG(@"completeTransactionWithReceipt:%@",self.payID);
    DLOG(@"receipt length:%d",[tempreceipt length]);
    [self storeChareInfo];
    [self requestChargeResult:self.chargemodel order:tempreceipt];
   
}



@end
