#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Scales.h"

@interface ScalesTests : XCTestCase

@end

@implementation ScalesTests

- (void)testScales
{
  Scales *scales= [Scales sharedScales];
  
  // test for major scale
  NSDictionary *dict = [[Scales sharedScales] getScale:@"major"];
  if( dict == nil ) XCTAssert( NO, @"Fail" );
  if( ![[dict objectForKey:@"name"] isEqualToString:@"major"] ) XCTAssert( NO, @"Fail" );
  
  dict = [scales getScale:@"major"];
  if( dict == nil ) XCTAssert( NO, @"Fail" );
  if( ![[dict objectForKey:@"name"] isEqualToString:@"major"] ) XCTAssert( NO, @"Fail" );
  
  if([[[Scales sharedScales] getNotesForScale:@"major" noteName:@"E"] count] != 74 ) XCTAssert( NO, @"Fail" );
  if([[[Scales sharedScales] getNotesForScale:@"major" noteName:@"C"] count] != 75 ) XCTAssert( NO, @"Fail" );
  
  // check for garbage
  if([[Scales sharedScales] getNotesForScale:@"majodr" noteName:@"E"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Scales sharedScales] getNotesForScale:@"majodr" noteName:@"fE"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Scales sharedScales] getNotesForScale:nil noteName:@"E"] != nil ) XCTAssert( NO, @"Fail" );
  if([[Scales sharedScales] getNotesForScale:@"majodr" noteName:nil] != nil ) XCTAssert( NO, @"Fail" );
  if([[Scales sharedScales] getNotesForScale:@"major" noteName:@"E♭"] == nil ) XCTAssert( NO, @"Fail" );
  
  NSString *scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"major" noteName:@"D"];
  if([scale isEqualToString:@"D  E  F♯  G  A  B  C♯"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"major" noteName:@"A"];
  if([scale isEqualToString:@"A  B  C♯  D  E  F♯  G♯"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"major" noteName:@"C♯"];
  if([scale isEqualToString:@"C♯  D♯  F  F♯  G♯  A♯  C"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"major" noteName:@"B\u266D"];
  if([scale isEqualToString:@"B\u266D  C  D  E\u266D  F  G  A"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"minor" noteName:@"A"];
  if([scale isEqualToString:@"A  B  C  D  E  F  G"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"minor" noteName:@"B\u266D"];
  if([scale isEqualToString:@"B\u266D  C  D\u266D  E\u266D  F  G\u266D  A\u266D"] == FALSE ) XCTAssert( NO, @"Fail" );
  
  scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:@"minor" noteName:@"C♯"];
  if([scale isEqualToString:@"C♯  D♯  E  F♯  G♯  A  B"] == FALSE ) XCTAssert( NO, @"Fail" );
 
  NSArray *n = [[Scales sharedScales] getNotesForScale:@"major" noteName:@"C"];
  for(NSDictionary *d in n)
  {
    if([[d valueForKey:@"name"] localizedCaseInsensitiveContainsString:@"\u266D"] )  XCTAssert( NO, @"Fail" );
    if([[d valueForKey:@"name"] localizedCaseInsensitiveContainsString:@"\u266F"] )  XCTAssert( NO, @"Fail" );
    NSLog(@"%@, %@",[d valueForKey:@"name"],[d valueForKey:@"midi"]);
  }
  
  XCTAssert(YES, @"Pass");
}

@end
