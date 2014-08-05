//
//  RequestObject.h
//  HBC_iPad_application
//
//  Created by Objectsol5 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestManager : NSObject
{
    
}

+ (NSMutableString *)loginRequestWithUserName:(NSString *)u_Name password:(NSString *)password;
+ (NSMutableString *)loginRequestForPushWithUserName:(NSString *)u_Name password:(NSString *)password;
+ (NSMutableString *)generlSearchRequestWithCriteria:(NSString *)c_text searchText:(NSString *)s_text additionalSearchText:(NSString *)a_s_text;
+ (NSMutableString *)sampleElementDetailsWithID:(NSString *)s_ID;
+ (NSMutableString *)testDetailsTest;
+ (NSMutableString *)testChartAnalysisReportChartWithName:(NSString *)t_Name;
+ (NSMutableString *)getMonthlySampleChartWithText:(NSString *)s_text;
+ (NSMutableString *)getLast10SampleChart;
+ (NSMutableString *)analyzReportChart;

+ (NSString *)returnAPI_URL;

@end
