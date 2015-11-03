//
//  SYMapDataRespond.h
//  SYExperence
//
//  Created by yuhang on 15/9/2.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "JSONModel.h"
#import "SYMapDataSvccont.h"
@interface SYMapDataRespond : JSONModel
{
    
}

@property (nonatomic, copy)     NSString*       activitycode;

@property (nonatomic, copy)     NSString*       processtime;

@property (nonatomic, copy)     NSString*       protversion;

@property (nonatomic, strong)   NSDictionary*   response;

@property (nonatomic, strong)   SYMapDataSvccont*   svccont;

@end
