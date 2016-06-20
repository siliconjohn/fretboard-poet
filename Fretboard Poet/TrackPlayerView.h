#import <UIKit/UIKit.h>
#import "Track.h"
#import "Scales.h"
#import "Chords.h"
#import "UIFretboard.h"

@interface TrackPlayerView : UIViewController <UIActionSheetDelegate>
{
  Track *track;
}

@property UIFretboard *fretBoardView;
@property (strong, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIButton *playPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *loopButton;
@property (weak, nonatomic) IBOutlet UIButton *rewindButton;
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;
@property (weak, nonatomic) IBOutlet UILabel *songLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *chordLabel;
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextChordLabel;
@property (weak, nonatomic) IBOutlet UILabel *keyLabel;
@property (weak, nonatomic) IBOutlet UILabel *BPMLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesInKeyLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesinChordLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesInKeyLabelLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesinChordLabelLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *fretboardScollView;
@property (weak, nonatomic) IBOutlet UIButton *changeInstrumentButton;
- (IBAction)changeInstrumentButtonClick:(id)sender;

- (IBAction)playPauseButton:(id)sender;
- (IBAction)rewindButtonCLick:(id)sender;
- (IBAction)loopButtonClick:(id)sender;
- (IBAction)fretboardOptionsClick:(id)sender;

@end


