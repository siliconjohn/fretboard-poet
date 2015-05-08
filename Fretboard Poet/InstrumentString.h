#import <Foundation/Foundation.h>
#import "Notes.h"

@interface InstrumentString : NSObject
{
  @private
  NSNumber *lowNote;
  NSNumber *highNote;
}

@property (readonly, atomic) NSArray *notes;

- (void) setNotes:(NSNumber *)newLowNote newHighNote:(NSNumber *)newHighNote;
- (NSNumber *) getLowNote;
- (NSNumber *) getHighNote;

@end
