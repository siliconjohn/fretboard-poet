#import "TrackRecorder.h"

@implementation TrackRecorder

- (void) addChordChange:(NSString*) chord
{
  long time = [_trackPlayer getTrackTime];
  
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                        chord, @"chord",
                        [NSNumber numberWithLong:time], @"time",
                        nil];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:ADD_TRACK_DATA_NOTIFICATION
                                                      object:self
                                                    userInfo:dict];
}

@end
