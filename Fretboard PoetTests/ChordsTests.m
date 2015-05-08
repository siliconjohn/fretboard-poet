#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Chords.h"

@interface ChordsTests : XCTestCase

@end

@implementation ChordsTests

- (void)testChords
{
  Chords *chords= [Chords sharedChords];
  
  // test for major chord
  NSDictionary *dict = [[Chords sharedChords] getChord:@"major"];
  if( dict == nil ) XCTAssert( NO, @"Fail" );
  if( ![[dict objectForKey:@"name"] isEqualToString:@"major"] ) XCTAssert( NO, @"Fail" );
  
  dict = [chords getChord:@"major"];
  if( dict == nil ) XCTAssert( NO, @"Fail" );
  if( ![[dict objectForKey:@"name"] isEqualToString:@"major"] ) XCTAssert( NO, @"Fail" );
  
  if([[[Chords sharedChords] getNotesForChord:@"major" noteName:@"E"] count] != 31 ) XCTAssert( NO, @"Fail" );
  
  
  
  NSString *scale = [[Chords sharedChords] getNotesForChordInOneOctaveAsString:@"major" noteName:@"D"];
  if([scale isEqualToString:@"D  F♯  A"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Chords sharedChords] getNotesForChordInOneOctaveAsString:@"minor" noteName:@"D"];
  if([scale isEqualToString:@"D  F  A"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Chords sharedChords] getNotesForChordInOneOctaveAsString:@"minor9" noteName:@"C"];
  if([scale isEqualToString:@"C  E\u266D  G  B\u266D  D"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  // check for garbage
  if([[Chords sharedChords] getNotesForChord:@"majodr" noteName:@"E"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Chords sharedChords] getNotesForChord:@"majodr" noteName:@"fE"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Chords sharedChords] getNotesForChord:nil noteName:@"E"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Chords sharedChords] getNotesForChord:@"majodr" noteName:nil] != nil ) XCTAssert( NO, @"Fail" );
  
  NSLog(@"%@",[[Chords sharedChords] getNotesForChord:@"major" noteName:@"E"]);
  
  XCTAssert(YES, @"Pass");
}

@end
