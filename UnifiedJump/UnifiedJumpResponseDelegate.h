//
//  UnifiedJumpResponseDelegate.h
//  UnifiedJump
//
//  Created by one on 2017/10/26.
//  Copyright © 2017年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UnifiedJumpResponseDelegate <NSObject>
- (void)UnifiedJumpResponseData:(NSDictionary *)responseData
                         withOpenURL:(NSURL *)url
                             urlData:(NSDictionary *)urlData
                            userInfo:(id)userInfo;
@end
