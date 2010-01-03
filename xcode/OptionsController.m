#import "OptionsController.h"
#import <dlfcn.h>
#include <stdlib.h>
#include <Foundation/Foundation.h>

@implementation OptionsController

// ____________________________________________________________________________________________________ init

- (id)init
{
	self = [super initWithWindowNibName:@"OptionsWindow"];
	_swfIsLoaded = NO;
	return self;
}

-(void)dealloc
{
	[super dealloc];
}

- (void)windowDidLoad 
{
	[optionsWebView setDownloadDelegate:self];
	[optionsWebView setFrameLoadDelegate:self];
	[optionsWebView setResourceLoadDelegate:self];
	[optionsWebView setPolicyDelegate:self];
	[self loadSWF];
}

// ____________________________________________________________________________________________________ load SWF

- (void)loadSWF
{
	if ( _swfIsLoaded ) {
		return;
	}
	NSString *swfFile;
    NSBundle* thisBundle = [NSBundle bundleForClass:[self class]];
	swfFile = [thisBundle pathForResource:@"ExampleConfig" ofType:@"swf"];
	NSURL *url = [NSURL fileURLWithPath:swfFile];
	[[optionsWebView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];
	_swfIsLoaded = YES;
}

- (IBAction)okSelected:(id)sender
{
	[[NSApplication sharedApplication] endSheet:[self window]];
	[_delegate optionsWindowClosed];
}

// ____________________________________________________________________________________________________ delegate

- (void) setDelegate:(id)delegate
{
	_delegate = delegate;
}

- (id)delegate
{
	return _delegate;
}



//@synthesize optionsWebView;
//@synthesize _swfIsLoaded;
@end
