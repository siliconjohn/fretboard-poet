#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Notes.h"
#import "StringInstrument.h"
#import "InstrumentString.h"

@interface FretboardTests : XCTestCase
{
  StringInstrument *fretboard;
}
@end

@implementation FretboardTests

- (void)setUp
{
  fretboard = [StringInstrument new];
  [super setUp];
}

- (void)testCreateStrings
{
  // test for nil string
  InstrumentString *test = [fretboard addString:nil newHighNote:[NSNumber numberWithInt:52]];
  if( test != nil ) XCTAssert(NO, @"Fail");
  
  // test creating A string
  test = [fretboard addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
  if( test == nil ) XCTAssert(NO, @"Fail");
  
  // test creating D string
  test = [fretboard addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:65]];
  if( test == nil ) XCTAssert(NO, @"Fail");
  
  // test createing E string
  test = [fretboard addString:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
  if( test == nil ) XCTAssert(NO, @"Fail");
  
  // test string sorting- low to high
  if([[[fretboard getStrings] firstObject] getLowNote] != [NSNumber numberWithInt:38]) XCTAssert(NO, @"Fail");
  if([[[fretboard getStrings] lastObject] getLowNote] != [NSNumber numberWithInt:28]) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

@end
