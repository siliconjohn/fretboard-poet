#import "UIFretNoteController.h"

NSString * const NOTE_ON_NOTIFICATION = @"NOTE_ON_NOTIFICATION";
NSString * const NOTE_OFF_NOTIFICATION = @"NOTE_OFF_NOTIFICATION";
NSString * const ALL_NOTES_OFF_NOTIFICATION = @"ALL_NOTES_OFF_NOTIFICATION";

@implementation UIFretNoteController

@synthesize layer = _layer, note = _note, instrumentString = _instrumentString, stringInstrument = _stringInstrument, trackIDObject = _trackIDObject;

- (id) init
{
  if(self = [super init])
  {
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(noteOnNotification:)
     name:NOTE_ON_NOTIFICATION
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(noteOffNotification:)
     name:NOTE_OFF_NOTIFICATION
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(allNotesOffNotification:)
     name:ALL_NOTES_OFF_NOTIFICATION
     object:nil];
  }
  return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
  // blue
  if (hasChord && ! hasChordScale )
  {
    CGColorRef bgColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.9].CGColor;
    CGContextSetFillColorWithColor(context, bgColor);

    CGRect rect = layer.bounds;
    rect.origin.x = rect.size.width / 2;
    CGContextFillRect(context, rect);
  }
}

- (void)noteOnNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:_trackIDObject])return;
  
  NSString *myNote = [self.note valueForKey:@"note"];
  
  hasChord = false;
  hasChordScale = false;
  hasKey = false;
  
  if(self.highlightChord == true )
  {
    NSArray *notesInChord = [notification.userInfo valueForKey:@"notesInChord"];
    
    for(NSDictionary *note in notesInChord)
    {
      if([[note valueForKey:@"note"] isEqual:myNote])
      {
        hasChord = true;
        break;
      }
    }
  }
  
  if(self.highlightChordScale == true )
  {
    NSArray *notesInScale = [notification.userInfo valueForKey:@"notesInScale"];
    
    for(NSDictionary *note in notesInScale)
    {
      if([[note valueForKey:@"note"] isEqual:myNote])
      {
        hasChordScale = true;
        break;
      }
    }
  }

  if(self.highlightSongKey == true )
  {
    NSArray *notesInKey = [notification.userInfo valueForKey:@"notesInKey"];
    
    for(NSDictionary *note in notesInKey)
    {
      if([[note valueForKey:@"note"] isEqual:myNote])
      {
        hasKey = true;
        break;
      }
    }
  }

  /////////////////////////
  // draw note
  /////////////////////////
  
  bool showNote = false;
  
  if( hasChord || hasChordScale || hasKey )
  {
    showNote = true;
    
    self.layer.backgroundColor =  [UIColor clearColor].CGColor;
    
    // set to gray
    if (hasKey)
    {  self.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.9].CGColor;
    }
    
    if (hasChordScale)
    {
      self.layer.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.9].CGColor;
    }

    // green
    if (hasChord)
    {
      self.layer.backgroundColor = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.9].CGColor;
    }
    
//    // blue
//    if (hasChord && ! hasChordScale )
//    {
//      self.layer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.9].CGColor;
//    }
    
    [self.layer setNeedsDisplay];
  }
  
  ////////////////////////
  
  if( showNote )
  {
    if(self.layer.hidden == YES )
    {
//      [_layer setNeedsDisplay];
//      [CATransaction begin];
//      [CATransaction setDisableActions:YES];
      self.layer.hidden = NO;
//      [CATransaction commit];
    }
  }
  else
  {
    if(self.layer.hidden == NO )
    {
//      [CATransaction begin];
//      [CATransaction setDisableActions:YES];
      self.layer.hidden = YES;
//      [CATransaction commit];
    }
  }
}

- (void)noteOffNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:_trackIDObject])return;
}

- (void)allNotesOffNotification:(NSNotification*)notification;
{
  if(![notification.object isEqual:_trackIDObject])return;
  
  if(self.layer.hidden == NO )
  {
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];
    self.layer.hidden = YES;
//    [CATransaction commit];
  }
}

- (void) setLayer:(CALayer *)layer
{
  _layer = layer;
  _layer.masksToBounds = YES;
  _layer.cornerRadius = 14.0;
  _layer.delegate = self;
  
  CATextLayer *label = [CATextLayer new];
  [label setFont: @"Helvetica-Bold"];
  [label setFontSize: 20];
  CGRect rect =  _layer.bounds;
  rect.origin.y = (rect.size.height - 20 -4 ) / 2;
  
  [label setFrame:rect];
  
  [label setString: [self.note valueForKey:@"name"]];
  [label setAlignmentMode: kCAAlignmentCenter];
  [label setForegroundColor: [[UIColor whiteColor] CGColor]];
  label.shadowColor = [[UIColor blackColor] CGColor];
  label.shadowOffset = CGSizeMake(1.0, 1.0);
  label.shadowOpacity = 0.9;
  label.shadowRadius = 0.0;
  [label setContentsScale:[[UIScreen mainScreen] scale]];
  [_layer addSublayer:label];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
