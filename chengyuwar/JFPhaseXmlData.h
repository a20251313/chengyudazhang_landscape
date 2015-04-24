//
//  JFPhaseXmlData.h
//  chengyuwar
//
//  Created by ran on 13-12-26.
//  Copyright (c) 2013年 com.lelechat.chengyuwar. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum
{
    JFPhaseXmlDataTypeNormalXml,
    JFPhaseXmlDataTypeNormalIdiom
    
}JFPhaseXmlDataType;
@interface JFPhaseXmlData : NSObject

+(int)phaseXml:(NSString*)strPath xmlType:(JFPhaseXmlDataType)xmlType;
+(NSMutableArray*)phaseUrlInfoAccordPath:(NSString*)strPath    xmlType:(JFPhaseXmlDataType)xmlType rootPath:(NSString*)rootPath;
+(BOOL)checkArrayZip:(NSMutableArray*)inputArray  outArray:(NSMutableArray*)outArray;
+(CGFloat)phaseXmlZipSize:(NSString*)strPath xmlType:(JFPhaseXmlDataType)xmlType;
+(int)getAllIdiomCountFromDownloadFiles;
+(NSMutableArray*)getAllIdiomFromDownloadFiles;
@end
