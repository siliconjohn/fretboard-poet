#import <Foundation/Foundation.h>

@interface Notes : NSObject

@property (readonly, atomic) NSDictionary *noteDict;
@property (readonly, atomic) NSArray *noteArray;
@property (readonly, atomic) NSArray *noteTable;

+ (Notes *) sharedNotes;

+ (NSDictionary *) noteDict;
+ (NSDictionary *) noteArray;

+ (NSString *) flatToSharpNote:(NSString *) noteName;
+ (NSDictionary *) getNoteForMidiNumber:(int) midiNumber;

@end
