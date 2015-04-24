//
//  JFConLoginModel.m
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import "JFConLoginModel.h"

@implementation JFConLoginModel
@synthesize rewardType;
@synthesize signID;
@synthesize reward_value;
@synthesize day;



-(NSString *)description
{
    return [NSString stringWithFormat:@"JFConLoginModel <<%p>>  signID:%d rewardType:%d reward_value:%d",self,self.signID,self.rewardType,self.reward_value];
}

@end
