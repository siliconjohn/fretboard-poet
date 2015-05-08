#import <Foundation/Foundation.h>
#import "TrackPlayer.h"
#import "StringInstrument.h"
#import "Scales.h"
#import "Chords.h"

@interface Track : NSObject
{
  @private
  BOOL _canPlay;
  
  @protected
  TrackPlayer *_trackPlayer;
}

@property (readonly, atomic) StringInstrument *fretboard;

- (bool) initNewTrack:(NSString *)trackPath dataPath:(NSString *)dataPath;

- (void) play;
- (void) pause;
- (bool) rewind;
- (bool) canPlay;
- (bool) isPlaying;
- (long) getTrackTime;

@end
