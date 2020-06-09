//
//  LSITipController.h
//  Tips
//
//  Created by Paul Solt on 6/9/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <Foundation/Foundation.h>

// Forward class declaration (improve build times, refer between two files, prevents compilation cycle)
@class LSITip;

NS_ASSUME_NONNULL_BEGIN

@interface LSITipController : NSObject

// lightweight generics make the NSArray have only LSITip objects

// property attributes (* = default)
//  nonatomic, atomic*
//  readwrite*, readonly

// tips is an Array of LSITips
// Swift: [Tip]
@property (nonatomic, readonly) NSArray<LSITip *> *tips;

- (void)addTip:(LSITip *)tip;

@end

NS_ASSUME_NONNULL_END
