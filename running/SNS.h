//
//  SNS.h
//  qsc
//
//  Created by xiangyu on 11/19/14.
//  Copyright (c) 2014 Dreamore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNS : NSObject

+(void)shareWithURLString: (NSString *)urlStr title: (NSString *)title;

+(void)shareWithInfoDic:(NSDictionary *)dic;
@end
