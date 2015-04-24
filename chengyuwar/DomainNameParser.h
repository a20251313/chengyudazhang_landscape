//
//  LiveDomainNameParser.h
//  i366
//
//  Created by admin on 13-11-4.
//
//

#import <Foundation/Foundation.h>

@interface DomainNameParser : NSObject
{
    /// ip地址数组
    NSMutableArray *ipsArray;
    
    /// ip地址索引
    int ipIndex;
}

+ (id)sharedInstance;

- (void)loadBLDBIPs;


+(NSString*)getFirstHttpUrl;
+(NSString*)getSecondHttpUrl;
+(NSString*)getFirstHttpsUrl;
+(NSString*)getSecondHttpsUrl;
@end
