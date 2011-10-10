//
//  JTWalletHolder.m
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JTWalletHolder.h"
#import "JTOperationWallet.h"
#import "JTObjectProxy.h"

@implementation JTWalletHolder

@synthesize completionWallet;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.

        _futureDict = [JTObjectProxy proxyWithClass:[NSDictionary class]];
    }
    
    return self;
}

- (void)dealloc {
    [self.completionWallet release];
    [_dict release];
    [super dealloc];
}

#pragma mark Instance method

- (void)setComplete {
    _dict = [NSDictionary dictionaryWithObject:@"1" forKey:@"firstObject"];
    [_futureDict invokeWithTarget:_dict];
    [self.completionWallet invoke];
}


- (NSDictionary *)futureDict {
    return (id)_futureDict;
}

@end
