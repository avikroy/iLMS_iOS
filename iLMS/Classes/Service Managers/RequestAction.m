//
//  RequestAction.m
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "RequestAction.h"

@implementation RequestAction

+ (NSString *)returnLoginAction
{
    return @"http://tempuri.org/UserLogin";
}

+ (NSString *)returnLoginForPushAction
{
    return @"http://tempuri.org/UserLogin_ForPushNotifications";
}

+ (NSString *)returnGeneralSearchAction
{
    return @"http://tempuri.org/WP7FetchSearchDetails";
}

+ (NSString *)returnSampleElementAction
{
    return @"http://tempuri.org/WP7FetchSampleElementDetails";
}

+ (NSString *)returnTestDetailsTestAction
{
    return @"http://tempuri.org/WP7GetTestDetailsTest";
}

+ (NSString *)returnTestAnalysisReportChartAction
{
    return @"http://tempuri.org/TestAnalysisReportsCharts";
}

+ (NSString *)returnAnalyzeReportChartAction
{
    return @"http://tempuri.org/AnalyzeReportsCharts";
}


+ (NSString *)returnMonthlySampleAction
{
    return [[self class] returnGeneralSearchAction];
}

+ (NSString *)returnlastViewwedSampleAction
{
    return [[self class] returnGeneralSearchAction];
}

@end
