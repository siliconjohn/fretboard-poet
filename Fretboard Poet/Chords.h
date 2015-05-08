#import <Foundation/Foundation.h>
#import "PatternMatcher.h"

@interface Chords : PatternMatcher

+ (Chords *) sharedChords;

- (NSDictionary *) getChord:(NSString *) chordName;
- (NSArray *) getNotesForChord:(NSString *) chordName noteName:(NSString *) noteName;
- (NSArray *) getNotesForChord:(NSString *) chordAndNoteName;
- (NSArray *) getNotesForChordInOneOctave:(NSString *) chordName noteName:(NSString *) noteName;
- (NSString *) getNotesForChordInOneOctaveAsString:(NSString *) chordName noteName:(NSString *) noteName;

@end
