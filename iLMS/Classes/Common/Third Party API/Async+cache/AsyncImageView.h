//
//  AsyncImageView.h
//  DaveyWaveyProject

#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView {
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; // key for image cache dictionary
}

-(void)loadImageFromURL:(NSURL*)url;

@end
