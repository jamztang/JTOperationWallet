//
//  JTObjectProxy.h
//  JTOperationWallet
//
//  Created by James Tang on 11/10/2011.
//  Copyright (c) 2011 CUHK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTObjectProxy : NSProxy {
    NSMutableArray *_invocations;
    Class           _class;
}

@property (nonatomic, readonly) id proxiedTarget;

+ (JTObjectProxy *)proxyWithClass:(Class)aClass;

- (void)invokeWithTarget:(id)proxiedTarget;

@end
