#import "Scales.h"

@implementation Scales

- (id) init
{
  if(self = [super init])
  {
    [self createPatterns];
  }
  return self;
}

+ (Scales *) sharedScales
{
  static Scales *sharedScales = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    sharedScales = [[self alloc] init];
  });
  
  return sharedScales;
}

-(void) createPatterns
{
  NSMutableDictionary *temp = [NSMutableDictionary new];
  
  // major
  NSMutableDictionary *dict = [NSMutableDictionary new];
  [dict setValue:@"major" forKey:@"name"];
  NSMutableDictionary *intervals = [NSMutableDictionary new];
  [intervals setValue:[NSNumber numberWithInt:2] forKey:@"2"];
  [intervals setValue:[NSNumber numberWithInt:4] forKey:@"3"];
  [intervals setValue:[NSNumber numberWithInt:5] forKey:@"4"];
  [intervals setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals setValue:[NSNumber numberWithInt:9] forKey:@"6"];
  [intervals setValue:[NSNumber numberWithInt:11] forKey:@"7"];
  [dict setValue:intervals forKey:@"intervals"];
  [temp setValue:dict forKey:[dict valueForKey:@"name"]];
  
  NSMutableDictionary *dict2 = [NSMutableDictionary new];
  [dict2 setValue:@"minor" forKey:@"name"];
  NSMutableDictionary *intervals2= [NSMutableDictionary new];
  [intervals2 setValue:[NSNumber numberWithInt:2] forKey:@"2"];
  [intervals2 setValue:[NSNumber numberWithInt:3] forKey:@"3"];
  [intervals2 setValue:[NSNumber numberWithInt:5] forKey:@"4"];
  [intervals2 setValue:[NSNumber numberWithInt:7] forKey:@"5"];
  [intervals2 setValue:[NSNumber numberWithInt:8] forKey:@"-6"];
  [intervals2 setValue:[NSNumber numberWithInt:10] forKey:@"7"];
  [dict2 setValue:intervals2 forKey:@"intervals"];
  [temp setValue:dict2 forKey:[dict2 valueForKey:@"name"]];

  // finsh
  _patternDict = [NSDictionary dictionaryWithDictionary:temp];
}

- (NSDictionary *) getScale:(NSString *) scaleName
{
  return [_patternDict objectForKey:scaleName];
}

- (NSArray *) getNotesForScale:(NSString *) scaleAndNoteName;
{
  if(scaleAndNoteName == nil) return nil;
  
  NSArray *pieces = [scaleAndNoteName componentsSeparatedByString:@" "];
  
  if([pieces count] > 1)
    return [self getNotesForScale:pieces[1] noteName: pieces[0]];

  return nil;
}

- (NSArray *) getNotesForScale:(NSString *) scaleName noteName:(NSString *) noteName;
{
  return [self getNotesForPattern:scaleName noteName:noteName];
}

- (NSArray *) getNotesForScaleInOneOctave:(NSString *) scaleName noteName:(NSString *) noteName;
{
  NSArray *notes = [self getNotesForPattern:scaleName noteName:noteName];
  if(notes == nil ) return nil;
  
  NSMutableArray *result = [ NSMutableArray new];
  bool startedScale = false;
  
  for(NSDictionary *note in notes)
  {
    if([[note valueForKey:@"name"] isEqualToString:noteName] || [[note valueForKey:@"flatname"] isEqualToString:noteName])
    {
      if( startedScale == true)break;
      if( startedScale == false ) startedScale = true;
    }
    
    if( startedScale == true )
      [result addObject:note];
  }

  return [NSArray arrayWithArray:result];
}

- (NSString *) getNotesForScaleInOneOctaveAsString:(NSString *) scaleName noteName:(NSString *) noteName;
{
  NSArray *notes = [self getNotesForScaleInOneOctave:scaleName noteName:noteName];
  if(notes == nil ) return nil;
  
  NSString *result = nil;
  
  bool useSharpName = true;
  
  if( [noteName localizedCaseInsensitiveContainsString:@"\u266D"] ) useSharpName = false;
  else
    if( [noteName localizedCaseInsensitiveContainsString:@"\u266F"] ) useSharpName = true;
    else
      if( [scaleName rangeOfString:@"minor"].location != NSNotFound ) useSharpName = false;
  
  for(NSDictionary *note in notes)
  {
    if( useSharpName )
      if(!result)
        result = [note valueForKey:@"name"];
      else
        result = [NSString stringWithFormat:@"%@  %@",result,[note valueForKey:@"name"]];
    else
      if(!result)
        result = [note valueForKey:@"flatname"];
      else
        result = [NSString stringWithFormat:@"%@  %@",result,[note valueForKey:@"flatname"]];
  }
  
  return result;
}

@end
