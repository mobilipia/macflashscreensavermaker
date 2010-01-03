#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface OptionsController : NSWindowController {
	IBOutlet WebView *optionsWebView;
	id _delegate;
	BOOL _swfIsLoaded;
}

- (IBAction)okSelected:(id)sender;
- (void)setDelegate:(id)delegate;
- (id)delegate;
- (void)loadSWF;

//@property (retain) WebView *optionsWebView;
//@property (assign,getter=delegate,setter=setDelegate:) id _delegate;
//@property BOOL _swfIsLoaded;

@end

@interface OptionsController(OptionsControllerDelegate)
-(void)optionsWindowClosed;
@end
