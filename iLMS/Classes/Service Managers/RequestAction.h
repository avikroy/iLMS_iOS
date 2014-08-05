//
//  RequestAction.h
//  iLMS
//
//  Created by Avik on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestAction : NSObject

+ (NSString *)returnLoginAction;
+ (NSString *)returnLoginForPushAction;
+ (NSString *)returnGeneralSearchAction;
+ (NSString *)returnSampleElementAction;
+ (NSString *)returnTestDetailsTestAction;
+ (NSString *)returnTestAnalysisReportChartAction;
+ (NSString *)returnMonthlySampleAction;
+ (NSString *)returnlastViewwedSampleAction;
+ (NSString *)returnAnalyzeReportChartAction;

@end
