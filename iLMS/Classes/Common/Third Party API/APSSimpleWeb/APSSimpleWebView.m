/*
 File: APSSimpleWebView.m
 Version: 1.0
 Created by Roy Jit on 18-09-2011
 Copyright (C) 2011 Subomitashraya Technology Solutions. All Rights Reserved.
*/

#import "APSSimpleWebView.h"
#import "UIImage+Resize.h"
#import <QuartzCore/QuartzCore.h>

@interface APSSimpleWebView ()

-(NSString *) getDocumentsDirectory;

@end

@implementation APSSimpleWebView

@synthesize _indicator;		
@synthesize isOfflineNeeded;
@synthesize delegate;

- (id)init
{
    self = [super init];
    if (self)
    {
        // Initialization code here.
        self.isOfflineNeeded = FALSE;
        
        self.layer.cornerRadius = 0.0;
        [self.layer setBorderWidth:0.0];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:[[UIColor clearColor] CGColor]];

    }
    
    return self;
}

- (id)initWithBottomText:(NSString *)strText andImage:(UIImage *)image{
    self=[super init];
    if(self){
        
        self.isOfflineNeeded = FALSE;
        
        self.layer.cornerRadius = 0.0;
        [self.layer setBorderWidth:0.0];
        [self.layer setMasksToBounds:YES];
        [self.layer setBorderColor:[[UIColor clearColor] CGColor]];

        strToShow=strText;
        btmImage=image;
        
    }
    return self;
}

- (void)layoutSubviews{
    if(strToShow != nil){
        UIView *bottomView=[[UIView alloc] initWithFrame:CGRectMake(0.5, self.frame.size.height-20, self.frame.size.width-1, 20)];
//        bottomView.layer.backgroundColor=[[UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.4] CGColor] ;
        bottomView.layer.backgroundColor=[[UIColor colorWithRed:255/255. green:255/255. blue:255/255. alpha:0.4] CGColor] ;

        [self setClipsToBounds:YES];
        [self addSubview:bottomView];
        
        UIImageView *camera=[[UIImageView alloc] initWithFrame:CGRectMake(bottomView.frame.size.width/2 -15,bottomView.frame.size.height/2-8, 12.0, 12.0)];
        camera.image=btmImage;//[UIImage imageNamed:@"placeholder_camera.png"];
        [bottomView addSubview:camera];
        
        UILabel *numberLabel=[[UILabel alloc] initWithFrame:CGRectMake(bottomView.frame.size.width/2 ,2, 100.0, 12.0)];
        numberLabel.backgroundColor=[UIColor clearColor];
        numberLabel.textColor=[UIColor blackColor];
        numberLabel.font=[UIFont systemFontOfSize:12];
        numberLabel.text=strToShow;//[NSString stringWithFormat:@"%d",[[liveAdvertDict objectForKey:@"images"] count]];
        [bottomView addSubview:numberLabel];
    }
}


- (void) loadStringURL:(NSString*)theURLString withFrame:(CGRect)frameUsed
{
	if(isLoading)
	{
		return;
	}
	isLoading = YES;
	
	if(_indicator == nil)
	{
		_indicator =[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		_indicator.center = CGPointMake(frameUsed.size.width/2.0, frameUsed.size.height/2.0); 
		_indicator.hidesWhenStopped = YES;
		[self addSubview:_indicator];
	}
	
	if(![_indicator isAnimating])
	{
		[_indicator startAnimating];
	}
	
    //If dataWithContents then detach for new thread else on Main thread
    [NSThread detachNewThreadSelector:@selector(performAsyncLoadWithURL:) toTarget:self withObject:theURLString];
}

- (void) performAsyncLoadWithURL:(NSString *)url
{    
	NSData *imageData = nil;
    NSError *error = nil;
    
	if(1) //if([AFNetworkReachabilityManager sharedManager].reachable)
    {
        if(self.isOfflineNeeded)
        {
            NSString* lastComponent = [[NSURL URLWithString:url] lastPathComponent];
            
            NSString *savedImagePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:lastComponent];
            
            imageData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:savedImagePath]];
        }
        
        
        if(imageData == nil)
        {
            if(url){
                imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingUncached error:&error];

            }
        }
    }
	else
		imageData = [NSData dataWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"add-photo-small-down"]];
	
    
	if(imageData)
	{
        NSDictionary *imageDict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:imageData,url, nil] forKeys:[NSArray arrayWithObjects:@"IMGDATA",@"IMGURL", nil]];
        
		[self performSelectorOnMainThread:@selector(loadDidFinishWithData:) withObject:imageDict waitUntilDone:NO];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(loadDidFinishWithError:) withObject:error waitUntilDone:NO];
	}
	
}


- (void)loadDidFinishWithData:(NSDictionary *)imageDict
{
    
	isLoading = NO;
	
	if([_indicator isAnimating])
	{
		[_indicator stopAnimating];
        
        if(imageDict != nil)
        {
            if([imageDict valueForKey:@"IMGDATA"] != nil)
            {
                //Change the Big Image to Thumbnail size -- Optimization
//                 UIImage *optimizedImage = [[UIImage imageWithData:[imageDict valueForKey:@"IMGDATA"]] thumbnailImage:self.bounds.size.width transparentBorder:2 cornerRadius:0 interpolationQuality:kCGInterpolationDefault];
                 UIImage *optimizedImage = [UIImage imageWithData:[imageDict valueForKey:@"IMGDATA"]] ;
                self.image = optimizedImage;
                if(self.delegate)
                {
                    if ([self.delegate respondsToSelector:@selector(APSSimpleImageDownloaded:)])
                        [self.delegate APSSimpleImageDownloaded:optimizedImage];
                }
               
                if([imageDict valueForKey:@"IMGURL"] != nil)
                {
                    if(self.isOfflineNeeded)
                    {
                        NSString* lastComponent = [[NSURL URLWithString:[imageDict valueForKey:@"IMGURL"]] lastPathComponent];
    
                        NSString *savedImagePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:lastComponent];
                        [[imageDict valueForKey:@"IMGDATA"]  writeToFile:savedImagePath atomically:YES];
                    }
                }
            }
        }
	}
}

- (void)loadDidFinishWithError:(NSError*)error
{
	isLoading = NO;
	
	if([_indicator isAnimating])
	{
		[_indicator stopAnimating];
        
        NSLog(@"%@",[error localizedDescription]);
	}
    
    if(self.delegate != nil)
    {
        if ([self.delegate respondsToSelector:@selector(APSSimpleImageDownloaded:)])
            [self.delegate APSSimpleImageDownloaded:nil];
    }
}



-(NSString *) getDocumentsDirectory
{
    NSString *documentsDirectory = @"";
    
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentsDirectory = [pathArray objectAtIndex:0];
    
    return documentsDirectory;
}
@end
