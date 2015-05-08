#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Notes.h"
#import "StringInstrument.h"
#import "InstrumentString.h"
#import "UIFretNoteController.h"

extern CGFloat const FRETBOARD_MAX_WIDTH;
extern CGFloat const FRETBOARD_MAX_HEIGHT;

@interface UIFretboard : UIControl
{
  CALayer *fingerboardLayer;
  CALayer *nutLayer;
  CALayer *fretNoteLayer;
  
  NSMutableArray *fretNoteStrings;
  NSMutableArray *fretNoteLayerControllers;
}

@property (nonatomic) StringInstrument *instrument;
@property (nonatomic) NSObject *trackIDObject;
@property (nonatomic, assign) BOOL highlightSongKey;
@property (nonatomic, assign) BOOL highlightChordScale;
@property (nonatomic, assign) BOOL highlightChord;
@property (nonatomic, assign) BOOL showNoteNames;

@end
