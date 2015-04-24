//
//  LiveDomainNameParser.m
//  i366
//
//  Created by admin on 13-11-4.
//
//

#import "DomainNameParser.h"
#include <netdb.h>
#include <arpa/inet.h>
#import "UtilitiesFunction.h"
#import "Reachability.h"
@implementation DomainNameParser

static DomainNameParser *parser;


+(NSString*)getFirstHttpUrl
{
    return [parser getFirstHttpUrl];
}
+(NSString*)getSecondHttpUrl
{

    return [parser getSecondHttpUrl];
}


+(NSString*)getFirstHttpsUrl
{
    return [parser getFirstHttpsUrl];
}
+(NSString*)getSecondHttpsUrl
{
    return [parser getSecondHttpsUrl];
}






+ (id)sharedInstance
{
    if (!parser) {
        
        parser = [[DomainNameParser alloc] init];
    }
    
    return parser;
}

+ (void)closeInstance
{
    if (parser) {
        [parser release];
        parser = nil;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [ipsArray release];
    ipsArray = nil;
    
    [super dealloc];
}

- (id)init
{
    self = [super init];
    
    if (self) {
        
        ipsArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        ipIndex = 0;
        
        [self checkNetWorkStatus:nil];
    }
    
    return self;
}
-(void)modifiedIndex:(NSNotification*)note
{
    ipIndex++;
    
    if (ipIndex > [ipsArray count]-1)
    {
        ipIndex = 0;
    }
}

- (NSString *)parseDomainName:(NSString *)theHost
{
    struct hostent *host = gethostbyname([theHost UTF8String]);
    if(!host)
    {
        herror("resolv");
        return NULL;
    }
    
    struct in_addr **list = (struct in_addr **)host->h_addr_list;
    NSString *address = [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
    return address;
}

- (void)loadBLDBIPs
{
    
    NSString *ip1 = [self parseDomainName:HTTPSERVERIP1];
    
    NSString *ip2 = [self parseDomainName:HTTPSERVERIP2];
    
    NSArray *array = [NSArray arrayWithObjects:ip1, ip2, nil];
    
    array = [array sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2)
    {
        return (arc4random() % 1) - 1;
    }];
    
    [ipsArray removeAllObjects];
    [ipsArray addObjectsFromArray:array];
}

- (NSString *)getIp
{
    if ([ipsArray count] > 0)
    {
        NSString *host = [ipsArray objectAtIndex:ipIndex];
        return host;
    }else
    {
        if ([UtilitiesFunction networkCanUsed])
        {
            [self loadBLDBIPs];
        }
    }
    
    return nil;
}


-(NSString*)getFirstHttpUrl
{
    ipIndex  = 0;
    NSString   *httpUtl = [NSString stringWithFormat:@"%@%@:%d/",@"http://",[self getIp],HTTPPORT];
    return httpUtl;
}
-(NSString*)getSecondHttpUrl
{
    ipIndex  = 1;
    NSString   *httpUtl = [NSString stringWithFormat:@"%@%@:%d/",@"http://",[self getIp],HTTPPORT];
    return httpUtl;
}


-(NSString*)getFirstHttpsUrl
{
    ipIndex  = 0;
    NSString   *httpUtl = [NSString stringWithFormat:@"%@%@:%d/",@"https://",[self getIp],HTTPSPORT];
    return httpUtl;
}
-(NSString*)getSecondHttpsUrl
{
    ipIndex  = 1;
    NSString   *httpUtl = [NSString stringWithFormat:@"%@%@:%d/",@"https://",[self getIp],HTTPSPORT];
    return httpUtl;
}


#pragma mark network changes
- (void)checkNetWorkStatus:(id)Thread
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange:)
                                                 name:kReachabilityChangedNotification object:nil];
    
    Reachability *r = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    BOOL     bNetWork = YES;
    switch ([r currentReachabilityStatus])
    {
        case ReachableViaWiFi:
            break;
        case ReachableViaWWAN:
            break;
            
        default:
            bNetWork = NO;
            break;
    }
    
    r.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           
                           DLOG(@"network unreachage");
                       });
    };
    
    [r startNotifier];
}

- (void)networkChange:(NSNotification *)note
{
    DLOG(@"note:%@",note);
    BOOL  reconnect =  NO;
    Reachability  *curReach = [note object];
    
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    NSString* statusString= @"";
    switch (netStatus)
    {
        case NotReachable:
        {
            statusString = @"Access Not Available";
            break;
        }
            
        case ReachableViaWWAN:
        {
            statusString = @"Reachable WWAN";
            reconnect = YES;
            break;
        }
        case ReachableViaWiFi:
        {
            statusString= @"Reachable WiFi";
            reconnect = YES;
            break;
        }
        case NoneInfo:
        case ReachableVia2G:
        case ReachableVia3G:
        {
            statusString = nil;
            reconnect = YES;
            break;
        }
    }
    
    if (reconnect)
    {
        if (![ipsArray count])
        {
            [self loadBLDBIPs];
        }
    
    }
    
}


@end
