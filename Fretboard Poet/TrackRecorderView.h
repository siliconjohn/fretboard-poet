#import <UIKit/UIKit.h>
#import "TrackRecorder.h"

@interface TrackRecorderView : UIViewController
{
  TrackRecorder *trackRecorder;
}

@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

- (IBAction)recordButtonClick:(id)sender;

@end

