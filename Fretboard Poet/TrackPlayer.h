#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "TrackData.h"
#import "Scales.h"
#import "Chords.h"

extern NSString * const TRACK_TIME_CHANGE_NOTIFICATION;
extern NSString * const TRACK_PAUSE_NOTIFICATION;
extern NSString * const TRACK_PLAY_NOTIFICATION;

@interface TrackPlayer : NSObject
{
  @private
  TrackData *_trackData;
  NSTimeInterval _queryInterval;
  BOOL _canPlay;
  NSObject *_trackIDObject;
  NSTimer *_audioTimer;
  AVAudioPlayer *_audioPlayer;
  NSURL *_trackURL;
}

- (bool) initNewTrack:(NSString *)trackPath dataPath:(NSString*)dataPath trackIDObject:(NSObject *)trackIDObject;
- (void) play;
- (void) pause;
- (bool) rewind;
- (bool) isPlaying;
- (long) getTrackTime;

@property (readonly) NSURL *trackURL;
@property (readonly) NSString *trackPath;

@end
