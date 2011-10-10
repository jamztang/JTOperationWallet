//
//  JTOperationWallet.m
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JTOperationWallet.h"

@implementation JTOperationWallet

#pragma mark Life Cycle

- (id)init {
    _proxiedTarget = nil;
    _invocations = [[NSMutableArray alloc] init];
    return self;
}

- (void)dealloc {
    _proxiedTarget = nil;
    [_invocations release];
    [super dealloc];
}

#pragma mark Instance method

- (id)prepareWithInvocationTarget:(id)target {
    _proxiedTarget = target;
    return self;
}

- (void)invoke {
    for (NSInvocation *invocation in _invocations) {
        [invocation invoke];
    }
}

- (void)invokeOnQueue:(NSOperationQueue *)queue waitUntilFinished:(BOOL)wait {
    for (NSInvocation *invocation in _invocations) {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invocation];
        [queue addOperation:operation];
        [operation release];
    }

    if (wait) {
        [queue waitUntilAllOperationsAreFinished];
    }
}

#pragma mark NSProxy Overrides

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation setTarget:_proxiedTarget];
    [_invocations addObject:invocation];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_proxiedTarget methodSignatureForSelector:sel];
}

#pragma mark Class method

+ (JTOperationWallet *)wallet {
    JTOperationWallet *aWallet = [[[JTOperationWallet alloc] init] autorelease];
    return aWallet;
}

@end
