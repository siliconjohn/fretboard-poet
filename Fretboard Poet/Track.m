#import "Track.h"
#import "TrackPlayer.h"
#import "TrackData.h"
#import "UIFretNoteController.h"

@implementation Track

@synthesize fretboard = _fretboard;

- (bool) initNewTrack:(NSString *)trackPath dataPath:(NSString *)dataPath;
{
  if( trackPath == nil || dataPath == nil ) return false;
  
  _canPlay = false;
  
  _trackPlayer = [TrackPlayer new];
  if([_trackPlayer initNewTrack:trackPath dataPath:dataPath trackIDObject:self] == false) return false;

  _canPlay = true;
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(trackTimeChangeNotification:)
   name:TRACK_TIME_CHANGE_NOTIFICATION
   object:nil];

  return true;
}

- (void) play
{
  if( !_canPlay ) return;
  [_trackPlayer play];
}

- (void) pause
{
  if( !_canPlay ) return;
  [_trackPlayer pause];
}

- (bool) rewind
{
  if( !_canPlay ) return false;
  [[NSNotificationCenter defaultCenter] postNotificationName:ALL_NOTES_OFF_NOTIFICATION
                                                      object:self
                                                    userInfo:nil];
  return [_trackPlayer rewind];
}

- (bool) canPlay
{
  return _canPlay;
}

- (bool) isPlaying
{
  return [_trackPlayer isPlaying];
}

- (long) getTrackTime
{
  return [_trackPlayer getTrackTime];
}

/////////////////////////////
// notifications
/////////////////////////////

- (void)trackTimeChangeNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:self])return;
  
  
  // Track.m recieves this notification because it has all of the scale chord time info
  // some other object is going to have to parse it into usable data, which then posts
  // it to the UI. not sure how to do that
  [[NSNotificationCenter defaultCenter] postNotificationName:NOTE_ON_NOTIFICATION
                                                      object:self
                                                    userInfo:notification.userInfo];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
