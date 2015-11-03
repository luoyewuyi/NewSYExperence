//
//  SYMapDataTool.m
//  SYExperence
//
//  Created by yuhang on 15/9/2.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "SYMapDataTool.h"

// AFNetworking
#import <AFNetworking/AFURLSessionManager.h>
#import <AFNetworking/AFHTTPRequestOperation.h>

#import "zlib.h"

#import <JSONModel/JSONModel.h>

#import <CommonCrypto/CommonDigest.h>

#import "SSZipArchive.h"

static SYMapDataTool* instance = nil;


@implementation SYMapDataTool

/**
 * @brief   实例化
 * @return
 */
+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[SYMapDataTool alloc] init];
    });
    return instance;
}


/**
 * @brief   获取城市列表
 * @return
 */
- (void )getMapDataListFromServer
{
    
    NSURL* url = [NSURL URLWithString:[[self serverUrl] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    NSMutableURLRequest* quest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    quest.HTTPMethod = @"POST";
    
    NSData* httpData = [NSJSONSerialization dataWithJSONObject:[self _setRequestBody] options:NSJSONWritingPrettyPrinted error:nil];
    quest.HTTPBody = httpData;
    
    __weak SYMapDataTool* tool = self;
    
    AFHTTPRequestOperation* operation = [[AFHTTPRequestOperation alloc] initWithRequest:quest];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        NSData* zip = (NSData *)responseObject;
        
        NSString* path = NSHomeDirectory();
        
        NSString* sourcePath = [NSString stringWithFormat:@"%@/Documents/download.rar", path];
//        NSString* destPath = [NSString stringWithFormat:@"%@/Documents", path];
        
//        NSString* filePath = [NSString stringWithFormat:@"%@/Documents/download", path];
        
        [zip writeToFile:sourcePath atomically:YES];
        //
        NSData *data = [tool uncompressZippedData:responseObject];
        
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"%@", dic);
        
        SYMapDataRespond* respond = [[SYMapDataRespond alloc] initWithData:data
                                                                     error:nil];
        //
        int i = 1;
        i++;
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        int i = 1;
        i++;
        NSLog(@"%@", error);
        
    }];
    
    [operation start];

}


- (NSDictionary *)_setRequestBody
{
    
    NSString *osVersion = @"9.0";//[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
    UIScreen *MainScreen = [UIScreen mainScreen];
    CGSize Size = [MainScreen bounds].size;
    CGFloat scale = [MainScreen scale];
    CGFloat screenWidth = Size.width * scale;
    CGFloat screenHeight = Size.height * scale;
    NSString *screenResolution;
    if (screenWidth<screenHeight)
    {
        screenResolution = [NSString stringWithFormat:@"%dx%d_%d",(int)screenWidth,(int)screenHeight,[osVersion intValue]];
    }
    else
    {
        screenResolution = [NSString stringWithFormat:@"%dx%d_%d",(int)screenHeight,(int)screenWidth,[osVersion intValue]];
    }
    
    
    NSString *sysCode = Syscode;
    NSString *apkVersion = AppVersion;
    NSString *resourceVersion = @"20";

    //
    
    NSString *mapVersion =@"V 29.1.030005.0003";//[[MWMapData sharedInstance] MW_GetVersionInfo:HMI_VERSION_MAP];、
    if (mapVersion == nil || [mapVersion length] == 0)
    {
        mapVersion = VersionMap;
    }
    NSString *enginVersion = @"V 7.1.030005.0069";//[[MWMapData sharedInstance] MW_GetVersionInfo:HMI_VERSION_ENGINER];
    NSString *key = @"370060C88A374151A175AB60C5FCA7C5";
    NSString *keyWord = [NSString stringWithFormat:@"%@%@%@",sysCode,apkVersion,resourceVersion];
    NSString *md5Words = [NSString stringWithFormat:@"%@@%@",keyWord,key];
    NSString *sign = [[self md5:md5Words] uppercaseString];
    
    NSDictionary *svccountDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"2"           ,@"pid",
                                 apkVersion     ,@"apkv",
                                 sysCode        ,@"syscode",
                                 resourceVersion,@"resv",
                                 @[mapVersion],@"mapvlist",
                                 screenResolution,@"resolution",
                                 osVersion    ,@"osv",
                                 @"1"         ,@"needtaiwan",
                                 enginVersion ,@"enginev",
                                 sign         ,@"sign",
                                 nil];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDictionary *postDic = [NSDictionary dictionaryWithObjectsAndKeys:
                             @"0001"    ,@"activitycode",
                             strDate    ,@"processtime",
                             @"1"       ,@"protversion",
                             @"0"       ,@"language",
                             svccountDic,@"svccont",
                             nil];
    
    NSLog(@"dic:%@", postDic);
    
    return postDic;
//    NSDictionary* dic =
//    @{
//      @"activitycode":@"0001",
//      @"language":@"0",
//      @"processtime":@"20150902113730",
//      @"protversion":@"1",
//      @"svccont":@{
//                    @"apkv":@"20",
//                    @"enginev":@"V 7.1.030005.0069",
//                    @"mapvlist":@"V 29.1.030005.0003",
//                    @"needtaiwan":@"1",
//                    @"osv":@"7.1.2",
//                    @"pid":@"2",
//                    @"resolution":@"640x1136_7",
//                    @"resv":@"V 26",
//                    @"sign":@"5CAF010CDA8F1D8D59A8E8D165A0E40C",
//                    @"syscode":@"41501",
//          },
//      };
//    
//    return dic;
}

- (NSString *)serverUrl
{
    NSString *osVersion = @"9.0";//[NSString stringWithFormat:@"%@",[[UIDevice currentDevice] systemVersion]];
    UIScreen *MainScreen = [UIScreen mainScreen];
    CGSize Size = [MainScreen bounds].size;
    CGFloat scale = [MainScreen scale];
    CGFloat screenWidth = Size.width * scale;
    CGFloat screenHeight = Size.height * scale;
    NSString *screenResolution;
    if (screenWidth<screenHeight)
    {
        screenResolution = [NSString stringWithFormat:@"%dx%d_%d",(int)screenWidth,(int)screenHeight,[osVersion intValue]];
    }
    else
    {
        screenResolution = [NSString stringWithFormat:@"%dx%d_%d",(int)screenHeight,(int)screenWidth,[osVersion intValue]];
    }
    
    NSString* urlString = [NSString stringWithFormat:@"http://nis.autonavi.com/nis/mapUpdate?os=%@&model=%@&imei=%@&userid=&mapversion=%@&pid=2&resolution=%@&syscode=%@&apkversion=%@",osVersion,[[UIDevice currentDevice] model],[[UIDevice currentDevice] identifierForVendor].UUIDString,VersionMap,screenResolution,Syscode,AppVersion];
    
    NSURL* url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSLog(@"url:%@", url);
    
    return urlString;
}


#pragma mark
#pragma mark 内部方法
-(NSData *)uncompressZippedData:(NSData *)compressedData
{
    if ([compressedData length] == 0) return compressedData;
    
    unsigned full_length = (unsigned)[compressedData length];
    
    unsigned half_length = (unsigned)[compressedData length] / 2;
    NSMutableData *decompressed = [NSMutableData dataWithLength: full_length + half_length];
    BOOL done = NO;
    int status;
    z_stream strm;
    strm.next_in = (Bytef *)[compressedData bytes];
    strm.avail_in = (unsigned)[compressedData length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    if (inflateInit2(&strm, (15+32)) != Z_OK) return nil;
    while (!done) {
        // Make sure we have enough room and reset the lengths.
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy: half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        // Inflate another chunk.
        status = inflate (&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK) {
            break;
        }
        
    }
    if (inflateEnd (&strm) != Z_OK) return nil;
    // Set real length.
    if (done) {
        [decompressed setLength: strm.total_out];
        return [NSData dataWithData: decompressed];
    } else {
        return nil;
    }
}

//MD5加密
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
