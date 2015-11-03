//
//  SYFileUpload.h
//  SYExperence
//
//  Created by yuhang on 15/10/26.
//  Copyright © 2015年 yuhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYFileUpload : NSObject


+ (void)upload:(NSString *)name
      fileName:(NSString *)fileName
      mimeType:(NSString *)mimeType
          data:(NSData *)data
        params:(NSDictionary *)params;
@end
