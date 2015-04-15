//
//  Response.h
//  
//
//  Created by xiangyu on 3/23/15.
//
//

#import <Foundation/Foundation.h>

@interface Response : NSObject

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *beat;

@property (nonatomic, assign) NSInteger error;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, assign) NSInteger maxinum;
@property (nonatomic, strong) NSArray* rundataArray;


+(Response *) responseWithJSONDictionary:(NSDictionary *)jsonDictionary;




@end
