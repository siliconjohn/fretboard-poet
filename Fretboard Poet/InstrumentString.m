#import "InstrumentString.h"

@implementation InstrumentString

@synthesize notes = _notes;

- (void) setNotes:(NSNumber *)newLowNote newHighNote:(NSNumber *)newHighNote
{
  if( !newLowNote || !newHighNote ) return;
  if( newLowNote > newHighNote ) return;
  if( newLowNote < [NSNumber numberWithInt:0] || newLowNote > [NSNumber numberWithInt:128] ) return;
  if( newHighNote < [NSNumber numberWithInt:0] || newHighNote > [NSNumber numberWithInt:128] ) return;
  
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
