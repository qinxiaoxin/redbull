//
//  BounceSheet.h
//  redbull
//
//  Created by LC on 14/12/15.
//  Copyright (c) 2014年 Xin Qin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BounceSheetDelegate;
@interface BounceSheet : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, readonly) CGSize screenSize;
@property (nonatomic) CGFloat x;

@property (nonatomic, strong, readonly) NSMutableArray *buttonTitles;
@property (nonatomic, strong, readonly) NSMutableArray *buttons;
@property (nonatomic, strong, readonly) NSMutableDictionary *buttonTitleAttributes;

@property (nonatomic, strong, readonly) NSArray *separators;

@property (nonatomic, strong) NSMutableDictionary *actionBlockForButtonIndex;

- (id)initWithDelegate:(id<BounceSheetDelegate>)delegate X:(CGFloat)x;
@property(nonatomic,assign) id<BounceSheetDelegate> delegate;

- (NSInteger)addButtonWithTitle:(NSString *)title;
- (NSInteger)addButtonWithTitle:(NSString *)title actionBlock:(void (^)())actionBlock;
- (NSString *)buttonTitleAtIndex:(NSInteger)buttonIndex;

@property(nonatomic,readonly) NSInteger numberOfButtons;

@property(nonatomic,readonly,getter=isVisible) BOOL visible;
@property(nonatomic, strong) UIColor *highlightedButtonColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *separatorColor UI_APPEARANCE_SELECTOR;

- (void)show;
- (void)dismissWithoutClickedButton;

- (NSDictionary *)buttonTextAttributesForState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (void)setButtonTextAttributes:(NSDictionary *)attributes forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (NSInteger)indexOfButton:(UIButton *)button;

@end

@protocol BounceSheetDelegate <NSObject>
@optional

- (void)actionSheet:(BounceSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)actionSheetCancel:(BounceSheet *)actionSheet;

- (void)willPresentActionSheet:(BounceSheet *)actionSheet;
- (void)didPresentActionSheet:(BounceSheet *)actionSheet;

- (void)actionSheet:(BounceSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)actionSheet:(BounceSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end