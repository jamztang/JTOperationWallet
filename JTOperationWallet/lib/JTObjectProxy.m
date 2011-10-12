/*
 * This file is part of the JTRevealSidebar package.
 * (c) James Tang <mystcolor@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "JTObjectProxy.h"

@implementation JTObjectProxy
@synthesize proxiedTarget;

#pragma mark Life Cycle

- (id)initWithClass:(Class)aClass {
    _invocations = [[NSMutableArray alloc] init];
    _class       = aClass;
    return self;
}

- (void)dealloc {
    [_invocations release];
    [super dealloc];
}

#pragma mark Instance method

- (void)invokeWithTarget:(id)target {
    [proxiedTarget release], proxiedTarget = nil;
    proxiedTarget = [target retain];

    for (NSInvocation *invocation in _invocations) {
        [invocation invokeWithTarget:target];
    }
    [_invocations removeAllObjects];
}

#pragma mark NSProxy Overrides

- (void)forwardInvocation:(NSInvocation *)invocation {
    if (proxiedTarget) {
        [invocation invokeWithTarget:proxiedTarget];
//        id result = nil;
//        [invocation getReturnValue:&result];
//        NSLog(@"-[%@ %@] = %@", proxiedTarget, NSStringFromSelector([invocation selector]), result);

    } else {
        [_invocations addObject:invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_class instanceMethodSignatureForSelector:sel];
}

#pragma mark Class method

+ (JTObjectProxy *)proxyWithClass:(Class)aClass {
    JTObjectProxy *proxy = [[JTObjectProxy alloc] initWithClass:aClass];
    return [proxy autorelease];
}

@end
