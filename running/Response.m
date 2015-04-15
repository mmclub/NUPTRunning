//
//  Response.m
//  
//
//  Created by xiangyu on 3/23/15.
//
//

#import "Response.h"

@implementation Response


//2015-03-23 21:17:07.764 running[38404:1252027] JSON: {
//    data =     {
//        beat = "74.75%";
//        maximum = 11;
//        rundata =         (
//                           (
//                            "2015\U5e7403\U670819\U65e5",
//                            "07\U65f605\U5206"
//                            ),
//                           (
//                            "2015\U5e7403\U670817\U65e5",
//                            "07\U65f606\U5206"
//                            ),
//                           (
//                            "2015\U5e7403\U670816\U65e5",
//                            "07\U65f601\U5206"
//                            ),
//                           (
//                            "2015\U5e7403\U670812\U65e5",
//                            "07\U65f612\U5206"
//                            ),
//                           (
//                            "2015\U5e7403\U670811\U65e5",
//                            "07\U65f605\U5206"
//                            ),
//                           (
//                            "2015\U5e7403\U670810\U65e5",
//                            "08\U65f600\U5206"
//                            )
//                           );
//        time = 6;
//    };
//    erro = 0;
//    message = "\U767b\U9646\U6210\U529f";
//}
+(Response *) responseWithJSONDictionary:(NSDictionary *)jsonDictionary{
    Response *response = [[Response alloc] init];
    if ([jsonDictionary[@"erro"] integerValue] == 0){
        response.error = 0;
        response.rundataArray = jsonDictionary[@"data"][@"rundata"];
        response.time = [jsonDictionary[@"data"][@"time"] integerValue];
        response.maxinum = [jsonDictionary[@"data"][@"maxinum"] integerValue];
        response.beat = jsonDictionary[@"data"][@"beat"];
        response.message = jsonDictionary[@"message"];
        
        NSLog(@"%@", response.message);
    }else {
        response.error = [jsonDictionary[@"erro"] integerValue];
        response.message = jsonDictionary[@"message"];
    }
    return response;
}

@end
