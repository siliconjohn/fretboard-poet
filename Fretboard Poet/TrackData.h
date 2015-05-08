#import <Foundation/Foundation.h>
#import "TimeEvents.h"

extern NSString * const TRACK_LOADED_NOTIFICATION;
extern NSString * const ADD_TRACK_DATA_NOTIFICATION;

@interface TrackData : NSObject
{
  @private
  BOOL _canQuery;
  NSObject *_trackIDObject;
  NSURL *_dataURL;
  TimeEvents *_keyData;
  TimeEvents *_chordData;
  TimeEvents *_beatData;
  TimeEvents *_scaleData;
  NSArray *_trackJSON;

  @public
  NSString *metaArtist;
  NSString *metaName;
  NSNumber *metaDuration;
  NSNumber *metaBPM;
  NSString *metaKey;
}

- (bool) initNewTrack:(NSString *)dataPath trackIDObject:(NSObject *)trackIDObject;
- (NSDictionary *) getEventsForTime:(long) time;

@end

