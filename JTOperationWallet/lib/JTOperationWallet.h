/*
 * This file is part of the JTRevealSidebar package.
 * (c) James Tang <mystcolor@gmail.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <Foundation/Foundation.h>

@interface JTOperationWallet : NSProxy {
    id              _proxiedTarget;
    NSMutableArray *_invocations;
//    NSMutableArray *_results;
}

+ (JTOperationWallet *)wallet;

- (id)prepareWithInvocationTarget:(id)target;
//- (id)prepareWithInvocationTarget:(id)target result:(void *)result;

// Invoke synchronizely on the thread which triggers
- (void)invoke;

// Invoke on a seperated queue
- (void)invokeOnQueue:(NSOperationQueue *)queue waitUntilFinished:(BOOL)wait;

@end
