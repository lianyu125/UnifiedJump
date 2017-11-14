//
//  UnifiedJumpDelegate.h
//  UnifiedJump
//
//  Created by one on 2017/10/26.
//  Copyright © 2017年 ZLY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UnifiedJumpResponseDelegate.h"

@protocol UnifiedJumpDelegate <NSObject>

+ (BOOL)UnifiedJumpOpenURL:(NSURL *)url
              withUrlData:(NSDictionary *)urlData
             responseDelg:(id<UnifiedJumpResponseDelegate>)responseDelegate
                 userInfo:(id)userInfo;
@end
