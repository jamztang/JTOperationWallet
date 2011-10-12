JTOperationWallet
=================
An objective-c NSProxy based library for simulating what blocks offer, an iOS 3 compatible alternative solution to blocks.


Installation
------------
Include files in JTOperationWallet/lib/ into your project


Usage
-----
# Sceniaro 1

    NSMutableArray *anArray = [NSMutableArray array];

    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"1"];
    [[wallet prepareWithInvocationTarget:anArray] addObject:@"2"];
    <your_object>.completionWallet = wallet;

    [<your_object> setComplete];	// Invoking [wallet invoke]; inside your object implementation

    /*
    // Equavent code in form of blocks

    __block NSMutableArray *anArray = [NSMutableArray array];
    [<your_object> setCompletionBlock:^(void) {
       [anArray addObject:1];
       [anArray addObject:2];
    }];

    [<your_object> setComplete];

    */

# Sceniaro 2

    JTOperationWallet *wallet = [JTOperationWallet wallet];
    [[wallet prepareWithInvocationTarget:self] printResponse:[<your_object> futureResponse]];
    <your_object>.completionWallet = wallet;

    [<your_object> setComplete];	// Invoking [wallet invoke]; inside your object implementation

    /*
    // Equavent code in form of blocks

    [<your_object> setCompletionBlock:^(NSDictionary *response) {
        [self printResponse:response];
    }];

    [<your_object> setComplete];

    */
