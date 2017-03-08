//
//  SimpleAuthenticationAppTests.m
//  SimpleAuthenticationAppTests
//
//  Created by Elerman on 23.02.17.
//  Copyright © 2017 Elerman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AuthPresenter.h"
#import "AuthViewController.h"
#import "AuthAppProtocol.h"
#import "AuthServerManager.h"
#import "OCMock.h"

@interface SimpleAuthenticationAppTests : XCTestCase

@property (nonatomic) AuthPresenter *presenter;
@property (nonatomic) AuthViewController *view;
//@property (nonatomic) AuthServerManager *serverManager;

@end

@implementation SimpleAuthenticationAppTests

- (void)setUp {
    [super setUp];
    
    _view = [[AuthViewController alloc] init];

    _presenter = [[AuthPresenter alloc] initWithView:_view];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testInitResultNotNil{
    
    id presenterTest = [_presenter initWithView:nil];
    XCTAssertNotNil(presenterTest);
    
}


-(void) testPresenter{
    
    void (^block)() = ^{
        [_presenter getAuthInfoFromModel:nil];
         id mockClassView = OCMClassMock([AuthViewController class]);
         OCMExpect([mockClassView showCredentialError]);
         [mockClassView showCredentialError];
         OCMVerifyAll(mockClassView);
    };
    XCTAssertNoThrow(block());
    
   
    void (^block2)() = ^{
        [_presenter setEnterDataInfoToView:nil];
    };
    
    XCTAssertNoThrow(block2());
}



-(void) testServerManagerMethodCall{
    
    id servManager = [AuthServerManager sharedManager];
    XCTAssertNotNil(servManager);
    
    void (^serverBlock)() = ^{[[AuthServerManager sharedManager] getAuthInfoFromServer:^(NSDictionary* dictFromServer){
        XCTAssertNotNil(dictFromServer);
        
    }
                                                                             onFailure:^(NSError *error){
                                                                             }];
    };
    
    XCTAssertNoThrow(serverBlock());
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
