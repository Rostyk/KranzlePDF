//
//  PdfViewController.m
//  KranzlePDF
//
//  Created by Ross on 1/13/15.
//  Copyright (c) 2015 Ross. All rights reserved.
//

#import "PdfViewController.h"


@implementation PdfViewController

#pragma mark lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showPDFFile];
    [self performSelector:@selector(mail) withObject:nil afterDelay: 1.0];
}

#pragma mark show pdf file

-(void)showPDFFile
{
    NSString* fileName = @"Form.pdf";
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480)];
    
    NSURL *url = [NSURL fileURLWithPath:pdfFileName];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView setScalesPageToFit:YES];
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
}

#pragma mark mail

- (void)mail {
    [self mailTo: @"info@cluster-one.eu"];
}

- (void)mailTo:(NSString *)mail {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setToRecipients:@[mail]];
        [composeViewController setSubject:@"Kranzle Pdf"];
        
        NSString* fileName = @"Form.pdf";
        
        NSArray *arrayPaths =
        NSSearchPathForDirectoriesInDomains(
                                            NSDocumentDirectory,
                                            NSUserDomainMask,
                                            YES);
        NSString *path = [arrayPaths objectAtIndex:0];
        NSString* pdfFileName = [path stringByAppendingPathComponent:fileName];
        NSURL *url = [NSURL fileURLWithPath:pdfFileName];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        
        [composeViewController addAttachmentData:data mimeType:@"application/pdf" fileName:@"Form.pdf"];
        [self presentViewController:composeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
