//
//  SABTipController.h
//  Tips
//
//  Created by Stephanie Ballard on 7/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

// Build projects faster, and we can reference other classes "recursively"
@class SABTip; // forward class decleration (IOU) here's a heads up about a new class

NS_ASSUME_NONNULL_BEGIN

// Public declarations that are visable outside this code file
// Encapsulate our data (protect our information and control who can modify)
@interface SABTipController : NSObject

// nonatomic (recommended, if override a property)
// atomic*

// readonly
// readwrite*

@property (nonatomic, readonly) NSArray<SABTip *> *tips;

- (void)addTip:(SABTip *)tips;



@end

NS_ASSUME_NONNULL_END
