#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import "InstrumentString.h"
#import "StringInstrument.h"
#import <CoreText/CoreText.h>

extern NSString * const NOTE_ON_NOTIFICATION;
extern NSString * const NOTE_OFF_NOTIFICATION;
extern NSString * const ALL_NOTES_OFF_NOTIFICATION;

@interface UIFretNoteController : NSObject
{
  @private
  bool hasChord;
  bool hasChordScale;
  bool hasKey;
}

@property (nonatomic) CALayer *layer;
@property (atomic) NSDictionary *note;
@property (atomic) InstrumentString *instrumentString;
@property (atomic) StringInstrument *stringInstrument;
@property (nonatomic) NSObject *trackIDObject;
@property (nonatomic, assign) BOOL highlightSongKey;
@property (nonatomic, assign) BOOL highlightChordScale;
@property (nonatomic, assign) BOOL highlightChord;
@property (nonatomic, assign) BOOL showNoteNames;

@end
