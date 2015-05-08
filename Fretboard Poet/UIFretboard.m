#import "UIFretboard.h"

CGFloat const NUT_WIDTH = 15;
CGFloat const FRET_COUNT = 24;
CGFloat const FRET_WIRE_WIDTH = 10;
CGFloat const OPEN_STRING_WIDTH = 40;
CGFloat const FIRST_FRET_WIDTH = 120;
CGFloat const FRETBOARD_MAX_WIDTH = 2000.0f;
CGFloat const FRETBOARD_MAX_HEIGHT = 250.0f;
CGFloat const FINGERBOARD_MAX_HEIGHT = 200.0f;
CGFloat const FINGERBOARD_NUMBERS_HEIGHT = 30.0f;
CGFloat const V_NOTE_SPACING = 4.0f;

@implementation UIFretboard

@synthesize instrument = _instrument, trackIDObject = _trackIDObject;

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self)
  {
    self.highlightChordScale = true;
    self.highlightChord = true;
  }
  return self;
}

- (void) setupFretboard
{
  [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
  
  fretNoteLayerControllers = nil;
  
  if( _instrument == nil ) return;
  
  ////////////////////////
  // initial vars
  ////////////////////////
  
  NSArray *strings = _instrument.getStrings;
  if( strings == nil ) return;
  
  NSUInteger stringCount = 0;
  stringCount = [_instrument.getStrings count];
  
  // adust fingerboard height for number of strings
  float extraFingerboardHeight = 0;
  if( stringCount == 4 ) extraFingerboardHeight = -8;
  if( stringCount == 6 ) extraFingerboardHeight = 8;
  if( stringCount == 7 ) extraFingerboardHeight = 23;
  float fingerboardHeight = FINGERBOARD_MAX_HEIGHT + extraFingerboardHeight;
  
  // vert area for each string
  float stringRectHeight = fingerboardHeight / stringCount;
  
  // y to build fretboard
  float fretboardY = (FRETBOARD_MAX_HEIGHT - fingerboardHeight) - FINGERBOARD_NUMBERS_HEIGHT;
  
  /////////////////////////
  // starting Xs of frets
  /////////////////////////
  
  NSMutableArray *fretXs = [NSMutableArray new];

  for( int i = 0; i < FRET_COUNT; i++ )
  {
    float x = FIRST_FRET_WIDTH * i;
    float mult = i * 0.015f;
    x = x - ( x * mult ) + NUT_WIDTH + OPEN_STRING_WIDTH + FIRST_FRET_WIDTH;
    [fretXs addObject: [NSNumber numberWithFloat:x]];
  }
  
  //////////////////////////////////////////////
  // set fingerboard width based on fret sizes
  //////////////////////////////////////////////
  
  float fingerBoardWidth = [[fretXs lastObject] floatValue] - NUT_WIDTH - OPEN_STRING_WIDTH;
  
  ///////////////////////////////////
  // starting Xs of note rects
  ///////////////////////////////////
  
  NSMutableArray *noteXs = [NSMutableArray new];
  NSMutableArray *noteWidths = [NSMutableArray new];
  
  // open string note
  [noteXs addObject: [NSNumber numberWithFloat: 0]];
  [noteWidths addObject: [NSNumber numberWithFloat: OPEN_STRING_WIDTH]];
  
  // first note - nut to first fret
  [noteXs addObject: [NSNumber numberWithFloat: OPEN_STRING_WIDTH + NUT_WIDTH]];
  [noteWidths addObject: [NSNumber numberWithFloat: FIRST_FRET_WIDTH]];
  
  for( int i = 0; i < FRET_COUNT - 1; i++ )
  {
    [noteXs addObject: [NSNumber numberWithFloat:[[fretXs objectAtIndex:i] floatValue] + FRET_WIRE_WIDTH]];
    float notex = [[fretXs objectAtIndex:i] floatValue] + FRET_WIRE_WIDTH;
    float newnotex = [[fretXs objectAtIndex:i + 1] floatValue];
    [noteWidths addObject: [NSNumber numberWithFloat: newnotex - notex]];
  }
  
  ///////////////////////////////////
  // draw fingerboard
  ///////////////////////////////////
  
  fingerboardLayer = [CALayer layer];
  fingerboardLayer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fretboard.png"]].CGColor;
  fingerboardLayer.frame = CGRectMake( OPEN_STRING_WIDTH + NUT_WIDTH, fretboardY, fingerBoardWidth, fingerboardHeight );
  [self.layer addSublayer:fingerboardLayer];
  
  ///////////////////////////////////
  // draw nut
  ///////////////////////////////////
  
  nutLayer = [CALayer layer];
  nutLayer.frame = CGRectMake( OPEN_STRING_WIDTH, fretboardY, NUT_WIDTH, fingerboardHeight );
  nutLayer.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:0.9 alpha:1.0].CGColor;
  [self.layer addSublayer:nutLayer];
  
  ///////////////////////////////////
  // draw frets
  ///////////////////////////////////
  
  for( int i = 0; i < FRET_COUNT; i++ )
  {
    CALayer *fretLayer = [CALayer layer];
    fretLayer.frame = CGRectMake([[fretXs objectAtIndex:i] floatValue], fretboardY, FRET_WIRE_WIDTH, fingerboardHeight);
    fretLayer.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"fret.png"]].CGColor;
    [self.layer addSublayer:fretLayer];
  }
  
  ///////////////////////////////////
  // draw circle markers
  ///////////////////////////////////
  
  CGFloat radius = 12.0;
  CGFloat octaveMarkerOffset = fingerboardHeight / stringCount;
  
  // for bigger string counts space octave markers further apart
  if( stringCount > 4 )
    octaveMarkerOffset += ( octaveMarkerOffset / 2 );
  
  // for each fret
  for( int i = 1; i < [noteXs count]; i++ )
  {
    // if fret with marker: 3rd 5th 7th 9th 12th 15th 17th 19th 21st and 24th
    if( i == 3 || i == 5 || i == 7 || i == 9 || i == 12 ||
        i == 15 || i == 17 || i == 19 || i == 21 || i == 24)
    {
      CGFloat circleY = ( fingerboardHeight / 2 ) - radius;
      CGFloat circlyX = [[noteXs objectAtIndex:i] floatValue] + ( [[noteWidths objectAtIndex:i] floatValue] / 2) - radius;
      
      CALayer *layer = [CALayer layer];
      layer.cornerRadius = radius;
      layer.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor;
      layer.opacity = 0.8;
      
      // draw 2 markers at 12th and 24th frets
      if( i == 12 || i == 24 )
      {
        layer.frame = CGRectMake( circlyX, circleY - octaveMarkerOffset + fretboardY, radius * 2, radius * 2 );
        [self.layer addSublayer:layer];
        
        layer = [CALayer layer];
        layer.cornerRadius = radius;
        layer.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1].CGColor;
        layer.frame = CGRectMake( circlyX, circleY + octaveMarkerOffset + fretboardY, radius * 2, radius * 2 );
        [self.layer addSublayer: layer];
      }
      else
      {
        layer.frame = CGRectMake( circlyX, circleY + fretboardY, radius * 2, radius * 2 );
        [self.layer addSublayer: layer];
      }
    }
  }
  
  ///////////////////////////////////
  // draw open string letters
  ///////////////////////////////////
  
  int fontSize = 20;
  
  CALayer *openStringLayer = [CALayer layer];
  [self.layer addSublayer: openStringLayer];
  
  for( int i = 0; i < stringCount; i++ )
  {
    CGRect rect = CGRectMake(0, (stringRectHeight * i) + fretboardY, OPEN_STRING_WIDTH, stringRectHeight-1 );
    CALayer *newlayer = [CALayer layer];
    newlayer.frame = rect;
    
    CATextLayer *label = [CATextLayer new];
    [label setFont: @"Helvetica-Bold"];
    [label setFontSize: 20];
    [label setFrame: CGRectMake( -1, (stringRectHeight - fontSize - 4 )/2, OPEN_STRING_WIDTH, stringRectHeight)];
    
    // set open string name
    InstrumentString *string = [strings objectAtIndex:i];
    NSArray *stringNotes = string.notes;
    [label setString: [[stringNotes firstObject] valueForKey:@"name"]];
    
    [label setAlignmentMode: kCAAlignmentCenter];
    [label setForegroundColor: [[UIColor whiteColor] CGColor]];
    [newlayer addSublayer: label];
    
    [openStringLayer addSublayer:newlayer];
  }
  
  ///////////////////////////////////
  // draw strings
  ///////////////////////////////////
  
  float stringHeight  = 1;
  float stringYinc = stringRectHeight / 2;
  float stringWidth = fingerBoardWidth + NUT_WIDTH + FRET_WIRE_WIDTH;
  
  for( int i = 0; i < stringCount; i++ )
  {
    float stringRectY = stringRectHeight * i;
    
    // string light background
    CGRect rect = CGRectMake(OPEN_STRING_WIDTH, fretboardY + stringRectY + stringYinc - ( stringHeight / 2), stringWidth, stringHeight );
    CALayer *newlayer = [CALayer layer];
    newlayer.frame = rect;
    newlayer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1].CGColor;
    newlayer.opacity = 0.6;
    // drop shadow
    newlayer.shadowOffset = CGSizeMake(0, 3);
    newlayer.shadowRadius = 5.0;
    newlayer.shadowColor = [UIColor blackColor].CGColor;
    newlayer.shadowOpacity = 1;

    // top light line of string
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, 0)];
    [linePath addLineToPoint: CGPointMake(stringWidth, 0)];
    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.strokeColor = [UIColor whiteColor].CGColor;
    [newlayer addSublayer: line];
    
    // bottom dark line of string
    line = [CAShapeLayer layer];
    linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint: CGPointMake(0, stringHeight)];
    [linePath addLineToPoint: CGPointMake(stringWidth, stringHeight)];
    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1].CGColor;
    [newlayer addSublayer: line];
    
    // bottom dark inside line of string - 1px
    if( stringHeight > 2.5 )
    {
      line = [CAShapeLayer layer];
      linePath = [UIBezierPath bezierPath];
      [linePath moveToPoint: CGPointMake(0, stringHeight-1)];
      [linePath addLineToPoint:CGPointMake(stringWidth, stringHeight-1)];
      line.path = linePath.CGPath;
      line.fillColor = nil;
      line.opacity = 1.0;
      line.strokeColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1].CGColor;
      [newlayer addSublayer: line];
    }
    
    // bottom dark inside line of string - 2px
    if( stringHeight >= 4 )
    {
      line = [CAShapeLayer layer];
      linePath = [UIBezierPath bezierPath];
      [linePath moveToPoint: CGPointMake(0, stringHeight - 2 )];
      [linePath addLineToPoint:CGPointMake(stringWidth, stringHeight - 2)];
      line.path = linePath.CGPath;
      line.fillColor = nil;
      line.opacity = 1.0;
      line.strokeColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1].CGColor;
      [newlayer addSublayer: line];
    }
    
    [self.layer addSublayer: newlayer];
    
    stringHeight += i * 0.3;
  }
  
  ///////////////////////////////////
  // draw fret numbers
  ///////////////////////////////////
  
  for( int i = 1; i < [noteXs count] ; i++ )
  {
    CGRect fretFrame = CGRectMake([[noteXs objectAtIndex:i] floatValue], fingerboardHeight + fretboardY, [[noteWidths objectAtIndex:i] floatValue], FINGERBOARD_NUMBERS_HEIGHT);
    CALayer *_fretLayer = [CALayer layer];
    _fretLayer.frame = fretFrame;
    _fretLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    CATextLayer *label = [CATextLayer new];
    [label setFont: @"Helvetica-Bold"];
    [label setFontSize: 20];
    [label setFrame: _fretLayer.bounds];
    [label setString: [[NSNumber numberWithInt:i ] stringValue]];
    [label setAlignmentMode: kCAAlignmentCenter];
    [label setForegroundColor: [[UIColor whiteColor] CGColor]];
    
    // make some numbers lighter
    if( i != 3 && i != 5 && i != 7 && i != 9  && i != 12 &&
        i != 15 && i != 17 && i != 19 && i != 21 && i != 24 )
      [label setOpacity:0.5];
    
    [_fretLayer addSublayer: label];
    [self.layer addSublayer: _fretLayer];
  }
  
  /////////////////////////////////////
  // make layers for each  note
  //////////////////////////////////////
  
  fretNoteLayer = [CALayer layer];
  fretNoteLayerControllers = [NSMutableArray new];
  fretNoteStrings = [NSMutableArray new];
  fretNoteLayer.opacity = 1;
  
  for( int string = 0; string < stringCount; string ++)
  {
    InstrumentString *instrumentString = [strings objectAtIndex:string];
    NSArray *notes = instrumentString.notes;
    
    float y = stringRectHeight * string;
    CALayer *stringLayer = [CALayer layer];
    [fretNoteStrings addObject:stringLayer];
    [fretNoteLayer addSublayer:stringLayer];
    
    for( int i = 0; i < [noteXs count]; i++)
    {
      CALayer *newLayer = [CALayer layer];
      
      float noteW = [[noteWidths objectAtIndex: i]floatValue];
      float noteX = [[noteXs objectAtIndex:i]floatValue];
      
      if( noteW > OPEN_STRING_WIDTH )
      {
        noteX = noteX + ( noteW - OPEN_STRING_WIDTH ) / 2;
        noteW = OPEN_STRING_WIDTH;
      }
      
      CGRect rect = CGRectMake( noteX, y + fretboardY + V_NOTE_SPACING, noteW, stringRectHeight - V_NOTE_SPACING - V_NOTE_SPACING);
      
      newLayer.frame = rect;
      newLayer.hidden = true;
      [stringLayer addSublayer: newLayer];
      
      UIFretNoteController *controler = [UIFretNoteController new];
      controler.note = [notes objectAtIndex:i];
      controler.stringInstrument =_instrument;
      controler.instrumentString = instrumentString;
      controler.trackIDObject = self.trackIDObject;
      controler.highlightSongKey = self.highlightSongKey;
      controler.highlightChord = self.highlightChord;
      controler.highlightChordScale = self.highlightChordScale;
      controler.showNoteNames = self.showNoteNames;
      controler.layer = newLayer;
      [fretNoteLayerControllers addObject: controler];
    }
  }
  
  [self.layer addSublayer:fretNoteLayer];
}

- (void) setTrackIDObject:(NSObject *)object
{
  _trackIDObject = object;
  if( _instrument != nil )
    [self setupFretboard];
}

- (void) setInstrument:(StringInstrument *)fb
{
  _instrument = fb;
  [self setupFretboard];
}

@end
