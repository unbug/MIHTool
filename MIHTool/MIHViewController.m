//
//  MIHViewController.m
//  MIHTool
//
//  Created by unbug on 12-11-21.<http://www.iunbug.com/>
//  Copyright (c) 2012年 unbug. All rights reserved.
//

#import "MIHViewController.h"

static NSString * const kLayerBordersKey = @"WebKitShowDebugBorders";

@interface MIHViewController ()

@end

@implementation MIHViewController
@synthesize pageView = webView;


- (void)viewDidLoad
{
    self.layerBorderSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:kLayerBordersKey];
    [self launch:self];
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(BOOL) canBecomeFirstResponder
{
    return YES;
}

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if(event.subtype==UIEventSubtypeMotionShake)
    {
        if(self.tBar.hidden){
            [self showToolBars];
        }else{
            [self hideToolBars];
        }
    }
}
-(BOOL)shouldAutorotateToInterfaceOrientation:( UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
- (void)updateAddress:(NSURLRequest*)request
{
    NSURL* url = [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    [urlField setText:absoluteString];
    //NSLog(@"%@",absoluteString);
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self updateAddress:request];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)pageView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)pageView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSURLRequest* request = [pageView request];
    [self updateAddress:request];
}
- (IBAction)switchWebKitDebugBorders:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setBool:self.layerBorderSwitch.on forKey:kLayerBordersKey];
    NSString *title = @"Please restart";
    NSString *msg = self.layerBorderSwitch.on ? @"WebKitShowDebugBorders Enabled :-)" : @"WebKitShowDebugBorders Disabled :-(";
    [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    //NSLog(self.layerBorderSwitch.on?@"on":@"off");
}
-(IBAction) launch:(id)sender{
    //[self loadHome:self];
}
-(IBAction) loadHome:(id)sender{
    NSString *str = @"http://www.iunbug.com/mihtool";
    [self.pageView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
}

-(IBAction) loadUrl:(id)sender{
    NSString *str = [urlField.text stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@",str]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    [self.pageView loadRequest:request];
}

- (IBAction)hideToolbar:(id)sender {
    [self hideToolBars];
}

- (IBAction)hideTBar:(id)sender {
    [self hideToolBars];
}
-(void)hideToolBars{
    [self.tBar setHidden:YES];
    [self.bBar setHidden:YES];
    self.pageView.frame = self.view.bounds;
    [self.pageView reload];
}
-(void)showToolBars{
    [self.tBar setHidden:NO];
    [self.bBar setHidden:NO];
    self.pageView.frame = CGRectMake(0,self.tBar.frame.size.height,
                               self.view.bounds.size.width,self.view.bounds.size.height-self.bBar.frame.size.height-self.tBar.frame.size.height);
    [self.pageView reload];
}
- (void)viewDidUnload {
    [self setBBar:nil];
    [self setTBar:nil];
    [super viewDidUnload];
}
@end
