#import "TrackPlayerView.h"
#import "Track.h"

@interface TrackPlayerView ()

@end

@implementation TrackPlayerView

/////////////////////////////
// UI events
/////////////////////////////

- (IBAction)playPauseButton:(id)sender
{
  if([track isPlaying])
  {
    [track pause];
    [self.playPauseButton setTitle:@"Play" forState:UIControlStateNormal];
  }
  else
  {
    [track play];
    [self.playPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
    self.notesinChordLabelLabel.text = @"Notes in Chord";
    self.notesInKeyLabelLabel.text = @"Notes in Key";
  }
}

- (IBAction)rewindButtonCLick:(id)sender
{
  [track rewind];
}

- (IBAction)loopButtonClick:(id)sender
{

}

- (IBAction)fretboardOptionsClick:(id)sender
{
  if (_fretBoardView == nil) return;
  
  UIAlertController *alertController;
  alertController = [UIAlertController
                     alertControllerWithTitle:@"Fretboard Options"
                     message:@""
                     preferredStyle:UIAlertControllerStyleActionSheet];
  
  ////////////////////////
  // create actions
  ////////////////////////
  
  bool isChecked = false;
  NSString *message =@"";

  // show key option
  UIAlertAction *showKey;
  
  isChecked = _fretBoardView.highlightSongKey;
  message =@"Highlight notes in the song's key";
  
  if (isChecked)
    message = [NSString stringWithFormat:@"%@  %@", @"\u2714", message];

  showKey = [UIAlertAction actionWithTitle:message
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                           }];
  
  [alertController addAction:showKey];
  
  // show chord option
  UIAlertAction *showChord;
  
  isChecked = _fretBoardView.highlightChord;
  message =@"Highlight notes in the current chord";
  
  if (isChecked)
    message = [NSString stringWithFormat:@"%@  %@", @"\u2714", message];
  
  showChord = [UIAlertAction actionWithTitle:message
                                     style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action) {
                                   }];
  
  [alertController addAction:showChord];
  
  // show chord scale
  UIAlertAction *showChordScale;
  
  isChecked = _fretBoardView.highlightChordScale;
  message =@"Highlight notes in the scale for chord";
  
  if (isChecked)
    message = [NSString stringWithFormat:@"%@  %@", @"\u2714", message];
  
  showChordScale = [UIAlertAction actionWithTitle:message
                                       style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action) {
                                     }];
  
  [alertController addAction:showChordScale];
  
  // show note names
  UIAlertAction *showNoteNames;
  
  isChecked = _fretBoardView.showNoteNames;
  message =@"Show note names";
  
  if (isChecked)
    message = [NSString stringWithFormat:@"%@  %@", @"\u2714", message];
  
  showNoteNames = [UIAlertAction actionWithTitle:message
                                            style:UIAlertActionStyleDefault
                                          handler:^(UIAlertAction *action) {
                                          }];
  
  [alertController addAction:showNoteNames];
  
  //////////////////////////
  //////////////////////////
  
  [alertController setModalPresentationStyle:UIModalPresentationPopover];

  UIPopoverPresentationController *popPresenter = [alertController
                                                   popoverPresentationController];
  [popPresenter setSourceView: self.fretboardScollView];
  [popPresenter setSourceRect: self.view.bounds];
  [self presentViewController:alertController animated:YES completion:nil];

}

- (IBAction)changeInstrumentButtonClick:(id)sender
{
  UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose an instrument bro"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"Guitar", @"Bass" ,@"Bass 5 string",@"Guitar 7 String",@"Guitar Open E Tuning",@"Guitar Drop D Tuning",@"Guitar Open D Tuning", nil];
  [actionSheet showInView:self.view ];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
  // guitar
  if( buttonIndex == 0)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
    [guitar addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:62]];
    [guitar addString:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
    [guitar addString:[NSNumber numberWithInt:43] newHighNote:[NSNumber numberWithInt:67]];
    [guitar addString:[NSNumber numberWithInt:47] newHighNote:[NSNumber numberWithInt:71]];
    [guitar addString:[NSNumber numberWithInt:52] newHighNote:[NSNumber numberWithInt:76]];

    _fretBoardView.instrument = guitar;
    return;
  }
  
  // bass
  if( buttonIndex == 1)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:21] newHighNote:[NSNumber numberWithInt:45]];
    [guitar addString:[NSNumber numberWithInt:26] newHighNote:[NSNumber numberWithInt:50]];
    [guitar addString:[NSNumber numberWithInt:16] newHighNote:[NSNumber numberWithInt:40]];
    [guitar addString:[NSNumber numberWithInt:31] newHighNote:[NSNumber numberWithInt:55]];
    
    _fretBoardView.instrument = guitar;
    return;
  }
  
  // 5 string bass
  if( buttonIndex == 2)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:21] newHighNote:[NSNumber numberWithInt:45]];
    [guitar addString:[NSNumber numberWithInt:26] newHighNote:[NSNumber numberWithInt:50]];
    [guitar addString:[NSNumber numberWithInt:16] newHighNote:[NSNumber numberWithInt:40]];
    [guitar addString:[NSNumber numberWithInt:31] newHighNote:[NSNumber numberWithInt:55]];
    [guitar addString:[NSNumber numberWithInt:11] newHighNote:[NSNumber numberWithInt:35]];
    
    _fretBoardView.instrument = guitar;
    return;
  }
  
  // 7 string
  if( buttonIndex == 3)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
    [guitar addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:62]];
    [guitar addString:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
    [guitar addString:[NSNumber numberWithInt:43] newHighNote:[NSNumber numberWithInt:67]];
    [guitar addString:[NSNumber numberWithInt:47] newHighNote:[NSNumber numberWithInt:71]];
    [guitar addString:[NSNumber numberWithInt:52] newHighNote:[NSNumber numberWithInt:76]];
    [guitar addString:[NSNumber numberWithInt:23] newHighNote:[NSNumber numberWithInt:47]];
    
    _fretBoardView.instrument = guitar;
    return;
  }

  // guitar open E
  if( buttonIndex == 4)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:52] newHighNote:[NSNumber numberWithInt:76]];
    [guitar addString:[NSNumber numberWithInt:47] newHighNote:[NSNumber numberWithInt:71]];
    [guitar addString:[NSNumber numberWithInt:44] newHighNote:[NSNumber numberWithInt:68]];
    [guitar addString:[NSNumber numberWithInt:40] newHighNote:[NSNumber numberWithInt:64]];
    [guitar addString:[NSNumber numberWithInt:35] newHighNote:[NSNumber numberWithInt:59]];
    [guitar addString:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
    
    _fretBoardView.instrument = guitar;
    return;
  }
  
  // guitar drop d
  if( buttonIndex == 5)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:52] newHighNote:[NSNumber numberWithInt:76]];
    [guitar addString:[NSNumber numberWithInt:47] newHighNote:[NSNumber numberWithInt:71]];
    [guitar addString:[NSNumber numberWithInt:43] newHighNote:[NSNumber numberWithInt:67]];
    [guitar addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:62]];
    [guitar addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
    [guitar addString:[NSNumber numberWithInt:26] newHighNote:[NSNumber numberWithInt:50]];
    
    _fretBoardView.instrument = guitar;
    return;
  }

  // guitar open d
  if( buttonIndex == 6)
  {
    StringInstrument *guitar = [StringInstrument new];
    [guitar addString:[NSNumber numberWithInt:50] newHighNote:[NSNumber numberWithInt:74]];
    [guitar addString:[NSNumber numberWithInt:45] newHighNote:[NSNumber numberWithInt:69]];
    [guitar addString:[NSNumber numberWithInt:42] newHighNote:[NSNumber numberWithInt:66]];
    [guitar addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:62]];
    [guitar addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
    [guitar addString:[NSNumber numberWithInt:26] newHighNote:[NSNumber numberWithInt:50]];
    
    _fretBoardView.instrument = guitar;
    return;
  }

}

/////////////////////////////
// notifications
/////////////////////////////

- (void)trackTimeChangeNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:track])return;
  
  self.progressBar.progress = [[notification.userInfo valueForKey:@"progress"] floatValue];
  self.chordLabel.text = [notification.userInfo valueForKey:@"chord"];
  self.scaleLabel.text = [notification.userInfo valueForKey:@"scale"];
  self.keyLabel.text = [notification.userInfo valueForKey:@"key"];
  [self updateNotesInKey:[notification.userInfo valueForKey:@"key"]];
  [self updateNotesInChord:[notification.userInfo valueForKey:@"chord"]];
}

- (void)trackPlayNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:track])return;
}

- (void)trackPauseNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:track])return;
}

- (void)trackLoadedNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:track])return;
  [self updateUIforSongMetaData:notification.userInfo];
}

/////////////////////////////
// overridden methods
/////////////////////////////

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
  
  
  // setup fretboard
  _fretBoardView = [[UIFretboard alloc] initWithFrame:CGRectMake(0,0,FRETBOARD_MAX_WIDTH,FRETBOARD_MAX_HEIGHT)];
  [_fretboardScollView addSubview:_fretBoardView];
  [_fretboardScollView setContentSize:CGSizeMake(FRETBOARD_MAX_WIDTH,FRETBOARD_MAX_HEIGHT)];
  
  ///////////////////////////
  // TESTING
  ///////////////////////////
  
  track = [Track new];
  [track initNewTrack:[[NSBundle mainBundle] pathForResource:@"samplesong" ofType:@".m4a"] dataPath:[[NSBundle mainBundle] pathForResource:@"samplesong" ofType:@".json"]];
  if([track canPlay])
    [self enableUI];
  _fretBoardView.trackIDObject = track;
  
  // guitar fretboard
  StringInstrument *guitar = [StringInstrument new];
  [guitar addString:[NSNumber numberWithInt:33] newHighNote:[NSNumber numberWithInt:57]];
  [guitar addString:[NSNumber numberWithInt:38] newHighNote:[NSNumber numberWithInt:65]];
  [guitar addString:[NSNumber numberWithInt:28] newHighNote:[NSNumber numberWithInt:52]];
  [guitar addString:[NSNumber numberWithInt:43] newHighNote:[NSNumber numberWithInt:70]];
  [guitar addString:[NSNumber numberWithInt:47] newHighNote:[NSNumber numberWithInt:74]];
  [guitar addString:[NSNumber numberWithInt:52] newHighNote:[NSNumber numberWithInt:79]];

  _fretBoardView.instrument = guitar;
  
  ///////////////////////////
}












- (void) enableUI
{
  self.playPauseButton.enabled = true;
  self.loopButton.enabled = true;
  self.rewindButton.enabled = true;
}

- (void) clearUI
{
  self.songLabel.text = @"";
  self.artistLabel.text = @"";
  self.chordLabel.text = @"";
  self.scaleLabel.text = @"";
  self.nextChordLabel.text = @"";
  self.keyLabel.text = @"";
  self.BPMLabel.text = @"";
  self.notesInKeyLabel.text = @"";
  self.notesinChordLabel.text = @"";
  self.notesinChordLabelLabel.text = @"";
  self.notesInKeyLabelLabel.text = @"";
  self.progressBar.progress = 0;
  self.playPauseButton.enabled = false;
  self.loopButton.enabled = false;
  self.rewindButton.enabled = false;
}

- (void) updateUIforSongMetaData:(NSDictionary*) dict
{
  self.songLabel.text = [dict valueForKey:@"name"];
  self.artistLabel.text = [dict valueForKey:@"artist"];
  self.keyLabel.text = [dict valueForKey:@"key"];
  self.BPMLabel.text = [[dict valueForKey:@"BPM"] stringValue];
}

- (void) updateNotesInKey:(NSString * )key
{
  if(key == nil)
  {
    self.notesInKeyLabel.text = @"";
    return;
  }
  
  NSArray *pieces = [key componentsSeparatedByString:@" "];

  if([pieces count] > 1)
  {
    NSString *scale = [[Scales sharedScales] getNotesForScaleInOneOctaveAsString:pieces[1] noteName: pieces[0]];
    
    if( scale != nil )
    {
      self.notesInKeyLabel.text = scale;
      return;
    }
  }
  // if all else fails show nothing
  self.notesInKeyLabel.text = @"";
}

- (void) updateNotesInChord:(NSString * )key
{
  if(key == nil)
  {
    self.notesinChordLabel.text = @"";
    return;
  }
  
  NSArray *pieces = [key componentsSeparatedByString:@" "];
  
  if([pieces count] > 1)
  {
    NSString *scale = [[Chords sharedChords] getNotesForChordInOneOctaveAsString:pieces[1] noteName: pieces[0]];
    
    if( scale != nil )
    {
      self.notesinChordLabel.text = scale;
      return;
    }
  }
  // if all else fails show nothing
  self.notesinChordLabel.text = @"";
}

- (void) didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
