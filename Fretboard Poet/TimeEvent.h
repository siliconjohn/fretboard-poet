#import <Foundation/Foundation.h>

@interface TimeEvent : NSObject
{
  @public
  long time;
  NSObject *data;
}

- (NSComparisonResult) compare: (TimeEvent *)otherObject;

@end
