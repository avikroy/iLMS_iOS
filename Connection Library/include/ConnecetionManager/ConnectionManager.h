//
//  ConnectionObject.h
//  HBC_iPad_application
//
//  Created by Objectsol5 on 25/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject
{
    NSMutableData *responceData;
    id target;
	SEL successHandler;
	SEL failureHandler;
    NSString *requestType;
    NSString *strImgName;
    BOOL successStatus;
}

@property (nonatomic,retain)  NSString *requestType;
@property (nonatomic,retain)  NSMutableData *responceData;
@property (nonatomic,retain)  NSString *strImgName;

- (id) initWithTarget:(id)actionTarget SuccessAction:(SEL)successAction FailureAction:(SEL)failureAction;
- (void)callPostMethod:(NSMutableString *)sRequest Action:(NSString *)action API:(NSString *)api;

@end
