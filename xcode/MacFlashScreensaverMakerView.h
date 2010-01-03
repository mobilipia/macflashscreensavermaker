#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>
#import <Quartz/Quartz.h>

@class OptionsController;

@interface MacFlashScreensaverMakerView : ScreenSaverView {
	WebView *_screensaverWebView;
	IBOutlet id configSheet;
	OptionsController *_optionsController;
}
-(void)loadSWF;
@end
