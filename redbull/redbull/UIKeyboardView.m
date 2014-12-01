
#import "UIKeyboardView.h"


@implementation UIKeyboardView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		keyboardToolbar = [[UIToolbar alloc] initWithFrame:frame];
		
		keyboardToolbar.barStyle = UIBarStyleDefault;
		
		UIBarButtonItem *previousBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"▲  ", @"")
																			style:UIBarButtonItemStyleBordered
																		   target:self
																		   action:@selector(toolbarButtonTap:)];
        previousBarItem.tintColor=[UIColor blackColor];
		previousBarItem.tag=1;

		
		UIBarButtonItem *nextBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"▼", @"")
																		style:UIBarButtonItemStyleBordered
																	   target:self
																	   action:@selector(toolbarButtonTap:)];
		nextBarItem.tag=2;
        nextBarItem.tintColor=[UIColor blackColor];
		
		UIBarButtonItem *spaceBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																					  target:nil
																					  action:nil];
		
		UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"完成", @"")
																		style:UIBarButtonItemStyleDone
																	   target:self
																	   action:@selector(toolbarButtonTap:)];
		doneBarItem.tag=3;
        doneBarItem.tintColor=[UIColor blackColor];
		
		[keyboardToolbar setItems:[NSArray arrayWithObjects:previousBarItem, nextBarItem, spaceBarItem, doneBarItem, nil]];
		[previousBarItem release];
		[nextBarItem release];
		[spaceBarItem release];
		[doneBarItem release];
		[self addSubview:keyboardToolbar];
		[keyboardToolbar release];
    }
    return self;
}

- (void)toolbarButtonTap:(UIButton *)button {
	if ([self.delegate respondsToSelector:@selector(toolbarButtonTap:)]) {
		[self.delegate toolbarButtonTap:button];
	}
}

@end

@implementation UIKeyboardView (UIKeyboardViewAction)

//根据index找出对应的UIBarButtonItem
- (UIBarButtonItem *)itemForIndex:(NSInteger)itemIndex {
	if (itemIndex < [[keyboardToolbar items] count]) {
		return [[keyboardToolbar items] objectAtIndex:itemIndex];
	}
	return nil;
}

@end
