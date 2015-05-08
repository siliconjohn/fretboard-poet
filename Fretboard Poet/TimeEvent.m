#import "TimeEvent.h"

@implementation TimeEvent

- (NSComparisonResult)compare:(TimeEvent *)otherObject
{
  if (self->time < otherObject->time)
    return -1;

  if (self->time > otherObject->time)
    return 1;

  return 0;
}

@end
