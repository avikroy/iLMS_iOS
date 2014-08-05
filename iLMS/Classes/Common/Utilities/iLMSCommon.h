//
//  iLMSCommon.h
//  iLMS
//
//  Created by Avik Roy on 6/1/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iLMSCommon : NSObject
+(NSString *)getAppDisplayName;
+ (BOOL)isiPad;
+ (void)logout;
@end
