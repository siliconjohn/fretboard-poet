#import "StringInstrument.h"

@implementation StringInstrument

- (id) init
{
  if(self = [super init])
  {
    strings = [NSMutableArray new];
  }
  return self;
}

- (InstrumentString *) addString:(NSNumber *)newLowNote newHighNote:(NSNumber *)newHighNote
{
  InstrumentString *string = [InstrumentString new];
  [string setNotes:newLowNote newHighNote:newHighNote];
  
  if([string getLowNote] != nil && [string getHighNote] != nil)
  {
    [strings addObject:string];
    [self sortStrings];
    return string;
  }
  else
    return nil;
}

- (void) sortStrings
{
  NSArray *temp = [strings sortedArrayUsingComparator:
                  ^NSComparisonResult( id obj1, id obj2 )
                  {
                    if ([[obj1 getLowNote] intValue] > [[obj2 getLowNote]intValue])
                    {
                      return NSOrderedAscending;
                    }
                    else
                      if ([[obj1 getLowNote]intValue] < [[obj2 getLowNote]intValue])
                      {
                        return NSOrderedDescending;
                      }
                      else
                      {
                        return NSOrderedSame;
                      }
                  }];

  strings = [NSMutableArray arrayWithArray:temp];
}

- (NSArray *) getStrings
{
  return [NSArray arrayWithArray:strings];
}

@end
