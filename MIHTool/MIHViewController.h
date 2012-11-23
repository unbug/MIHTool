//
//  MIHViewController.h
//  MIHTool
//
//  Created by unbug on 12-11-21.<http://www.iunbug.com/>
//  Copyright (c) 2012年 unbug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MIHViewController : UIViewController{
    UIWebView *webView;
    IBOutlet UITextField *urlField;
}

@property (retain, nonatomic) IBOutlet UIWebView *pageView;
@property (weak, nonatomic) IBOutlet UISwitch *layerBorderSwitch;

-(IBAction) launch:(id)sender;
-(IBAction) loadHome:(id)sender;
-(IBAction) switchWebKitDebugBorders:(id)sender;
-(IBAction) loadUrl:(id)sender;
- (void)updateAddress:(NSURLRequest*)request;
@end
