//
//  RememberMe.h
//  RememberMe
//
//  Created by Avik Roy on 7/16/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RememberMe : NSObject
+ (void)saveUserArray:(NSArray *)array forKey:(NSString *)strKey;
+ (NSArray *)getUserArrayForKey:(NSString *)strKey;
+ (void)resetUserArrayForKey:(NSString *)strKey;
@end
