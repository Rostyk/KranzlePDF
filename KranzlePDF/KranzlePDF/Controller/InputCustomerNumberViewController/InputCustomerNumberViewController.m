//
//  ViewController.m
//  KranzlePDF
//
//  Created by Ross on 1/12/15.
//  Copyright (c) 2015 Ross. All rights reserved.
//

#import "InputCustomerNumberViewController.h"
#import "DataProvider.h"
#import "PDFRenderer.h"
#import "Constants.h"
#import "PdfViewController.h"
#import "Customer.h"

@interface InputCustomerNumberViewController()
@property (nonatomic, weak) IBOutlet UITextField *customerNumberTextField;
@end


@implementation InputCustomerNumberViewController

#pragma mark lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



#pragma mark parse button clicked

- (IBAction)parseButtonClicked:(id)sender {
    NSString *customerNumber = self.customerNumberTextField.text;
    NSArray *customerRecord = [[DataProvider sharedProvider] recordForCustomerNumber:customerNumber];
    Customer *customer = [[Customer alloc] initWithRecord: customerRecord];
    [[PDFRenderer sharedRenderer] insertCustomerData: customer];
    [[PDFRenderer sharedRenderer] render];
    
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PdfViewController *controller = (PdfViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"PdfViewControllerID"];
    [self.navigationController pushViewController: controller animated:YES];
}


@end
