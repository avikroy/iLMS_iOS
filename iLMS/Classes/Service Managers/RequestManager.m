//
//  RequestObject.m
//  HBC_iPad_application
//
//  Created by Objectsol5 on 20/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

+ (NSMutableString *)loginRequestWithUserName:(NSString *)u_Name password:(NSString *)password
{

    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];
    
    [postBody appendString:@"<tem:UserLogin>"];
    
    [postBody appendString:@"<tem:strUsername>"];
    [postBody appendString:u_Name];
    [postBody appendString:@"</tem:strUsername>"];
    
    [postBody appendString:@"<tem:strPassword>"];
    [postBody appendString:password];
    [postBody appendString:@"</tem:strPassword>"];
    
    [postBody appendString:@"</tem:UserLogin>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
   
    return postBody;

}

+ (NSMutableString *)loginRequestForPushWithUserName:(NSString *)u_Name password:(NSString *)password
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];

    
    [postBody appendString:@"<tem:UserLogin_ForPushNotifications>"];
    
    [postBody appendString:@"<tem:strUsername>"];
    [postBody appendString:u_Name];
    [postBody appendString:@"</tem:strUsername>"];
    
    [postBody appendString:@"<tem:strPassword>"];
    [postBody appendString:password];
    [postBody appendString:@"</tem:strPassword>"];
    
    iLMSAppDelegate *app=APP_DELEGATE;
    
    [postBody appendString:@"<tem:strDeviceID>"];
    if(!app.deviceToken){
        app.deviceToken=@"773f5436825a7115417d3d1e036da20e806efeef547b7c3fe4da724d97c01b30";
    }
    [postBody appendString:app.deviceToken];
    [postBody appendString:@"</tem:strDeviceID>"];
    
    [postBody appendString:@"<tem:strDeviceType>"];
    [postBody appendString:@"ios"];
    [postBody appendString:@"</tem:strDeviceType>"];
        
    [postBody appendString:@"</tem:UserLogin_ForPushNotifications>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}


+ (NSMutableString *)analyzReportChart
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];

    [postBody appendString:@"<tem:AnalyzeReportsCharts>"];
    
    [postBody appendString:@"<tem:strUserID>"];
    [postBody appendString:[[iLMSLoggedinUser getSharedinstance] custID]];
    [postBody appendString:@"</tem:strUserID>"];
    
    [postBody appendString:@"<tem:strCustomerID>"];
    [postBody appendString:[[iLMSLoggedinUser getSharedinstance] userID]];
    [postBody appendString:@"</tem:strCustomerID>"];
    
    [postBody appendString:@"</tem:AnalyzeReportsCharts>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}


+ (NSMutableString *)generlSearchRequestWithCriteria:(NSString *)c_text searchText:(NSString *)s_text additionalSearchText:(NSString *)a_s_text
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];
    
    [postBody appendString:@"<tem:WP7FetchSearchDetails>"];
    
    [postBody appendString:@"<tem:strSearchCriteria>"];
    [postBody appendString:[c_text stringByReplacingOccurrencesOfString:@" " withString:@""]];
    [postBody appendString:@"</tem:strSearchCriteria>"];
    
    [postBody appendString:@"<tem:strSearchText>"];
    [postBody appendString:s_text];
    [postBody appendString:@"</tem:strSearchText>"];
    
    [postBody appendString:@"<tem:strSearchText2>"];
    [postBody appendString:a_s_text];
    [postBody appendString:@"</tem:strSearchText2>"];

    [postBody appendString:@"<tem:strUserAccess>"];
    [postBody appendString:[[iLMSLoggedinUser getSharedinstance] userID]];
    [postBody appendString:@"</tem:strUserAccess>"];

    
    [postBody appendString:@"</tem:WP7FetchSearchDetails>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}

+ (NSMutableString *)sampleElementDetailsWithID:(NSString *)s_ID
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];
    
    [postBody appendString:@"<tem:WP7FetchSampleElementDetails>"];
    
    [postBody appendString:@"<tem:strSampleID>"];
    [postBody appendString:s_ID];
    [postBody appendString:@"</tem:strSampleID>"];
    
    [postBody appendString:@"</tem:WP7FetchSampleElementDetails>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}

+ (NSMutableString *)testDetailsTest
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];

    [postBody appendString:@"<tem:WP7GetTestDetailsTest>"];
    
    [postBody appendString:@"<tem:TestElement>"];
    [postBody appendString:@"</tem:TestElement>"];
    
    [postBody appendString:@"</tem:WP7GetTestDetailsTest>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}

+ (NSMutableString *)testChartAnalysisReportChartWithName:(NSString *)t_Name
{
    
    NSMutableString *postBody=[[NSMutableString alloc] init];
	[postBody appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\" ?>"];
    
    [postBody appendString:@"<soap:Envelope xmlns:soap=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:tem=\"http://tempuri.org/\">"];
    [postBody appendString:@"<soap:Header/>"];
    [postBody appendString:@"<soap:Body>"];
    
    [postBody appendString:@"<tem:TestAnalysisReportsCharts>"];
    
    [postBody appendString:@"<tem:TestName>"];
    [postBody appendString:t_Name];
    [postBody appendString:@"</tem:TestName>"];
    
    [postBody appendString:@"<tem:UserID>"];
    [postBody appendString:/*@"306"*/[[iLMSLoggedinUser getSharedinstance] custID]];
    [postBody appendString:@"</tem:UserID>"];
    
    [postBody appendString:@"<tem:strAccess>"];
    [postBody appendString:/*@"268"*/[[iLMSLoggedinUser getSharedinstance] userID]];
    [postBody appendString:@"</tem:strAccess>"];

    
    [postBody appendString:@"</tem:TestAnalysisReportsCharts>"];
    
    [postBody appendString:@"</soap:Body>"];
    [postBody appendString:@"</soap:Envelope>"];
    
    return postBody;
    
}

+ (NSMutableString *)getMonthlySampleChartWithText:(NSString *)s_text
{
    return [[self class] generlSearchRequestWithCriteria:@"MonthlySample" searchText:s_text additionalSearchText:@""];
}

+ (NSMutableString *)getLast10SampleChart
{
    return [[self class] generlSearchRequestWithCriteria:@"Top10" searchText:@"Top10" additionalSearchText:@""];
}



+ (NSString *)returnAPI_URL
{
    return @"http://www.techenomics.com.au/mobile.techenomics.ws/OCMWebService.asmx";
}

@end
