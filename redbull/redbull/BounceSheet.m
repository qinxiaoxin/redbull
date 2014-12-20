//
//  BounceSheet.m
//  redbull
//
//  Created by LC on 14/12/15.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import "BounceSheet.h"

#define kButtonHeight 50.f
#define kAnimationDuration 0.2f
#define kSeparatorWidth .5f
#define kMargin 10.f
#define kBottomMargin 5.f

static UIWindow *__sheetWindow = nil;

@implementation BounceSheet

@synthesize buttonTitles = _buttonTitles;
@synthesize buttons = _buttons;
@synthesize buttonTitleAttributes = _buttonTitleAttributes;

- (id)initWithDelegate:(id<BounceSheetDelegate>)delegate X:(CGFloat)x
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        _delegate = delegate;
        _x = x;
        [self _commonInit];
    }
    
    return self;
}

- (void)_commonInit
{
//    self.backgroundColor = [UIColor colorWithRed:44 / 255.f green:44 / 255.f blue:44 / 255.f alpha:1.f];
    self.backgroundColor = hll_color(44, 44, 44, 1);
//    _highlightedButtonColor = [UIColor colorWithRed:254 / 255.f green:0 / 255.f blue:0 / 255.f alpha:1.f];
    _highlightedButtonColor = hll_color(254, 0, 0, 1);
//    _separatorColor = [UIColor colorWithRed:18 / 255.f green:18 / 255.f blue:18 / 255.f alpha:1.f];
    _separatorColor = hll_color(18, 18, 18, 1);
    
//    self.layer.cornerRadius = 8.f;
//    self.clipsToBounds = YES;
}

#pragma mark -
- (NSInteger)addButtonWithTitle:(NSString *)title
{
    if (!title) {
        [self.buttonTitles addObject:@""];
    } else [self.buttonTitles addObject:title];
    
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    newButton.titleLabel.font = [UIFont systemFontOfSize:16.f];
    [newButton setFrame:CGRectMake(0, 0, self.screenSize.width, kButtonHeight)];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setTitleColor:hll_color(187, 187, 187, 1) forState:UIControlStateNormal];
    [newButton addTarget:self action:@selector(dismissWithClickedButton:) forControlEvents:UIControlEventTouchUpInside];
    NSUInteger index = [self.buttons count];
    
    [self addSubview:newButton];
    [self.buttons addObject:newButton];
    [self.buttonTitles addObject:title];
    
    return index;
    
}

- (NSInteger)addButtonWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock
{
    NSInteger index = [self addButtonWithTitle:title];
    [self.actionBlockForButtonIndex setObject:actionBlock forKey:[NSNumber numberWithInteger:index]];
    return index;
}

- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex
{
    return self.buttonTitles[buttonIndex];
}

#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentWidth = ScreenWidth/4;
    
    CGFloat sheetHeight = [self.buttons count] * kButtonHeight;
    
    CGFloat contentOffset = ScreenHeight - sheetHeight  - kBottomMargin -44/*tabbar height*/;
    
    self.frame = CGRectMake(_x, contentOffset, contentWidth, sheetHeight);
    
    contentOffset = 0.f;
    
    for (UIButton *button in self.buttons) {
        button.frame = CGRectMake(0.f, contentOffset, contentWidth, kButtonHeight);
        contentOffset += kButtonHeight;
    }
}

#pragma mark - Show

- (void)show {
    UIWindow *window = [[UIWindow alloc] initWithFrame:(CGRect) {{0.f, 0.f}, self.screenSize}];
    window.backgroundColor = [UIColor clearColor];
    window.windowLevel = UIWindowLevelNormal;
    window.userInteractionEnabled = YES;
    window.alpha = 1.f;
    
    UITapGestureRecognizer *singleTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissWithoutClickedButton)];
    singleTap.numberOfTapsRequired=1;
    singleTap.delegate=self;
    [window addGestureRecognizer:singleTap];
    
    [self layoutIfNeeded];
    
    for (UIView *separator in self.separators) {
        [self addSubview:separator];
    }
    
    [window addSubview:self];
    
    window.hidden = NO;
    
    self.frame = CGRectOffset(self.frame, 0.f, self.frame.size.height+kMargin+44);
    
    if ([self.delegate respondsToSelector:@selector(willPresentActionSheet:)]) {
        [self.delegate willPresentActionSheet:self];
    }
    
    [UIView animateWithDuration:kAnimationDuration delay:0.f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = CGRectOffset(self.frame, 0.f, -(self.frame.size.height+kMargin+44));
    } completion:^(BOOL finished) {
//        [self addObserversInButtonsForKeyPath:@"highlighted"];
        if ([self.delegate respondsToSelector:@selector(didPresentActionSheet:)]) {
            [self.delegate didPresentActionSheet:self];
        }
    }];
    
    __sheetWindow = window;
}

#pragma mark - Dismissal

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [self dismissAnimated:animated clickedButtonIndex:buttonIndex];
}

- (void)dismissWithClickedButton:(UIButton *)button
{
    
    NSInteger buttonIndex = [self indexOfButton:button];
    
    void (^actionBlockForButton)() = [self.actionBlockForButtonIndex objectForKey:[NSNumber numberWithInteger:buttonIndex]];
    
    if (actionBlockForButton) {
        actionBlockForButton();
    } else if ([self.delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [self.delegate actionSheet:self clickedButtonAtIndex:buttonIndex];
    }
    [self dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (void)dismissAnimated:(BOOL)animated clickedButtonIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(actionSheet:willDismissWithButtonIndex:)]) {
        [self.delegate actionSheet:self willDismissWithButtonIndex:index];
    }
    if (animated) {
        [UIView animateWithDuration:kAnimationDuration animations:^{
            [self dismissTransition];
        } completion:^(BOOL finished) {
            [self dismissCompletionWithButtonAtIndex:index];
        }];
    } else {
        [self dismissCompletionWithButtonAtIndex:index];
    }
}

- (void)dismissTransition
{
    self.frame = CGRectOffset(self.frame, 0.f, self.frame.size.height + kBottomMargin+44);
}

- (void)dismissCompletionWithButtonAtIndex:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(actionSheet:didDismissWithButtonIndex:)]) {
        [self.delegate actionSheet:self didDismissWithButtonIndex:index];
    }
    
    __sheetWindow.hidden = YES;
//    [self removeObserversInButtonsForKeyPath:@"highlighted"];
    __sheetWindow = nil;
}

- (void)dismissWithoutClickedButton
{
    [UIView animateWithDuration:kAnimationDuration animations:^{
        [self dismissTransition];
    } completion:^(BOOL finished) {
        if ([self.delegate respondsToSelector:@selector(actionSheetCancel:)]) {
            [self.delegate actionSheetCancel:self];
        }
        
        __sheetWindow.hidden = YES;
//        [self removeObserversInButtonsForKeyPath:@"highlighted"];
        __sheetWindow = nil;
    }];
}

#pragma mark - KVO

- (void)addObserversInButtonsForKeyPath:(NSString *)keypath
{
    for (UIButton *button in self.buttons) {
        [button addObserver:self forKeyPath:keypath options:0 context:NULL];
    }
}

- (void)removeObserversInButtonsForKeyPath:(NSString *)keypath
{
    for (UIButton *button in self.buttons) {
        [button removeObserver:self forKeyPath:keypath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    UIButton *button = object;
    if ([button isKindOfClass:[UIButton class]]) {
        [UIView animateWithDuration:0.2f animations:^{
            if (button.isHighlighted) {
                
                NSLog(@"highlighted");
                
                button.backgroundColor = _highlightedButtonColor;
                [button setTitleColor:hll_color(255, 255, 255, 1) forState:UIControlStateHighlighted];
            }
            
            
            else button.backgroundColor = [UIColor clearColor];
        }];
    }
}

#pragma mark - Appearance
- (void)setButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state
{
    [UIView performWithoutAnimation:^{
        [self.buttonTitleAttributes setObject:attributes forKey:[NSNumber numberWithInt:state]];
        for (UIButton *button in self.buttons) {
            NSAttributedString *attributedTitleForState = [[NSAttributedString alloc] initWithString:[button titleForState:state] attributes:attributes];
            [button setAttributedTitle:attributedTitleForState forState:state];
        }
    }];
}

- (NSDictionary *)buttonTextAttributesForState:(UIControlState)state {
    return [self.buttonTitleAttributes objectForKey:[NSNumber numberWithInt:state]];
}

#pragma mark - Getters
- (NSInteger)indexOfButton:(UIButton *)button
{
    return [self.buttons indexOfObject:button];
}

- (NSMutableDictionary *)actionBlockForButtonIndex
{
    if (!_actionBlockForButtonIndex) {
        _actionBlockForButtonIndex = [NSMutableDictionary dictionary];
    }
    return _actionBlockForButtonIndex;
}
- (NSMutableDictionary *)buttonTitleAttributes
{
    if (!_buttonTitleAttributes) {
        _buttonTitleAttributes = [@{@(UIControlStateNormal): @{}, @(UIControlStateHighlighted): @{}, @(UIControlStateDisabled): @{}, @(UIControlStateSelected): @{}, @(UIControlStateApplication): @{}, @(UIControlStateReserved): @{}} mutableCopy];
    }
    return _buttonTitleAttributes;
}

- (NSInteger)numberOfButtons
{
    return [self.buttons count];
}

- (NSArray *)separators
{
    NSInteger buttonCount = self.buttons.count;
    NSMutableArray *mutableSeparators = [NSMutableArray arrayWithCapacity:buttonCount];
    
    CGFloat contentOffset = kButtonHeight - kSeparatorWidth;
    for (int i = 0; i < buttonCount; i++) {
        UIView *separator = [[UIView alloc] initWithFrame:CGRectMake(0, contentOffset, self.frame.size.width, kSeparatorWidth)];
        separator.backgroundColor = self.separatorColor;
        contentOffset += kButtonHeight;
        [mutableSeparators addObject:separator];
    }
    
    return [mutableSeparators copy];
}

- (CGSize)screenSize
{
    return [[UIScreen mainScreen] bounds].size;
}

- (UIColor *)separatorColor
{
    if (!_separatorColor) {
        return [UIColor clearColor];
    }
    return _separatorColor;
}

- (BOOL)isVisible
{
    return [self window] ? YES : NO;
}

- (NSMutableArray *)buttonTitles
{
    if (!_buttonTitles) {
        _buttonTitles = [NSMutableArray array];
    }
    return _buttonTitles;
}

- (NSMutableArray *)buttons
{
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
@end
