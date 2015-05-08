#import "TimeEvents.h"
#import "TimeEvent.h"

@implementation TimeEvents

- (id) init
{
  if (self = [super init])
  {
    _events = [[NSMutableArray alloc]init];
  }
  return self;
}

- (bool) addTimeEvent:(long)time data:(NSObject *)data
{
  // return if data is bad
  if(time < 0 || data == nil || time > LONG_MAX)return false;
  
  TimeEvent *newEvent;
  
  // find existing event
  for(id event in _events)
  {
    TimeEvent *e = (TimeEvent *)event;
    
    if(e->time == time )
    {
      newEvent = e;
      break;
    }
  }
  
  // create new event if existing not found
  if(newEvent == nil)
  {
    newEvent = [TimeEvent new];
    [_events addObject: newEvent];
  }
  
  // set data and time
  newEvent->time = time;
  newEvent->data = data;

  // sort array by time
  _events = [[NSMutableArray alloc]initWithArray:[_events sortedArrayUsingSelector:@selector(compare:)]];

  // build lookup array
  NSMutableArray *tempLookupArray = [NSMutableArray new];
  
  for(id event in _events)
  {
    TimeEvent *e = (TimeEvent *)event;
    [tempLookupArray addObject:[NSNumber numberWithLong:e->time]];
  }
  
  _lookupArray = [NSArray arrayWithArray:tempLookupArray];
  
  return true;
}

- (NSObject *) getTimeEvent:(long)time
{
  if(time < 0 || _lookupArray == nil )return nil;
  
  long count = [_lookupArray count];
  long countMinusOne = count - 1 ;
  long nextInt = 0;
  
  for(int i = 0; i < count; i++)
  {
    if(i < countMinusOne)
      nextInt = [[_lookupArray objectAtIndex:i + 1]longValue];
    else
      nextInt = LONG_MAX;
    
    if(time >= [[_lookupArray objectAtIndex:i]longValue] &&  time < nextInt)
    {
      TimeEvent *e = (TimeEvent *)[_events objectAtIndex:i];
      return e->data;
    }
  }
  
  return nil;
}

- (void) removeAllEvents
{
  _events = [NSMutableArray new];
  _lookupArray = nil;
}

@end
