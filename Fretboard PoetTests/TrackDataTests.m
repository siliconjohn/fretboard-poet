#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TrackData.h"

@interface TrackDataTests : XCTestCase
{
  TrackData *trackData;
  NSString *dataFilePath;
}
@end

@implementation TrackDataTests

- (void) setUp
{
  [super setUp];
  trackData = [TrackData new];
  dataFilePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"testsong" ofType:@".json"];
}

- (void) testLoadedEvents
{
  [trackData  initNewTrack:dataFilePath trackIDObject:trackData];
  
  NSDictionary *dict = [trackData getEventsForTime: 0];
  if(![[dict valueForKey:@"key"]  isEqual:@"A"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"chord"]  isEqual:@"Amin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"scale"]  isEqual:@"Amin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"beat"]  isEqual:[NSNumber numberWithLong:1]]) XCTAssert(NO, @"Fail");
  
  dict = [trackData getEventsForTime: 1000];
  if(![[dict valueForKey:@"key"]  isEqual:@"B"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"chord"]  isEqual:@"Bmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"scale"]  isEqual:@"Bmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"beat"]  isEqual:[NSNumber numberWithLong:2]]) XCTAssert(NO, @"Fail");
  
  dict = [trackData getEventsForTime: 1999];
  if(![[dict valueForKey:@"key"]  isEqual:@"B"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"chord"]  isEqual:@"Bmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"scale"]  isEqual:@"Bmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"beat"]  isEqual:[NSNumber numberWithLong:2]]) XCTAssert(NO, @"Fail");
  
  dict = [trackData getEventsForTime: 2000];
  if(![[dict valueForKey:@"key"]  isEqual:@"C"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"chord"]  isEqual:@"Cmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"scale"]  isEqual:@"Cmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"beat"]  isEqual:[NSNumber numberWithLong:3]]) XCTAssert(NO, @"Fail");
  
  dict = [trackData getEventsForTime: 3000];
  if(![[dict valueForKey:@"key"]  isEqual:@"D"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"scale"]  isEqual:@"Dmin"]) XCTAssert(NO, @"Fail");
  if(![[dict valueForKey:@"beat"]  isEqual:[NSNumber numberWithLong:4]]) XCTAssert(NO, @"Fail");
  
  dict = [trackData getEventsForTime: 4000];
  if(![[dict valueForKey:@"chord"]  isEqual:@"Emin"]) XCTAssert(NO, @"Fail");
  
  if(![trackData->metaArtist isEqual:@"no artist"])XCTAssert(NO, @"Fail");
  if(![trackData->metaName isEqual:@"no name"])XCTAssert(NO, @"Fail");
  if(![trackData->metaKey isEqual:@"Amin"])XCTAssert(NO, @"Fail");
  if(![trackData->metaBPM isEqual:[NSNumber numberWithInt:60]])XCTAssert(NO, @"Fail");
  if(![trackData->metaDuration isEqual:[NSNumber numberWithDouble:30.44]])XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

- (void) testInitNewTrack
{
  if([trackData initNewTrack:dataFilePath trackIDObject:trackData] != true ) XCTAssert(NO, @"Fail");
  
  XCTAssert(YES, @"Pass");
}

@end
