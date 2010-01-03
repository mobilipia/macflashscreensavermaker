#import <ScreenSaver/ScreenSaver.h>
#import <WebKit/WebKit.h>
#import <Quartz/Quartz.h>

@class OptionsController;

// allow us to use setDrawsBackground: on WebView
@interface WebView (WebKitStuffThatShouldBeAPI)
- (void)setDrawsBackground:(BOOL)drawsBackground;
@end

@interface MacFlashScreensaverMakerView : ScreenSaverView {
	WebView *_screensaverWebView;
	IBOutlet id configSheet;
	OptionsController *_optionsController;
	NSTimer *_timer;
}
-(void)loadSWF;
/*
@property (retain) WebView *_screensaverWebView;
@property (retain) id configSheet;
@property (retain) OptionsController *_optionsController;
@property (retain) NSTimer *_timer;
*/
@end
