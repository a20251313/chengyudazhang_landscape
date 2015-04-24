//
//  JFLanchModel.h
//  chengyuwar
//
//  Created by ran on 13-12-23.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "AdCommonDef.h"
@interface JFLanchModel : NSObject

@property(nonatomic)int question_db_xml_ver;
@property(nonatomic,copy)NSString   *question_db_xml_url;
@property(nonatomic,copy)NSString   *iwvs_server_ip;
@property(nonatomic)int iwvs_server_port;
@property(nonatomic,copy)NSString   *notice;
@property(nonatomic)int last_verion;
@property(nonatomic,copy)NSString   *last_verion_url;
@property(nonatomic,copy)NSString   *ios_share_app_url;
@property(nonatomic)ad_score_wall_type scorewallType;
@property(nonatomic)ad_exhibition_type exhibition_type;

@end
