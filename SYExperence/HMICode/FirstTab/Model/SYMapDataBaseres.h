//
//  SYMapDataBaseres.h
//  SYExperence
//
//  Created by yuhang on 15/9/2.
//  Copyright (c) 2015年 yuhang. All rights reserved.
//

#import "JSONModel.h"

@interface SYMapDataBaseres : JSONModel


@property (nonatomic, copy) NSString<Optional>* add_md5;
@property (nonatomic, copy) NSString<Optional>* add_size;
@property (nonatomic, copy) NSString<Optional>* add_unzipsize;
@property (nonatomic, copy) NSString<Optional>* add_url;
@property (nonatomic, copy) NSString* all_md5;
@property (nonatomic, copy) NSString* all_size;

@property (nonatomic, copy) NSString* all_unzipsize;
@property (nonatomic, copy) NSString* all_url;
@property (nonatomic, copy) NSString* name_en;
@property (nonatomic, copy) NSString* name_ft;
@property (nonatomic, copy) NSString* name_zh;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, strong) NSDictionary* updatedesc;
@property (nonatomic, copy) NSString*updatetype;
@property (nonatomic, copy) NSString*version;


@end
