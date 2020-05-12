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

@interface LSITipController : NSObject

@property NSArray<LSITip *> *tips;

- (void)addTip:(LSITip *)tips;

@end

NS_ASSUME_NONNULL_END
