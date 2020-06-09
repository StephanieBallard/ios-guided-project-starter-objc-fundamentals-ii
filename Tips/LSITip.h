//
//  LSITip.h
//  Tips
//
//  Created by Paul Solt on 6/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSITip : NSObject

// FUTURE: tipAmount - double -> calculateTip (computed property?)

// @property will create 3 things
// 1. instance variable
//NSString *_name;
// 2. getter method
//- (NSString *)name;
// 3. setter method (readonly will disable a setter)
//- (void)setName:(NSString *)name;

@property NSString *name;
@property double total;
@property double tipPercentage;
@property int splitCount;

// Swift
//init(withName name: String, total: Double, tipPercentage: Double, splitCount: Int)

- (instancetype)initWithName:(NSString *)name total:(double)total tipPercentage:(double)tipPercentage splitCount:(int)splitCount;


@end

NS_ASSUME_NONNULL_END
