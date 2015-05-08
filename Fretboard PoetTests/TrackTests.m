#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Track.h"
#import "StringInstrument.h"
#import "Notes.h"

@interface TrackTests : XCTestCase
{
  Track *track;
  NSString *dataFilePath;
  NSString *songFilePath;
}
@end

@implementation TrackTests

- (void)setUp
{
  [super setUp];
  track = [Track new];
  dataFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testsong" ofType:@".json"];
  songFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testsong" ofType:@".mp3"];
}

- (void)testInitNewTrack
{
  if([track initNewTrack:songFilePath dataPath:dataFilePath] != true ) XCTAssert(NO, @"Fail");
  if([track initNewTrack:@"nofile" dataPath:@"nofile"] != false ) XCTAssert(NO, @"Fail");
  if([track initNewTrack:nil dataPath:dataFilePath] != false ) XCTAssert(NO, @"Fail");
  if([track initNewTrack:songFilePath dataPath:nil] != false ) XCTAssert(NO, @"Fail");
  if([track initNewTrack:nil dataPath:nil] != false ) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}
 
@end
