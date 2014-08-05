//
//  iLMSSearchSamples.m
//  iLMS
//
//  Created by Avik Roy on 5/27/14.
//  Copyright (c) 2014 Avik Roy. All rights reserved.
//

#import "iLMSSearchSamples.h"

@implementation iLMSSearchSamples
- (id)initWithDictionary:(NSDictionary *)dict{
    if(self=[super init]){
        
        @try {
            self.Attention=[[dict objectForKey:@"Attention"] objectForKey:@"text"];
            self.Compartment=[[dict objectForKey:@"Compartment"] objectForKey:@"text"];
            self.Compartment1   =[[dict objectForKey:@"Compartment1"] objectForKey:@"text"];
            self.LabComment=[[dict objectForKey:@"LabComment"] objectForKey:@"text"];
            self.OilChanged=[[dict objectForKey:@"OilChanged"] objectForKey:@"text"];
            self.OilHrs=[[dict objectForKey:@"OilHrs"] objectForKey:@"text"];
            self.OilName=[[dict objectForKey:@"OilName"] objectForKey:@"text"];
            self.SMU=[[dict objectForKey:@"SMU"] objectForKey:@"text"];
            self.SampleDate=[[dict objectForKey:@"SampleDate"] objectForKey:@"text"];
            self.SampleID=[[dict objectForKey:@"SampleID"] objectForKey:@"text"];
            self.SampleNo=[[dict objectForKey:@"SampleNo"] objectForKey:@"text"];
            self.Severity=[[dict objectForKey:@"Severity"] objectForKey:@"text"];
            self.UnitID=[[dict objectForKey:@"UnitID"] objectForKey:@"text"];
            self.UnitName=[[dict objectForKey:@"UnitName"] objectForKey:@"text"];
            self.SampleName=[[dict objectForKey:@"SampleName"] objectForKey:@"text"];
            self.SampleNumber=[[dict objectForKey:@"SampleNumber"] objectForKey:@"text"];

        }
        @catch (NSException *exception) {
            [[[UIAlertView alloc] initWithTitle:[iLMSCommon getAppDisplayName] message:[exception description    ] delegate:nil cancelButtonTitle:@"Calcel" otherButtonTitles: nil] show];
            
        }
        @finally {
        }
        
    }
    return self;
}

@end
