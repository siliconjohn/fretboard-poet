#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TimeEvents.h"

@interface TimedEventsTest : XCTestCase
{
  TimeEvents *keyData, *emptyData;
}
@end

@implementation TimedEventsTest

- (void) setUp
{
  [super setUp];
  keyData = [TimeEvents new];
}

- (void) testAddTimeEvent
{
  if([keyData addTimeEvent:0 data:@"0"] != true ) XCTAssert(NO, @"Fail");
  if([keyData addTimeEvent:-1 data:@"0"] != false ) XCTAssert(NO, @"Fail");
  if([keyData addTimeEvent:0 data:nil] != false ) XCTAssert(NO, @"Fail");
  if([keyData addTimeEvent:LONG_MAX + 1 data:@"0"] != false ) XCTAssert(NO, @"Fail");
  XCTAssert(YES, @"Pass");
}

- (void) testGetTimeEvent
{
  if([keyData  getTimeEvent:0] != nil ) XCTAssert(NO, @"Fail");
  if([keyData  getTimeEvent:110] != nil ) XCTAssert(NO, @"Fail");
  
  [keyData addTimeEvent:0 data:@"0"];
  [keyData addTimeEvent:5000 data:@"5"];
  [keyData addTimeEvent:4000 data:@"4"];
  [keyData addTimeEvent:2000 data:@"2"];
  [keyData addTimeEvent:3000 data:@"3"];
  [keyData addTimeEvent:1000 data:@"1"];
  [keyData addTimeEvent:1000 data:@"1"];
  [keyData addTimeEvent:-1 data:@"0"];
  [keyData addTimeEvent:0 data:nil];
  
  if([keyData  getTimeEvent:-1] != nil ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:100]  isEqual: @"0"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:6000]  isEqual: @"5"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:1000]  isEqual: @"1"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:1001]  isEqual: @"1"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:1999]  isEqual: @"1"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:3000]  isEqual: @"3"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:4500]  isEqual: @"4"] ) XCTAssert(NO, @"Fail");
  if(![[keyData  getTimeEvent:5000]  isEqual: @"5"] ) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

- (void) testRemoveAllEvents
{
  [keyData addTimeEvent:3000 data:@"3"];
  [keyData addTimeEvent:1000 data:@"1"];
  [keyData removeAllEvents];
  if([keyData  getTimeEvent:110] != nil ) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

@end
