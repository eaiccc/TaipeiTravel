//
//  TaipeiTravelTests.m
//  TaipeiTravelTests
//
//  Created by Mac on 2018/7/18.
//  Copyright © 2018年 Link. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MockTravelViewModelDelegate.h"
#import "TravelTableViewModel.h"
#import "MockApiService.h"
@interface TaipeiTravelTests : XCTestCase {
    MockTravelViewModelDelegate *mockDelegate;
    TravelTableViewModel *viewModel;
    MockApiService* mockApi;
}

@end

@implementation TaipeiTravelTests

- (void)setUp {
    [super setUp];
    mockDelegate = MockTravelViewModelDelegate.new;
    viewModel = [[TravelTableViewModel alloc]initWithDelegate:mockDelegate];
    mockApi = [MockApiService sharedDataManager];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    mockDelegate = nil;
    viewModel = nil;
    [super tearDown];
}

- (void)testSuccessFetch {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    viewModel.apiService = mockApi;
    [viewModel getTravelData];
    if (mockDelegate.isCallDataDidLoad == NO) {
        XCTFail(@"not call DataDidLoad");
    }
    if (mockDelegate.isCallShowHud == NO) {
        XCTFail(@"not call ShowHud");
    }
}
- (void)testFailFetch {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    viewModel.apiService = mockApi;
    mockApi.isFailFetch = YES;
    [viewModel getTravelData];
    if (mockDelegate.isCallGetDataFail == NO) {
        XCTFail(@"not call isCallGetDataFail");
    }
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
