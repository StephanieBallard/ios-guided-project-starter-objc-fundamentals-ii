//
//  LSITipViewController.h
//  Tips
//
//  Created by Spencer Curtis on 2/6/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

#import <UIKit/UIKit.h>

// Header File (.h) is a public interface

@class LSITipController;

NS_ASSUME_NONNULL_BEGIN

@interface LSITipViewController : UIViewController

// (Public Instance variables) - Paul doesn't recommend in header file

// Public Properties (dependency injection)
@property (nonatomic) LSITipController *tipController;

// Public Methods

@end

NS_ASSUME_NONNULL_END
