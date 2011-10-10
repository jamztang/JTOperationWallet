//
//  JTWalletHolder.h
//  JTOperationWallet
//
//  Created by james on 10/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JTOperationWallet;
@class JTObjectProxy;

@interface JTWalletHolder : NSObject {
    NSDictionary *_dict;
    JTObjectProxy *_futureDict;
}

@property (nonatomic, retain) JTOperationWallet *completionWallet;
@property (nonatomic, readonly) NSDictionary *futureDict;

- (void)setComplete;

@end
