#import "InstrumentString.h"

@implementation InstrumentString

@synthesize notes = _notes;

- (void) setNotes:(NSNumber *)newLowNote newHighNote:(NSNumber *)newHighNote
{
  if( !newLowNote || !newHighNote ) return;
  
  int low = [newLowNote intValue];
  int high = [newHighNote intValue];
  
  if( low > high ) return;
  if( low < 0 || low > 128 ) return;
  if( high < 0 || high > 128 ) return;
  
  lowNote = newLowNote;
  highNote = newHighNote;
  
  [self setUpNotes];
}

- (NSArray *) setUpNotes
{
  if( !lowNote || !highNote ) return nil;
  
  NSMutableArray *tempNotes = [NSMutableArray new];

  for(int i = [lowNote intValue]; i <= [highNote intValue]; i++ )
    [tempNotes addObject:[[Notes getNoteForMidiNumber:i] mutableCopy]];
  
  _notes = [NSArray arrayWithArray:tempNotes];
  
  return self.notes;
}

- (NSNumber *) getLowNote
{
  return lowNote;
}

- (NSNumber *) getHighNote
{
  return highNote;
}

@end
