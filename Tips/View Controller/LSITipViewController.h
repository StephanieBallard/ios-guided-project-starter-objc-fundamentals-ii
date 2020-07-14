//
//  LSITipViewController.h
//  Tips
//
//  Created by Spencer Curtis on 2/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SABTipController;

NS_ASSUME_NONNULL_BEGIN

@interface LSITipViewController : UIViewController

// You might not want to put outlets here, unless you want to expose them as public API

@property SABTipController *tipController;

@end

NS_ASSUME_NONNULL_END
