//
//  JTWalletHolder.h
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTOperationWallet.h"

@interface JTWalletHolder : NSObject

@property (nonatomic, retain) JTOperationWallet *completionWallet;

- (void)setComplete;

@end
