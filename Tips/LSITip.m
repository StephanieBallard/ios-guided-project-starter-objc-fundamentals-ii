//
//  LSITip.m
//  Tips
//
//  Created by Paul Solt on 6/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import "LSITip.h"

@implementation LSITip

- (instancetype)initWithName:(NSString *)name
                       total:(double)total
               tipPercentage:(double)tipPercentage
                  splitCount:(int)splitCount
{
    if (self = [super init]) {  // Be careful not to do a == it's a bug!
        _name = name;
        // total = total; // BUG: self assignment, objc will not complain!
        _total = total;
        _tipPercentage = tipPercentage;
        _splitCount = splitCount;
        
        // RULE: Always use _propertyName for assignments in init/delloc/setter/getter
        // This helps prevent side effects like syncing a half initalized
        // object to firebase
        
    }
    return self;
}

@end
