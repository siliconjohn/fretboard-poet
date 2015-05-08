#import <Foundation/Foundation.h>

@interface TimeEvents : NSObject
{
  @private
  NSMutableArray *_events;
  NSArray *_lookupArray;
}

- (bool) addTimeEvent:(long)time data:(NSObject *)data;
- (NSObject *) getTimeEvent:(long)time;
- (void) removeAllEvents;

@end