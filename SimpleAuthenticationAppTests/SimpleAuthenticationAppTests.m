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

@interface SimpleAuthenticationAppTests : XCTestCase

@property (nonatomic) AuthPresenter *presenter;
@property (nonatomic) AuthViewController *view;
//@property (nonatomic) AuthServerManager *serverManager;

@end

@implementation SimpleAuthenticationAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _presenter = [[AuthPresenter alloc] init];
    _view = [[AuthViewController alloc] init];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testInitResultNotNil{
    //id presenterTest = nil;
    id presenterTest = [_presenter initWithView:nil];
    XCTAssertNotNil(presenterTest);
    
}


-(void) testPresenter{
    
    void (^block)() = ^{
        [_presenter getAuthInfoFromModel:nil];
    };
    XCTAssertNoThrow(block());
    
   
    void (^block2)() = ^{
        [_presenter setEnterDataInfoToView:nil];
    };
    
    XCTAssertNoThrow(block2());
}



-(void) testServerManagerMethodCall{
    
    NSURL *url = [NSURL URLWithString:@"http://localhost:4567"];
    _presenter.serverManager = [[AuthServerManager alloc] initWithUrl:url];
    
    void (^serverBlock)() = ^{[_presenter.serverManager getAuthInfoFromServer:^(NSDictionary* dictFromServer){
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
