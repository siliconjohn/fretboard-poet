#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Notes.h"

@interface NotesTests : XCTestCase
{
}
@end

@implementation NotesTests

- (void) testNotes
{
  Notes *notes = [Notes sharedNotes];
  
  if( notes.noteDict == nil ) XCTAssert( NO, @"Fail" );
  if( notes.noteDict.count != 128 ) XCTAssert( NO, @"Fail" );
  if( notes.noteArray == nil ) XCTAssert( NO, @"Fail" );
  if( notes.noteArray.count != 128 ) XCTAssert( NO, @"Fail" );
  
  // test middle c
  NSDictionary *middleC = notes.noteArray[48];
  if(! [[middleC objectForKey:@"note"]  isEqual: @"C3"] ) XCTAssert( NO, @"Fail" );
  if(! [[[notes.noteDict objectForKey:@"C3"] objectForKey:@"note"] isEqual: @"C3"] ) XCTAssert( NO, @"Fail" );
  
  if(![[Notes flatToSharpNote:@"D\u266D"] isEqualToString:@"C\u266F"]) XCTAssert( NO, @"Fail" );
  if(![[Notes flatToSharpNote:@"E\u266D"] isEqualToString:@"D\u266F"]) XCTAssert( NO, @"Fail" );
  if(![[Notes flatToSharpNote:@"G\u266D"] isEqualToString:@"F\u266F"]) XCTAssert( NO, @"Fail" );
  if(![[Notes flatToSharpNote:@"A\u266D"] isEqualToString:@"G\u266F"]) XCTAssert( NO, @"Fail" );
  if(![[Notes flatToSharpNote:@"B\u266D"] isEqualToString:@"A\u266F"]) XCTAssert( NO, @"Fail" );
  
  if([notes.noteTable count] != 48) XCTAssert( NO, @"Fail" );
  NSLog(@"%@",notes.noteTable);
  
  XCTAssert(YES, @"Pass");
}
@end
