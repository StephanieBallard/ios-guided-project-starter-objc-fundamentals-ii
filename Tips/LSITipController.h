//
//  LSITipController.h
//  Tips
//
//  Created by Paul Solt on 5/12/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

// Build projects faster, and we can reference other classes "recursively"
@class LSITip; // forward class declaration (IOU) here's a heads up about a new class

NS_ASSUME_NONNULL_BEGIN

// Public declarations that are visible outside this code file
// Encapsulate our data (protect our information and control who can modify)

@interface LSITipController : NSObject

// nonatomic (recommended, if override a property)
// atomic*

// readonly
// readwrite*

@property (nonatomic, readonly) NSArray<LSITip *> *tips;

- (void)addTip:(LSITip *)tip;

@end

NS_ASSUME_NONNULL_END
