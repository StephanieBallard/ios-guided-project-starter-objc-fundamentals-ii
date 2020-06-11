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

@interface LSITipViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

// Private Properties
@property (nonatomic) LSITip *currentTip;
@property (nonatomic) double tipAmount;
@property (nonatomic) NSMutableString *totalString;

@property (nonatomic) NSNumberFormatter *numberFormatter;
@property (nonatomic) NSNumberFormatter *currencyFormatter;

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
    // NOTE: if you don't init your variables, they are nil, and nothing happens! They won't work like you expect, but also Xcode or your app do not crash like Swift optionals that are nil
    self.currentTip = [[LSITip alloc] init];
    self.tipController = [[LSITipController alloc] init];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // Add support for "Return" to calculate
    self.totalTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [self.totalTextField addTarget:self
                            action:@selector(totalTextFieldDidEndEditing:)
                  forControlEvents:UIControlEventEditingDidEndOnExit];
    self.totalTextField.delegate = self;
    
    self.totalString = [self.totalTextField.text mutableCopy];
    
    [self calculateTip];
}

- (void)totalTextFieldDidEndEditing:(UITextField *)textField {
    [self calculateTip];
    [textField resignFirstResponder]; // dismiss the keyboard
}

- (void)calculateTip
{
    
    NSNumber *total = [self numberFromString:self.totalString];
    if (!total) { return; } // early exit
    
    self.currentTip.tipPercentage = round(self.percentageSlider.value);
    self.currentTip.total = total.doubleValue; //[self numberFromString:self.totalString].doubleValue; // [self.totalTextField.text doubleValue];
    self.currentTip.splitCount = self.splitStepper.value;
    
    self.tipAmount = self.currentTip.total * (self.currentTip.tipPercentage / 100.0) / self.currentTip.splitCount;
    
    [self updateViews];
    
}

- (void)updateViews
{
    self.splitStepper.value = self.currentTip.splitCount;
    self.percentageSlider.value = self.currentTip.tipPercentage;
    
    // NOTE: don't update the totalLabel here since we're driving it based on input in delegate method
    
    // Format currency with proper locale and use grouping separators
    self.currencyFormatter.usesGroupingSeparator = true;
    self.tipLabel.text = [self.currencyFormatter stringFromNumber:@(self.tipAmount)];
    self.splitLabel.text = [NSString stringWithFormat:@"%d", self.currentTip.splitCount];
    
    // %% = % for output
    self.percentageLabel.text = [NSString stringWithFormat:@"%0.0f%%", self.currentTip.tipPercentage];
    
    [self.tableView reloadData];
}

- (void)saveTipNamed:(NSString *)name
{
    // Create a copy of our current tip (FuTURE: implement copy)
    LSITip *tip = [[LSITip alloc] initWithName:name
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
// FIXME: tip percentage issue
// FIXME: last digit removed not updating display

- (IBAction)updatePercentage:(id)sender {
    self.currentTip.tipPercentage = round(self.percentageSlider.value);
    [self calculateTip];
}

- (IBAction)saveTip:(id)sender {
    [self showSaveTipAlert];
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tipController.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TipCell" forIndexPath:indexPath];
    
    //    LSITip *tip = [self.tipController.tips objectAtIndex:indexPath.row];
    LSITip *tip = self.tipController.tips[indexPath.row];
    
    cell.textLabel.text = tip.name;
    
    return cell;
}

// MARK: - UITableViewDelegate

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

// TODO: Load the selected tip from the controller

//}

// MARK: - UITextFieldDelegate



- (NSNumberFormatter *)numberFormatter {
    if (!_numberFormatter) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        _numberFormatter.minimumFractionDigits = 2;
        //        _numberFormatter.maximumFractionDigits = 2;
        _numberFormatter.minimumIntegerDigits = 1;
    }
    return _numberFormatter;
}



- (NSNumberFormatter *)currencyFormatter {
    if (!_currencyFormatter) {
        _currencyFormatter = [[NSNumberFormatter alloc] init];
        _currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    }
    return _currencyFormatter;
}



- (NSNumber *)decimalNumberFromString:(NSString *)string {
    self.numberFormatter.usesGroupingSeparator = NO;
    NSNumber *number = [self.numberFormatter numberFromString:string];
    
    if (!number) {
        self.numberFormatter.usesGroupingSeparator = YES;
        number = [self.numberFormatter numberFromString:string];
    }
    return number;
}

- (NSNumber *)currencyFromString:(NSString *)string {
    self.currencyFormatter.usesGroupingSeparator = NO;
    NSNumber *number = [self.currencyFormatter numberFromString:string];
    
    if (!number) {
        self.currencyFormatter.usesGroupingSeparator = YES;
        number = [self.currencyFormatter numberFromString:string];
    }
    return number;
}

- (NSNumber *)numberFromString:(NSString *)string {
    NSNumber *number = [self decimalNumberFromString:string];
    
    if (!number) {
        number = [self currencyFromString:string];
    }
    return number;
}

- (BOOL)isNumeric:(NSString *)string {
    return nil != [self numberFromString:string];
}

- (BOOL)isDecimalSeparator:(NSString *)string {
    return [string isEqualToString: self.numberFormatter.decimalSeparator];
}

// TODO: currency separator can be different?
- (BOOL)isGroupingSeparator:(NSString *)string {
    return [string isEqualToString: self.numberFormatter.groupingSeparator];
}

- (BOOL)isDigit:(NSString *)string {
    //    NSCharacterSet.decimalDigitCharacterSet
    return [string rangeOfCharacterFromSet:NSCharacterSet.decimalDigitCharacterSet].location != NSNotFound;
}

- (BOOL)isCurrencySymbol:(NSString *)string {
    return [string isEqualToString:self.currencyFormatter.currencySymbol];
}

// BUG: Pasting will insert bad text

// Almost works, one bug where sometimes text remains in the list ... why?
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"range: %@", NSStringFromRange(range));
    NSLog(@"replacement: %@", string);
    //    NSLog(@"Isnumberic: 3.4: %d", [self isNumeric:@"3.4"]);
    NSLog(@"Isnumberic: string:%@: %d", string, [self isNumeric:string]);
    NSLog(@"Isnumberic: textField.text:%@: %d", textField.text, [self isNumeric:textField.text]);
    
    if (string.length == 0) { // Delete value at range
        NSLog(@"Delete: %@", NSStringFromRange(range));
        [self.totalString replaceCharactersInRange:range withString:@""];
    } else if ([self isDigit:string]) {
        NSLog(@"digit: |%@|", string);
        [self.totalString insertString:string atIndex:range.location];
    } else if ([self isDecimalSeparator:string]) {
        NSLog(@"decimalSeparator: %@", self.numberFormatter.decimalSeparator);
        
        // if we already have decimal, ignore it
        if ([self.totalString containsString:self.numberFormatter.decimalSeparator]) {
            NSLog(@"Invalid: duplicate decimal separator");
            return NO;
        } else {
            [self.totalString insertString:string atIndex:range.location];
        }
    } else if ([self isGroupingSeparator:string]) {
        NSLog(@"groupingSeparator: %@", self.numberFormatter.groupingSeparator);
        
        [self.totalString insertString:string atIndex:range.location];
        
    } else if ([self isCurrencySymbol:string]) {
        NSLog(@"currencySymbol: %@", self.currencyFormatter.currencySymbol);
        [self.totalString insertString:string atIndex:range.location];
    } else {
        // ignore
        NSLog(@"invalid: |%@|", string);
        NSLog(@"self.totalString: %@", self.totalString);
        NSLog(@"self.totalString numeric? %d", [self isNumeric:self.totalString]);
        
        return NO;
    }
    NSLog(@"self.totalString: |%@|", self.totalString);
    NSLog(@"self.totalString numeric? %d", [self isNumeric:self.totalString]);
    [self calculateTip];
    self.percentageLabel.text = self.totalString;
    return YES;
}

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
