//
//  JFConLoginModel.h
//  i366
//
//  Created by ran on 13-10-21.
//
//

#import <Foundation/Foundation.h>


typedef enum
{
    JFRewardTypeNormal,
    JFRewardTypeCover,
    JFRewardTypeWillGet
}JFRewardType;


@interface JFConLoginModel : NSObject

@property(nonatomic)int signID;
@property(nonatomic)int day;
@property(nonatomic)JFRewardType rewardType;
@property(nonatomic)int reward_value;


@end
