/*
 File: APSSimpleWebView.h
 Version: 1.0
 Created by Roy Jit on 18-09-2011
 Copyright (C) 2011 Subomitashraya Technology Solutions. All Rights Reserved.
 
Image Downloaded from Server URL with indicator Animation
If Offline supported, saved into documents Directory for Subsequent usages.
 
*/

@protocol APSSimpleImageViewDelegate <NSObject>
@optional
- (void) APSSimpleImageDownloaded:(UIImage *)image;
@end

@interface APSSimpleWebView : UIImageView 
{
	BOOL isLoading;
	UIActivityIndicatorView *_indicator;
    BOOL isOfflineNeeded;
    NSString *strToShow;
    UIImage *btmImage;
}

@property(nonatomic,retain)	UIActivityIndicatorView *_indicator;
@property(nonatomic,assign)	 BOOL isOfflineNeeded;
@property(nonatomic, assign)id <APSSimpleImageViewDelegate> delegate;

- (id)initWithBottomText:(NSString *)strText andImage:(UIImage *)image;
- (void) loadStringURL:(NSString*)url withFrame:(CGRect)frameUsed;


@end
