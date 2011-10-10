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
#import "JTObjectProxy.h"

@implementation JTOperationWalletTests

@synthesize result;

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

#pragma mark Helper

- (void)setResultWithDict:(NSDictionary *)dict {
    [self setResult:[dict objectForKey:@"firstObject"]];
}

#pragma mark Tests

- (void)testInvoke {
    NSMutableArray *anArray = [NSMutableArray array];

    JTWalletHolder *holder = [[JTWalletHolder alloc] init];
    
    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"1"];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"2"];

    holder.completionWallet = wallet;
    
    STAssertEqualObjects(anArray, [NSMutableArray array], @"holder should have not executed the operations until setComplete is invoked", nil);

    [wallet invoke];

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
    queue.maxConcurrentOperationCount = 1;
    [wallet invokeOnQueue:queue waitUntilFinished:YES];

    NSMutableArray *expectedArray = [NSMutableArray arrayWithObjects:@"1", @"2", nil];

    STAssertEqualObjects(anArray, expectedArray, @"[holder setComplete] should have executed the operation", nil);
}

- (void)testSimulateCompletion {
    JTWalletHolder *holder = [[JTWalletHolder alloc] init];

    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:self] setResultWithDict:holder.futureDict];

    holder.completionWallet = wallet;

    STAssertEqualObjects(self.result, nil, nil, nil);

    [holder setComplete];

    STAssertEqualObjects(self.result, @"1", nil, nil);
}

@end
