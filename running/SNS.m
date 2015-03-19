//
//  SNS.m
//  qsc
//
//  Created by xiangyu on 11/19/14.
//  Copyright (c) 2014 Dreamore. All rights reserved.
//

#import "SNS.h"
#import <UIKit/UIKit.h>

//第三方平台的SDK头文件，根据需要的平台导入。
#import <ShareSDK/WXApi.h>
#import <ShareSDK/WeiboApi.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDK/ShareSDK.h>



@implementation SNS

// 单纯分享连接
+(void)shareWithURLString: (NSString *)urlStr title: (NSString *)title{

    NSString *defaultContent = @"分享轻松筹的项目";
    
   // id<ISSCAttachment> image = [ShareSDK imageWithUrl:urlStr];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:title
                                       defaultContent:defaultContent
                                                image:nil
                                                title:title
                                                  url:urlStr
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeNews];
    
    
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}


// 分享文字
+(void)shareWithInfoDic:(NSDictionary *)dic{
    
    
    NSString *defaultContent = dic[@"title"];
    id<ISSCAttachment> image = [ShareSDK imageWithUrl:dic[@"imgUrl"]];
    
    NSString * url = dic[@"link"];
    //截取140以内
    NSString * content = dic[@"desc"];
    if (content.length >130) {
        content = [content substringWithRange:NSMakeRange(0, 130)];
        content = [NSString stringWithFormat:@"%@...",content];
    }
    
    //截取30以内
    NSString * title = dic[@"title"];
    if (title.length >25) {
        title = [title substringWithRange:NSMakeRange(0, 25)];
        title = [NSString stringWithFormat:@"%@...",title];
    }
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:defaultContent
                                                image:image
                                                title:title
                                                  url:url
                                          description:@"追梦网轻松筹"
                                            mediaType:SSPublishContentMediaTypeNews];
    
    if (dic[@"share_type"]!=nil  && ![dic[@"share_type"] isEqual:@""]) {
        if ([dic[@"share_type"] isEqual:@"weixin"]) {
            [SNS shareWithType:ShareTypeWeixiTimeline publishContent:publishContent];
        }else if ([dic[@"share_type"] isEqual:@"weibo"]){
            [SNS shareWithType:ShareTypeSinaWeibo publishContent:publishContent];
        }else if ([dic[@"share_type"] isEqual:@"renren"]){
            [SNS shareWithType:ShareTypeRenren publishContent:publishContent];
        }
        return;
    }
    
    [ShareSDK showShareActionSheet:nil
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions: nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];
}

+(void)shareWithType:(ShareType)type publishContent:(id<ISSContent>)publishContent{
    SSPublishContentEventHandler handler = ^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (state == SSResponseStateSuccess)
        {
            NSLog(@"分享成功");
        }
        else if (state == SSResponseStateFail)
        {
            NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
        }
    };
    
    
    id<ISSShareOptions> simpleShareOptions =
    [ShareSDK simpleShareOptionsWithTitle:@"内容分享"
                        shareViewDelegate:nil ];
    

    [ShareSDK showShareViewWithType:type container:nil content:publishContent statusBarTips:YES authOptions:nil shareOptions:simpleShareOptions result:handler];
}

@end
