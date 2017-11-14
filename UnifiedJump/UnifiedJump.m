//
//  UnifiedJump.m
//  UnifiedJump
//
//  Created by one on 2017/10/26.
//  Copyright © 2017年 ZLY. All rights reserved.
//

#import "UnifiedJump.h"
#import "UnifiedJumpDelegate.h"
@implementation UnifiedJump
+ (BOOL)jumpWithURL:(NSURL *)url {
    return [self jumpWithURL:url urlData:nil responseDelegate:nil userInfo:nil];
}
//需要解决的问题:业务线调用该方法进行模块跳转,我相当于中转一下
+ (BOOL)jumpWithURL:(NSURL *)url urlData:(NSDictionary *)urlData responseDelegate:(id<UnifiedJumpResponseDelegate>)delegate userInfo:(id)userInfo {
    
    //1.处理url中的参数
    if (!urlData) {
        urlData = [self paramsURL:url];
    }
    
    NSString * plistPath = [[NSBundle mainBundle] pathForResource:@"moduleMap" ofType:@"plist"];
    NSMutableDictionary *moduleDict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    
    //urlhost即为对应的模块,通过host查找响应的模块
    //先取scheme头
    NSString * schemeHeader  = url.scheme;
    //再取scheme头对应的模块字典
    NSDictionary * moduleMap = [moduleDict objectForKey:schemeHeader];
    
    
    NSString * moudule = [moduleMap objectForKey:url.host];
    Class responseModule =  NSClassFromString(moudule);
    if ([responseModule conformsToProtocol:@protocol(UnifiedJumpDelegate)]) {
        return  [responseModule UnifiedJumpOpenURL:url withUrlData:urlData
                                     responseDelg:delegate
                                         userInfo:userInfo];
    }
    return NO;
}

// 将url的参数部分转化成字典
+ (NSDictionary *)paramsURL:(NSURL *)url {
    
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    if (NSNotFound != [url.absoluteString rangeOfString:@"?"].location) {
        NSString *paramString = [url.absoluteString substringFromIndex:
                                 ([url.absoluteString rangeOfString:@"?"].location + 1)];
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&"];
        NSScanner* scanner = [[NSScanner alloc] initWithString:paramString];
        while (![scanner isAtEnd]) {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2) {
                NSString* key = [[kvPair objectAtIndex:0] stringByRemovingPercentEncoding];
                NSString* value = [[kvPair objectAtIndex:1] stringByRemovingPercentEncoding];
                [pairs setValue:value forKey:key];
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}

@end
