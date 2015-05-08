#import <Foundation/Foundation.h>
#import "Notes.h"
#import "InstrumentString.h"

@interface StringInstrument : NSObject
{
  NSMutableArray *strings;
}

- (InstrumentString *) addString:(NSNumber *)newLowNote newHighNote:(NSNumber *)newHighNote;
- (NSArray *) getStrings;

@end
