#import <Foundation/Foundation.h>
#import "Notes.h"

@interface PatternMatcher : NSObject
{
  NSDictionary *_patternDict;
}

- (void) createPatterns;
- (NSArray *) getNotesForPattern:(NSString *) patternName noteName:(NSString *) noteName;

@end
