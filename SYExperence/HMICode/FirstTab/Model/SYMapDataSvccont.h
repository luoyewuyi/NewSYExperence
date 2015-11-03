//
//  SYMapDataSvccont.h
//  SYExperence
//
//  Created by yuhang on 15/9/2.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "JSONModel.h"
#import "SYMapDataBaseres.h"
@interface SYMapDataSvccont : JSONModel
{
    
}

@property (nonatomic, strong)   SYMapDataBaseres*   baseres;

@property (nonatomic, copy)     NSString*       baseurl;

@property (nonatomic, copy)     NSString*       mapv;

@property (nonatomic, strong)   NSArray*        nocross;

@property (nonatomic, strong)   NSArray*        nomatchs;

@property (nonatomic, copy)     NSString*       status;


@property (nonatomic, strong)   NSDictionary*   updatedesc;


@end
