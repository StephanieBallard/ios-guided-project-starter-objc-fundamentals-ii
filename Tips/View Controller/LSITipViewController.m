//
//  LSITipViewController.m
//  Tips
//
//  Created by Spencer Curtis on 2/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

// Implementation File (.m) = essentially private*

#import "LSITipViewController.h"
#import "LSITip.h"
#import "LSITipController.h"

// Objective-C: Class Extension (Different from Swift's extension)

@interface LSITipViewController ()

// Private Properties
@property (nonatomic) LSITip *currentTip;
@property (nonatomic) double tipAmount;
// FUTURE: compute tip on the fly

// Private IBOutlets

// prefer strong for IBOutlets so the memory doesn't get cleaned up if you pull a view out of the view heirarchy
@property (strong, nonatomic) IBOutlet UITextField *totalTextField;
@property (strong, nonatomic) IBOutlet UILabel *splitLabel;
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UIStepper *splitStepper;
@property (strong, nonatomic) IBOutlet UISlider *percentageSlider;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

// Private Methods

// Kind of a forward declaration for methods/functions (required to do this in C)

- (void)calculateTip;
- (void)updateViews;
- (void)saveTipNamed:(NSString *)name;

@end

@implementation LSITipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TODO: move to init
    self.currentTip = [[LSITip alloc] init];
    
}

- (void)calculateTip
{
    self.currentTip.tipPercentage = round(self.percentageSlider.value);
    self.currentTip.total = [self.totalTextField.text doubleValue];
    self.currentTip.splitCount = self.splitStepper.value;
    
    self.tipAmount = self.currentTip.total * (self.currentTip.tipPercentage / 100.0) / self.currentTip.splitCount;
    
    [self updateViews];
}

- (void)updateViews
{
    self.splitStepper.value = self.currentTip.splitCount;
    self.percentageSlider.value = self.currentTip.tipPercentage;
    self.totalTextField.text = [NSString stringWithFormat:@"%.2f", self.currentTip.total];
    
    self.tipLabel.text = [NSString stringWithFormat:@"$%.2f", self.tipAmount];
    self.splitLabel.text = [NSString stringWithFormat:@"%d", self.currentTip.splitCount];
    
    // %% = % for output
    self.percentageLabel.text = [NSString stringWithFormat:@"%0.0f%%", self.currentTip.tipPercentage];

    [self.tableView reloadData];
}

- (void)saveTipNamed:(NSString *)name
{
    // Create a copy of our current tip (FuTURE: implement copy)
    LSITip *tip = [[LSITip alloc] initWithName:self.currentTip.name
                                         total:self.currentTip.total
                                 tipPercentage:self.currentTip.tipPercentage
                                    splitCount:self.currentTip.splitCount];
    
    [self.tipController addTip:tip];
    
    // update views
    [self updateViews];
}

// MARK: - IBActions

- (IBAction)updateSplit:(id)sender {
    self.currentTip.splitCount = round(self.splitStepper.value);
    [self calculateTip];
}

- (IBAction)updatePercentage:(id)sender {
    self.currentTip.tipPercentage = round(self.percentageSlider.value);
    [self calculateTip];
}

- (IBAction)saveTip:(id)sender {
    [self showSaveTipAlert];
}

// MARK: - UITableViewDataSource

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}

// MARK: - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

// TODO: Load the selected tip from the controller

//}

// MARK: - Alert Helper

- (void)showSaveTipAlert
{
    UIAlertController *alert = [UIAlertController
                                alertControllerWithTitle:@"Save Tip"
                                message:@"What name would you like to give to this tip?"
                                preferredStyle:UIAlertControllerStyleAlert];
    
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Tip Name:";
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *name = [[alert.textFields firstObject] text];
        if (name.length > 0) {
            [self saveTipNamed: name];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    
    [alert addAction:saveAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
