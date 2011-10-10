//
//  JTWalletHolder.m
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTWalletHolder.h"

@implementation JTWalletHolder

@synthesize completionWallet;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)setComplete {
    [self.completionWallet invoke];
}

- (void)dealloc {
    [self.completionWallet release];
    [super dealloc];
}

@end
