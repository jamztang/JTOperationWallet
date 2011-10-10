//
//  JTOperationWallet.h
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

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
