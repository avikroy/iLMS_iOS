//
//  iLMSSearchSamples.h
//  iLMS
//
//  Created by Avik Roy on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iLMSSearchSamples : NSObject
@property(nonatomic, retain) NSString *Attention,*Compartment,*Compartment1,*LabComment,*OilChanged,*OilHrs,*OilName,*SMU,*SampleDate,*SampleID,*SampleNo,*Severity,*UnitID,*UnitName,*SampleName,*SampleNumber;
- (id)initWithDictionary:(NSDictionary *)dict;
@end
