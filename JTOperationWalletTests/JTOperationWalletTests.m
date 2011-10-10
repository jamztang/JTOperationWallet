//
//  JTOperationWalletTests.m
//  JTOperationWalletTests
//
//  Created by james on 10/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "JTOperationWalletTests.h"
#import "JTOperationWallet.h"
#import "JTWalletHolder.h"

@implementation JTOperationWalletTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testInvoke {
    NSMutableArray *anArray = [NSMutableArray array];

    JTWalletHolder *holder = [[JTWalletHolder alloc] init];
    
    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"1"];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"2"];

    holder.completionWallet = wallet;
    
    STAssertEqualObjects(anArray, [NSMutableArray array], @"holder should have not executed the operations until setComplete is invoked", nil);

    [holder setComplete];

    NSMutableArray *expectedArray = [NSMutableArray arrayWithObjects:@"1", @"2", nil];

    STAssertEqualObjects(anArray, expectedArray, @"[holder setComplete] should have executed the operation", nil);
}

- (void)testInvokeOnQueue {
    NSMutableArray *anArray = [NSMutableArray array];

    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"1"];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"2"];

    STAssertEqualObjects(anArray, [NSMutableArray array], @"holder should have not executed the operations until setComplete is invoked", nil);

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [wallet invokeOnQueue:queue waitUntilFinished:YES];

    NSMutableArray *expectedArray = [NSMutableArray arrayWithObjects:@"1", @"2", nil];

    STAssertEqualObjects(anArray, expectedArray, @"[holder setComplete] should have executed the operation", nil);
}

@end
