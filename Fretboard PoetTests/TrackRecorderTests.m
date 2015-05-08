#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TrackRecorder.h"

@interface TrackRecorderTests : XCTestCase
{
  TrackRecorder *trackRecorder;
  NSString *dataFilePath;
  NSString *songFilePath;
}

@end

@implementation TrackRecorderTests

- (void)setUp
{
  trackRecorder = [TrackRecorder new];
  dataFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testsong" ofType:@".json"];
  songFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testsong" ofType:@".mp3"];
}

- (void)testInitNewTrack
{
  if([trackRecorder initNewTrack:songFilePath dataPath:dataFilePath] != true ) XCTAssert(NO, @"Fail");
  if([trackRecorder initNewTrack:@"nofile" dataPath:@"nofile"] != false ) XCTAssert(NO, @"Fail");
  if([trackRecorder initNewTrack:nil dataPath:dataFilePath] != false ) XCTAssert(NO, @"Fail");
  if([trackRecorder initNewTrack:songFilePath dataPath:nil] != false ) XCTAssert(NO, @"Fail");
  if([trackRecorder initNewTrack:nil dataPath:nil] != false ) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

@end
