#import "TrackRecorderView.h"
#import "TrackRecorder.h"

@interface TrackRecorderView ()

@end

@implementation TrackRecorderView

- (IBAction)recordButtonClick:(id)sender
{
  if([trackRecorder isPlaying])
  {
    [trackRecorder pause];
    [self.recordButton setTitle:@"Record" forState:UIControlStateNormal];
  }
  else
  {
    [trackRecorder play];
    [self.recordButton setTitle:@"Pause" forState:UIControlStateNormal];
  }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  [trackRecorder addChordChange:string];
  return true;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self clearUI];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(trackTimeChangeNotification:)
   name:TRACK_TIME_CHANGE_NOTIFICATION
   object:nil];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(trackPlayNotification:)
   name:TRACK_PLAY_NOTIFICATION
   object:nil];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(trackPauseNotification:)
   name:TRACK_PAUSE_NOTIFICATION
   object:nil];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(trackLoadedNotification:)
   name:TRACK_LOADED_NOTIFICATION
   object:nil];
  
  ///////////////////////////
  // TESTING
  ///////////////////////////
  
  trackRecorder = [TrackRecorder new];
  [trackRecorder initNewTrack:[[NSBundle mainBundle] pathForResource:@"samplesong" ofType:@".mp3"] dataPath:[[NSBundle mainBundle] pathForResource:@"samplesong" ofType:@".json"]];
  if([trackRecorder canPlay])
    [self enableUI];
  
  ///////////////////////////
}

- (void) enableUI
{
  self.recordButton.enabled = true;
}

- (void) clearUI
{
  self.recordButton.enabled = false;
  self.textField.enabled = false;
}

/////////////////////////////
// notifications
/////////////////////////////

- (void)trackTimeChangeNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:trackRecorder])return;
}

- (void)trackPlayNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:trackRecorder])return;
  self.textField.enabled = true;
  [self.textField becomeFirstResponder];
}

- (void)trackPauseNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:trackRecorder])return;
  [self.textField resignFirstResponder];
  self.textField.enabled = false;
}

- (void)trackLoadedNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:trackRecorder])return;
}

//////////////////////////////

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
