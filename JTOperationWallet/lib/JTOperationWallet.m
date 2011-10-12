/*
 * This file is part of the JTRevealSidebar package.
 * (c) James Tang <mystcolor@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

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
