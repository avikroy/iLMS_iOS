//
//  NSString+iLMS.m
//  iLMS
//
//  Created by Avik Roy on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "NSString+iLMS.h"

@implementation NSString (iLMS)

- (NSString *)stringByTrimmingLeadingAndTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    return [[self stringByTrimmingLeadingCharactersInSet:characterSet]
            stringByTrimmingTrailingCharactersInSet:characterSet];
}


- (NSString *)stringByTrimmingLeadingAndTrailingWhitespaceAndNewlineCharacters {
    return [[self stringByTrimmingLeadingWhitespaceAndNewlineCharacters]
            stringByTrimmingTrailingWhitespaceAndNewlineCharacters];
}


- (NSString *)stringByTrimmingLeadingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfFirstWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]];
    if (rangeOfFirstWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringFromIndex:rangeOfFirstWantedCharacter.location];
}


- (NSString *)stringByTrimmingLeadingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingLeadingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


- (NSString *)stringByTrimmingTrailingCharactersInSet:(NSCharacterSet *)characterSet {
    NSRange rangeOfLastWantedCharacter = [self rangeOfCharacterFromSet:[characterSet invertedSet]
                                                               options:NSBackwardsSearch];
    if (rangeOfLastWantedCharacter.location == NSNotFound) {
        return @"";
    }
    return [self substringToIndex:rangeOfLastWantedCharacter.location + 1]; // Non-inclusive
}


- (NSString *)stringByTrimmingTrailingWhitespaceAndNewlineCharacters {
    return [self stringByTrimmingTrailingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
