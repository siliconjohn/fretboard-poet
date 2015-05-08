#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "InstrumentString.h"

@interface GuitarStringTests : XCTestCase
{
  InstrumentString *string;
}

@end

@implementation GuitarStringTests

- (void)setUp
{
  string = [InstrumentString new];
  [super setUp];
}

- (void)tearDown
{
  [super tearDown];
}

- (void)testSetLowAndHighNotes
{
  [string setNotes:nil newHighNote:nil];
  if([string getHighNote] != nil) XCTAssert(NO, @"Fail");
  if([string getLowNote] != nil) XCTAssert(NO, @"Fail");
  
  string = [InstrumentString new];
  [string setNotes:[NSNumber numberWithInt:10] newHighNote:[NSNumber numberWithInt:1]];
  if([string getHighNote] != nil) XCTAssert(NO, @"Fail");
  if([string getLowNote] != nil) XCTAssert(NO, @"Fail");
  
  string = [InstrumentString new];
  [string setNotes:[NSNumber numberWithInt:1] newHighNote:[NSNumber numberWithInt:10]];
  if([string getHighNote] != [NSNumber numberWithInt:10]) XCTAssert(NO, @"Fail");
  if([string getLowNote] != [NSNumber numberWithInt:1]) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

- (void) testSetUpNotes
{
  [string setNotes:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
  if(![[[string.notes objectAtIndex:0] valueForKey:@"note"] isEqualToString:@"E1"]) XCTAssert(NO, @"Fail");
  if(![[[string.notes objectAtIndex:24] valueForKey:@"note"] isEqualToString:@"E3"]) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}





@end
