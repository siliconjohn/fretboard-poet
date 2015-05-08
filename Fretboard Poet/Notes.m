#import "Notes.h"

#define flatSymbol [NSString stringWithFormat:@"\u266D"]
#define sharpSymbol [NSString stringWithFormat:@"\u266F"]

@implementation Notes

@synthesize noteDict = _noteDict, noteArray = _noteArray, noteTable = _noteTable;

- (id) init
{
  if(self = [super init])
  {
    _noteTable = [NSArray  arrayWithObjects: @"C", @"C\u266F", @"D", @"D\u266F", @"E", @"F", @"F\u266F",  @"G", @"G\u266F", @"A", @"A\u266F", @"B", @"C", @"C\u266F", @"D", @"D\u266F", @"E", @"F", @"F\u266F", @"G", @"G\u266F", @"A", @"A\u266F", @"B", @"C", @"C\u266F", @"D", @"D\u266F", @"E",  @"F", @"F\u266F", @"G", @"G\u266F", @"A", @"A\u266F", @"B", @"C", @"C\u266F", @"D", @"D\u266F", @"E", @"F", @"F\u266F", @"G", @"G\u266F", @"A", @"A\u266F", @"B", nil];
  
    [self createNotes];
  }
  return self;
}

+ (Notes *) sharedNotes
{
  static Notes *sharedNotes = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedNotes = [[self alloc] init];
  });
  
  return sharedNotes;
}

+ (NSDictionary *) noteDict
{
  Notes *temp = [Notes sharedNotes];
  return temp.noteDict;
}

+ (NSArray *) noteArray
{
  Notes *temp = [Notes sharedNotes];
  return temp.noteArray;
}

+ (NSDictionary *) getNoteForMidiNumber:(int) midiNumber
{
  if( midiNumber < 0 || midiNumber > 128 ) return nil;
  return [[Notes sharedNotes].noteArray objectAtIndex:midiNumber];
}

- (void) createNotes
{
  int noteCounter = 0;
  int octaveCounter = -1;
  NSMutableArray *temp = [NSMutableArray new];
  NSMutableArray *keys = [NSMutableArray new];
  
  for(int i=0;i<128;i++)
  {
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    switch (noteCounter)
    {
      case 0:
        [dict setValue:@"C" forKey:@"name"];
        [dict setValue:@"C" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"C%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 1:
        [dict setValue:[NSString stringWithFormat:@"C%@",sharpSymbol] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"D%@",flatSymbol] forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"C%@%d",sharpSymbol,octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[NSString stringWithFormat:@"%@/%@",[dict valueForKey:@"name"],[dict valueForKey:@"flatname"]] forKey:@"fullname"];
        break;
      case 2:
        [dict setValue:@"D" forKey:@"name"];
        [dict setValue:@"D" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"D%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 3:
        [dict setValue:[NSString stringWithFormat:@"D%@",sharpSymbol] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"E%@",flatSymbol] forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"D%@%d",sharpSymbol,octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[NSString stringWithFormat:@"%@/%@",[dict valueForKey:@"name"],[dict valueForKey:@"flatname"]] forKey:@"fullname"];
        break;
      case 4:
        [dict setValue:@"E" forKey:@"name"];
        [dict setValue:@"E" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"E%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 5:
        [dict setValue:@"F" forKey:@"name"];
        [dict setValue:@"F" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"F%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 6:
        [dict setValue:[NSString stringWithFormat:@"F%@",sharpSymbol] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"G%@",flatSymbol] forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"F%@%d",sharpSymbol,octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[NSString stringWithFormat:@"%@/%@",[dict valueForKey:@"name"],[dict valueForKey:@"flatname"]] forKey:@"fullname"];
        break;
      case 7:
        [dict setValue:@"G" forKey:@"name"];
        [dict setValue:@"G" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"G%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 8:
        [dict setValue:[NSString stringWithFormat:@"G%@",sharpSymbol] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"A%@",flatSymbol] forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"G%@%d",sharpSymbol,octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[NSString stringWithFormat:@"%@/%@",[dict valueForKey:@"name"],[dict valueForKey:@"flatname"]] forKey:@"fullname"];
        break;
      case 9:
        [dict setValue:@"A" forKey:@"name"];
        [dict setValue:@"A" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"A%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
      case 10:
        [dict setValue:[NSString stringWithFormat:@"A%@",sharpSymbol] forKey:@"name"];
        [dict setValue:[NSString stringWithFormat:@"B%@",flatSymbol] forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"A%@%d",sharpSymbol,octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[NSString stringWithFormat:@"%@/%@",[dict valueForKey:@"name"],[dict valueForKey:@"flatname"]] forKey:@"fullname"];
        break;
      case 11:
        [dict setValue:@"B" forKey:@"name"];
        [dict setValue:@"B" forKey:@"flatname"];
        [dict setValue:[NSNumber numberWithInt:i] forKey:@"midi"];
        [dict setValue:[NSString stringWithFormat:@"B%d",octaveCounter] forKey:@"note"];
        [dict setValue:[NSString stringWithFormat:@"%d",octaveCounter] forKey:@"octave"];
        [dict setValue:[dict valueForKey:@"name"] forKey:@"fullname"];
        break;
    }
    
    [temp addObject:dict];
    [keys addObject:[dict valueForKey:@"note"]];
    
    noteCounter++;
    
    if(noteCounter>11)
    {
      noteCounter = 0;
      octaveCounter++;
    }
  }

  _noteArray = [NSArray arrayWithArray:temp];
  _noteDict = [NSDictionary dictionaryWithObjects:temp forKeys:keys];
}

+ (NSString *) flatToSharpNote:(NSString *) noteName
{
  if( noteName == nil ) return nil;
  
  NSString *result = noteName;
  
  // if is a flat note, find sharp equivelent because this is how we roll
  if([noteName localizedCaseInsensitiveContainsString:@"\u266D"] )
  {
    if( [noteName isEqualToString:@"D\u266D"] ) result = @"C\u266F";else
      if( [noteName isEqualToString:@"E\u266D"] ) result = @"D\u266F";else
        if( [noteName isEqualToString:@"G\u266D"] ) result = @"F\u266F";else
          if( [noteName isEqualToString:@"A\u266D"] ) result = @"G\u266F";else
            if( [noteName isEqualToString:@"B\u266D"] ) result = @"A\u266F";
  }
  
  return result;
}

@end
