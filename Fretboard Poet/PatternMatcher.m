#import "PatternMatcher.h"
#import "Notes.h"

@implementation PatternMatcher

// to be overridding in child classes
- (void) createPatterns
{
}

- (NSArray *) getNotesForPattern:(NSString *) patternName noteName:(NSString *) noteName;
{
  if( patternName == nil || noteName == nil || _patternDict == nil ) return nil;
  
  // replace # with proper sharp symbol, uppercase letter (just in case)
  noteName = [[noteName stringByReplacingOccurrencesOfString:@"#" withString:@"\u266F"]uppercaseString];
 
  // convert flat to sharp
  noteName = [Notes flatToSharpNote:noteName];
  
  NSDictionary *pattern = [_patternDict objectForKey:patternName];
  if( pattern == nil ) return nil;
  
  NSMutableArray *notesInPattern = [NSMutableArray new];
  NSUInteger startingNoteIndex = -1;
  NSArray *noteTable = [Notes sharedNotes].noteTable;
  NSMutableDictionary *intervalNumbers = [NSMutableDictionary new];
  
  // add root
  for (NSString *object in noteTable)
  {
    if([object isEqualToString:noteName])
    {
      startingNoteIndex = [noteTable indexOfObject:object];
      
      [notesInPattern addObject:object];
      [intervalNumbers setObject:[NSNumber numberWithInt:1] forKey:object];
      break;
    }
  }
  
  if( startingNoteIndex == -1 ) return nil;
  
  // intervals
  NSArray *intervals = [pattern objectForKey:@"intervals"];
  
  for (id object in intervals)
  {
    int inc = [(NSNumber*)[intervals valueForKey:object] intValue];
    if ( inc < 1 || inc > 24 ) continue;
    
    NSString *newNote = [noteTable objectAtIndex: startingNoteIndex + inc];
    
    if([notesInPattern indexOfObject:newNote] == NSNotFound )
    {
      [notesInPattern addObject:newNote];
      [intervalNumbers setObject:[NSNumber numberWithInt:inc] forKey:newNote];
    }
  }
  
  // get all  notes
  NSMutableArray *result = [ NSMutableArray new];
  
  for(NSDictionary *queryNote in [Notes noteArray])
  {
    for(NSString *keyName in notesInPattern)
    {
      if([keyName isEqualToString:[queryNote valueForKey:@"name"]])
      {
        [queryNote setValue:[intervalNumbers valueForKey:[queryNote valueForKey:@"name"]] forKey:@"interval"];
        [result addObject:queryNote];
      }
    }
  }
  
  return [NSArray arrayWithArray:result];
}

@end