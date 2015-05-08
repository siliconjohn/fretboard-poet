#import <Foundation/Foundation.h>
#import "PatternMatcher.h"

@interface Scales : PatternMatcher

+ (Scales *) sharedScales;

- (NSDictionary *) getScale:(NSString *) scaleName;
- (NSArray *) getNotesForScale:(NSString *) scaleName noteName:(NSString *) noteName;
- (NSArray *) getNotesForScale:(NSString *) scaleAndNoteName;
- (NSArray *) getNotesForScaleInOneOctave:(NSString *) scaleName noteName:(NSString *) noteName;
- (NSString *) getNotesForScaleInOneOctaveAsString:(NSString *) scaleName noteName:(NSString *)noteName;

@end

