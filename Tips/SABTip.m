//
//  SABTip.m
//  Tips
//
//  Created by Stephanie Ballard on 7/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "SABTip.h"

@implementation SABTip

- (instancetype)initWithName:(NSString *)name
                       total:(double)total
                  splitCount:(int)splitCount
               tipPercentage:(double)tipPercentage; {
    
    if (self = [super init]) {
        _name = name;
        _total = total;
        _splitCount = splitCount;
        _tipPercentage = tipPercentage;
    }
    return self;
}

// We can override a property setter/getter
// Swift didSet/willSet

// Please do create the instance variable for my property (I don't want a computed property)
@synthesize name = _name; // creates the instance variable

-(void)setName:(NSString *)name {
    // Always use _instanceName in setter/getter
    _name = name;
}

-(NSString *)name {
    return _name;
}

@end
