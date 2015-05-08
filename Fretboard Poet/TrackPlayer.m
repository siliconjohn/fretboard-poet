#import "TrackPlayer.h"

NSString * const TRACK_TIME_CHANGE_NOTIFICATION = @"TRACK_TIME_CHANGE_NOTIFICATION";
NSString * const TRACK_PAUSE_NOTIFICATION = @"TRACK_PAUSE_NOTIFICATION";
NSString * const TRACK_PLAY_NOTIFICATION = @"TRACK_PLAY_NOTIFICATION";

@implementation TrackPlayer

- (id) init
{
  if (self = [super init])
  {
    _queryInterval = 0.5;
  }
  
  return self;
}

/////////////////////////////////////////
// Call this before you play any track
// don't do it any other way
/////////////////////////////////////////

- (bool) initNewTrack:(NSString *)trackPath dataPath:(NSString*)dataPath trackIDObject:(NSObject *)trackIDObject
{
  _canPlay = false;
  _trackIDObject = trackIDObject;
  
  /////////////////////////////
  // create the track's url
  /////////////////////////////
  
  @try {
    _trackURL = [NSURL fileURLWithPath:trackPath];
  }
  @catch (NSException * e) {
    NSLog(@"Exception: %@", e);
    return false;
  }
  
  /////////////////////////////
  // create the audio player
  /////////////////////////////
  
  NSError *error;
  _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:_trackURL error:&error];
  
  if(error)return false;
  
  if(![_audioPlayer prepareToPlay]) return false;
  
  /////////////////////////////
  // create track data
  /////////////////////////////
  
  _trackData= [TrackData new];
  if([_trackData initNewTrack:dataPath trackIDObject:trackIDObject] == false ) return false;
  
  /////////////////////////////
  
  _canPlay = true;
  
  return true;
}

- (void) play
{
  if(!_canPlay || [_audioPlayer isPlaying]) return;
  [_audioPlayer setVolume:0.0];
  [_audioPlayer play];
  [self startTimer];
  [self postPlayNotification];
}

- (void) pause
{
  if(!_canPlay || ![_audioPlayer isPlaying]) return;
  
  [_audioPlayer stop];
  [_audioTimer invalidate];
  [self postPauseNotification];
}

- (bool) rewind
{
  if(!_canPlay) return false;

  _audioPlayer.currentTime = 0;
  
  return true;
}

- (bool) isPlaying
{
  return [_audioPlayer isPlaying];
}

- (void) startTimer
{
  [self stopTimer];
  _audioTimer = [NSTimer scheduledTimerWithTimeInterval:_queryInterval target:self
                                               selector:@selector(postTrackTimeChangeNotification)
                                               userInfo:nil repeats:YES];
}

- (void) stopTimer
{
  if(_audioTimer)
    [_audioTimer invalidate];
}

- (long) getTrackTime
{
  return (long)trunc([_audioPlayer currentTime] * 1000);
}

- (void) postTrackTimeChangeNotification
{
  if(!_audioPlayer || !_canPlay)return;
  
  long time = [self getTrackTime];
  NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[_trackData getEventsForTime: time]];
  
  [dict setValue:[[Scales sharedScales] getNotesForScale:[dict valueForKey:@"key"]] forKey:@"notesInKey"];
  [dict setValue:[[Scales sharedScales] getNotesForScale:[dict valueForKey:@"scale"]] forKey:@"notesInScale"];
  [dict setValue:[[Chords sharedChords] getNotesForChord:[dict valueForKey:@"chord"]] forKey:@"notesInChord"];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_TIME_CHANGE_NOTIFICATION
                                                      object:_trackIDObject
                                                    userInfo:dict];
}

- (void) postPauseNotification
{
  if(!_audioPlayer || !_canPlay)return;
  
  NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:[_audioPlayer currentTime]] forKey:@"time"];
  [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_PAUSE_NOTIFICATION
                                                      object:_trackIDObject
                                                    userInfo:dict];
}

- (void) postPlayNotification
{
  if(!_audioPlayer || !_canPlay)return;
  
  NSDictionary *dict = [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:[_audioPlayer currentTime]] forKey:@"time"];
  [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_PLAY_NOTIFICATION
                                                      object:_trackIDObject
                                                    userInfo:dict];
}

@end
