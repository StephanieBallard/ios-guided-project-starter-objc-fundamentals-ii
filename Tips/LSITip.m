//
//  LSITip.m
//  Tips
//
//  Created by Paul Solt on 5/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSITip.h"

@implementation LSITip

- (instancetype)initWithName:(NSString *)name
                       total:(double)total
                  splitCount:(int)splitCount
               tipPercentage:(double)tipPercentage {
    if (self = [super init]) { // don't use == accidentally! bug!
        // #1 init: always use _propertyName (instance variable)
        _name = name;
        _total = total;
        _splitCount = splitCount;
        _tipPercentage = tipPercentage;
        
        // Do this in Swift, not in Objective-C in your init
        // self.name = name; // Can produce side effects in Objc
    }
    return self;
}

// We can override a property setter/getter
// Swift didSet/willSet

// Please do create the instance variable for my property
// (I don't want a computed property)
@synthesize name = _name; // creates the instance variable
- (void)setName:(NSString *)name {
    // willSet
    
    // #2 Always use _instanceName in setter/getter
    _name = name;
    // didSet
    
    //[self saveToFirebase]; // potential side effect in init, always use _instanceVarName
    
    // DON'T use this self. or method call syntax or we get an infinite loop
    //self.name = name;
    //[self setName:name];
}

- (NSString *)name {
    return _name;
}

@end
