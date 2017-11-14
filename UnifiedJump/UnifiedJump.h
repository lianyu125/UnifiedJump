//
//  UnifiedJump.h
//  UnifiedJump
//
//  Created by one on 2017/10/26.
//  Copyright © 2017年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnifiedJumpResponseDelegate.h"

@interface UnifiedJump : NSObject

/**
 * 通过URL调用模块
 
 @param url 跳转到的URL
 @return 返回是否有模块接受该URL并进行处理
 */
+ (BOOL)jumpWithURL:(NSURL *)url;

/**
 * 通过URL和URLData来调用模块
 
 @param url       跳转的URL
 @param urlData   处理URL所使用的数据
 @param delegate  回调对象
 @param userInfo  自定义对象
 @return          返回是否有模块接受该URL并进行处理
 */
+ (BOOL)jumpWithURL:(NSURL *)url
                  urlData:(NSDictionary *)urlData
         responseDelegate:(id<UnifiedJumpResponseDelegate>) delegate
                 userInfo:(id) userInfo;
@end
