#import "TrackData.h"

NSString * const TRACK_LOADED_NOTIFICATION = @"TRACK_LOADED_NOTIFICATION";
NSString * const ADD_TRACK_DATA_NOTIFICATION = @"ADD_TRACK_DATA_NOTIFICATION";

@implementation TrackData

- (bool) initNewTrack:(NSString *)dataPath trackIDObject:(NSObject *)trackIDObject
{
  _canQuery = false;
  _trackIDObject = trackIDObject;
  
  _keyData = [TimeEvents new];
  _chordData = [TimeEvents new];
  _scaleData = [TimeEvents new];
  _beatData = [TimeEvents new];

  // create the track's url
  @try {
    _dataURL = [NSURL fileURLWithPath:dataPath];
  }
  @catch (NSException * e) {
    NSLog(@"Exception in TrackData: %@", e);
    return false;
  }
  
  // load the file as NSData
  NSData *JSONData = [NSData dataWithContentsOfURL:_dataURL];
  if (JSONData == nil)return false;
  
  // parse NSData into JSON
  NSError *error = nil;
  _trackJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:&error];
  
  // if error parsing return
  if(error)
  {
    NSLog(@"Error in TrackData: %@", error);
    return false;
  }
  
  _canQuery = true;
  
  [self _parseTrackJSON];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(addTrackDataNotification:)
   name:ADD_TRACK_DATA_NOTIFICATION
   object:trackIDObject];

  [self postTrackLoadedNotification];
  
  return true;
}

- ( void ) _parseTrackJSON
{
  if( _trackJSON == nil) return;
  
  [_keyData removeAllEvents];
  [_chordData removeAllEvents];
  [_scaleData removeAllEvents];
  [_beatData  removeAllEvents];
  
  NSArray *events = [_trackJSON valueForKey:@"events"];
  
  for(id event in events)
  {
    // get time
    id eventTime = [event valueForKey:@"time"];
    if(eventTime == nil) continue;
    if(![eventTime isKindOfClass:[NSNumber class]]) continue;
    long time = [(NSNumber*)eventTime longValue];
   
    // get key
    id eventKey = [event valueForKey:@"key"];
    if ( eventKey != nil && [eventKey isKindOfClass:[NSString class]])
      [_keyData addTimeEvent:time data:(NSString*)eventKey];
    
    // get chord
    id eventChord = [event valueForKey:@"chord"];
    if ( eventChord != nil && [eventChord isKindOfClass:[NSString class]])
      [_chordData addTimeEvent:time data:(NSString*)eventChord];
    
    // get beat
    id eventBeat = [event valueForKey:@"beat"];
    if ( eventBeat != nil && [eventBeat isKindOfClass:[NSNumber class]])
      [_beatData addTimeEvent:time data:(NSNumber*)eventBeat];
    
    // get scale
    id eventScale = [event valueForKey:@"scale"];
    if ( eventScale != nil && [eventScale isKindOfClass:[NSString class]])
      [_scaleData addTimeEvent:time data:(NSString*)eventScale];
  }
  
  NSArray *meta = [_trackJSON valueForKey:@"meta"];
  
  id temp = [meta valueForKey:@"duration"];
  if ( temp != nil && [temp isKindOfClass:[NSNumber class]])
    metaDuration = (NSNumber*)temp;
  
  temp = [meta valueForKey:@"bpm"];
  if ( temp != nil && [temp isKindOfClass:[NSNumber class]])
    metaBPM = (NSNumber*)temp;
  
  temp = [meta valueForKey:@"artist"];
  if ( temp != nil && [temp isKindOfClass:[NSString class]])
    metaArtist = (NSString*)temp;
  
  temp = [meta valueForKey:@"name"];
  if ( temp != nil && [temp isKindOfClass:[NSString class]])
    metaName = (NSString*)temp;

  temp = [meta valueForKey:@"key"];
  if ( temp != nil && [temp isKindOfClass:[NSString class]])
    metaKey = (NSString*)temp;
}

- ( NSDictionary * ) getEventsForTime:(long)time;
{
  float t = time;
  float d =[metaDuration doubleValue];
  NSNumber *progress = [NSNumber numberWithFloat: t / d ];
  
  NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                         [_keyData getTimeEvent:time], @"key",
                         [_chordData getTimeEvent:time], @"chord",
                         [_scaleData getTimeEvent:time], @"scale",
                         [_beatData getTimeEvent:time], @"beat",
                         progress, @"progress",
                         nil];
  
  return result;
}

- (void) postTrackLoadedNotification
{
  if(!_canQuery)return;
  
  NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                        metaArtist, @"artist",
                        metaName, @"name",
                        metaDuration, @"duration",
                        metaBPM, @"BPM",
                        metaKey, @"key",
                        nil];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:TRACK_LOADED_NOTIFICATION
                                                      object:_trackIDObject
                                                    userInfo:dict];
}

- (void) addTrackDataNotification:(NSNotification*) notification;
{
  if(![notification.object isEqual:_trackIDObject])return;
  
  @try {
    NSDictionary *dict = notification.userInfo;
  
    long time = [[dict valueForKey:@"time"] longValue];

    [_chordData addTimeEvent:time data:[dict valueForKey:@"chord"]];
  }
  @catch (NSException * e)
  {
    NSLog(@"Exception: %@", e);
  }
  
  // todo add key, scale data etc
  // add test for posting notification
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
