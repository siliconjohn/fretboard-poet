#import "Chords.h" 

@implementation Chords

- (id) init
{
  if(self = [super init])
  {
    [self createPatterns];
  }
  return self;
}

+ (Chords *) sharedChords
{
  static Chords *sharedChords = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedChords = [[self alloc] init];
  });
  
  return sharedChords;
}

-(void) createPatterns
{
  NSMutableDictionary *temp = [NSMutableDictionary new];
  
  // major
  NSMutableDictionary *dict = [NSMutableDictionary new];
  [dict setValue:@"major" forKey:@"name"];
  NSMutableDictionary *intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:4] forKey:@"3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
 
  // major 7
  dict = [NSMutableDictionary new];
  [dict setValue:@"major7" forKey:@"name"];
  intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:4] forKey:@"3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals setValue:[NSNumber numberWithInt:11] forKey:@"7"];
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
  
  
  // dom 7
  dict = [NSMutableDictionary new];
  [dict setValue:@"dom7" forKey:@"name"];
  intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:4] forKey:@"3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals setValue:[NSNumber numberWithInt:10] forKey:@"-7"];
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
  
  // minor
  dict = [NSMutableDictionary new];
  [dict setValue:@"minor" forKey:@"name"];
  intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:3] forKey:@"-3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
  
  // minor 7
  dict = [NSMutableDictionary new];
  [dict setValue:@"minor7" forKey:@"name"];
  intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:3] forKey:@"-3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals setValue:[NSNumber numberWithInt:10] forKey:@"-7"];
  
  // minor 9
  dict = [NSMutableDictionary new];
  [dict setValue:@"minor9" forKey:@"name"];
  intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:3] forKey:@"-3"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals setValue:[NSNumber numberWithInt:10] forKey:@"-7"];
  [intervals setValue:[NSNumber numberWithInt:14] forKey:@"9"];
  
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
  
  // finsh
  _patternDict = [NSDictionary dictionaryWithDictionary:temp];
}

- (NSDictionary *) getChord:(NSString *) chordName
{
  return [_patternDict objectForKey:chordName];
}

- (NSArray *) getNotesForChord:(NSString *) chordName noteName:(NSString *) noteName;
{
  return [self getNotesForPattern:chordName noteName:noteName];
}

- (NSArray *) getNotesForChord:(NSString *) chordAndNoteName;
{
  if(chordAndNoteName == nil) return nil;
  
  NSArray *pieces = [chordAndNoteName componentsSeparatedByString:@" "];
  
  if([pieces count] > 1)
    return [self getNotesForChord:pieces[1] noteName: pieces[0]];
  
  return nil;
}

- (NSArray *) getNotesForChordInOneOctave:(NSString *) chordName noteName:(NSString *) noteName;
{
  NSArray *notes = [self getNotesForPattern:chordName noteName:noteName];
  if(notes == nil ) return nil;
  
  NSMutableArray *result = [ NSMutableArray new];
  bool startedChord = false;
  
  for(NSDictionary *note in notes)
  {
    if([[note valueForKey:@"name"] isEqualToString:noteName] || [[note valueForKey:@"flatname"] isEqualToString:noteName])
    {
      if( startedChord == true) break;
      if( startedChord == false ) startedChord = true;
    }
    
    if( startedChord == true )
      [result addObject:note];
  }
  
  return [NSArray arrayWithArray:result];
}

- (NSString *) getNotesForChordInOneOctaveAsString:(NSString *) chordName noteName:(NSString *) noteName;
{
  NSArray *tempnotes = [self getNotesForChordInOneOctave:chordName noteName:noteName];
  if(tempnotes == nil ) return nil;
  
  // sort notes by interval
  NSArray *notes = [tempnotes sortedArrayUsingComparator:
                   ^NSComparisonResult( id obj1, id obj2 )
                   {
                     if ([[obj1 valueForKey:@"interval"]intValue] < [[obj2 valueForKey:@"interval"]intValue])
                     {
                       return NSOrderedAscending;
                     }
                     else
                     if ([[obj1 valueForKey:@"interval"]intValue] > [[obj2 valueForKey:@"interval"]intValue])
                     {
                       return NSOrderedDescending;
                     }
                     else
                     {
                       return NSOrderedSame;
                     }
                  }];
  
  NSString *result = nil;
  
  // todo add sort by interval here
  
  bool useSharpName = true;
  
  if( [noteName localizedCaseInsensitiveContainsString:@"\u266D"] ) useSharpName = false;
  else
    if( [noteName localizedCaseInsensitiveContainsString:@"\u266F"] ) useSharpName = true;
    else
      if( [chordName rangeOfString:@"minor"].location != NSNotFound ) useSharpName = false;
  
  for(NSDictionary *note in notes)
  {
    NSString *r;
    
    if( useSharpName )
      r = [note valueForKey:@"name"];
    else
      r = [note valueForKey:@"flatname"];
    
    if([result localizedCaseInsensitiveContainsString:r] == false)
    {
      if(!result)
        result = r;
      else
        result = [NSString stringWithFormat:@"%@  %@",result,r];
    }
  }
  
  return result;
}

@end
