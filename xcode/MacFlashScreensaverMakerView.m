#import "MacFlashScreensaverMakerView.h"
#import "OptionsController.h"

@implementation MacFlashScreensaverMakerView

- (id)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
		[self setAnimationTimeInterval:-1];
 		_optionsController = [[OptionsController alloc] init];
		[_optionsController setDelegate:self];
		_screensaverWebView = [[WebView alloc] initWithFrame:NSMakeRect(0, 0, frame.size.width, frame.size.height)];
		[_screensaverWebView setFrameLoadDelegate:self];
		[_screensaverWebView setResourceLoadDelegate:self];
		[self addSubview:_screensaverWebView];
		[_screensaverWebView setAlphaValue:0.0f];
		[self loadSWF];
	}
    return self;
}

-(void)optionsWindowClosed
{
	[self loadSWF];
	[_optionsController release];
 	_optionsController = [[OptionsController alloc] init];
	[_optionsController setDelegate:self];
}
	
-(void)loadSWF
{
	NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
	NSString *swfFile= [thisBundle pathForResource:@"ExampleScreensaver" ofType:@"swf"];
	NSURL *url = [NSURL fileURLWithPath:swfFile];
	[[_screensaverWebView mainFrame] loadRequest:[NSURLRequest requestWithURL:url]];	
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame
{
	NSLog(@"didFinishLoadForFrame");
}

- (CAAnimation*)displayAnimationForKeyPath:(NSString*)keyPath from:(float)from to:(float)to duration:(float)duration
{
	CABasicAnimation *animation;
	animation					= [CABasicAnimation animationWithKeyPath:keyPath];		
	animation.fromValue			= [NSNumber numberWithFloat:from];
	animation.toValue			= [NSNumber numberWithFloat:to];
	animation.duration			= duration;
	animation.timingFunction	= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
	animation.fillMode			= kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	return animation;
}

- (void)webView:(WebView *)sender resource:(id)identifier didFinishLoadingFromDataSource:(WebDataSource *)dataSource
{
	[self performSelector:@selector(delayPassedSinceFinishLoadingFromDataSource) withObject:nil afterDelay:0.5];
}

- (void)delayPassedSinceFinishLoadingFromDataSource
{
	[_screensaverWebView layer].opacity = 0.0f;
	[_screensaverWebView setAlphaValue:1.0f];
	CAAnimation *animation = [self 
		displayAnimationForKeyPath:@"opacity"
		from:0.0f
		to:1.0f
		duration:1.0f
	];
	
	[[_screensaverWebView layer] addAnimation:animation forKey:@"opacityAnimation"];
}

- (void)dealloc 
{
	[_optionsController release];
	[_screensaverWebView release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect
{
	[[NSColor blackColor] set];
	[NSBezierPath fillRect:rect ];
}

- (void)animateOneFrame
{
    return;
}

-(void)showOptionsWindow
{
	[_optionsController showWindow:self];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    return [_optionsController window];
}

@end
