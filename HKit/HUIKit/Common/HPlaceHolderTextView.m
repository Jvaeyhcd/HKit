//
//  HPlaceHolderTextView.m
//  AFNetworking
//
//  Created by Salvador on 2020/2/6.
//

#import "HPlaceHolderTextView.h"
#import "NSString+HAdd.h"

@interface HPlaceHolderTextView()

@property (nonatomic, strong) UILabel *placeHolderLabel;

@end

@implementation HPlaceHolderTextView

CGFloat const UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION = 0.25;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
#if __has_feature(objc_arc)
#else
    [_placeHolderLabel release]; _placeHolderLabel = nil;
    [_placeholderColor release]; _placeholderColor = nil;
    [_placeholder release]; _placeholder = nil;
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    // Use Interface Builder User Defined Runtime Attributes to set
    // placeholder and placeholderColor in Interface Builder.
    if (!self.placeholder) {
        _placeholder = @"";
    }
    
    if (!self.placeholderColor) {
        [self setPlaceholderColor:[UIColor lightGrayColor]];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        _placeholder = @"";
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self placeholder] length] == 0)
    {
        return;
    }
    
    [UIView animateWithDuration:UI_PLACEHOLDER_TEXT_CHANGED_ANIMATION_DURATION animations:^{
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
        }
    }];
}

- (void)setText:(NSString *)text {
    [super setText:text];
    if (![NSString isBlankString:text]) {
        [[self viewWithTag:999] setAlpha:0];
    }
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        UIEdgeInsets insets = self.textContainerInset;
        if (_placeHolderLabel == nil )
        {
            
            _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),1.0)];
            _placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            _placeHolderLabel.font = self.placeholderFont ?: [UIFont systemFontOfSize:14];
            _placeHolderLabel.backgroundColor = [UIColor clearColor];
            _placeHolderLabel.textColor = self.placeholderColor;
            _placeHolderLabel.alpha = 0;
            _placeHolderLabel.tag = 999;
            _placeHolderLabel.numberOfLines = 0;
            [self addSubview:_placeHolderLabel];
        }
        _placeHolderLabel.text = self.placeholder;
        [_placeHolderLabel sizeToFit];
        [_placeHolderLabel setFrame:CGRectMake(insets.left+5,insets.top,self.bounds.size.width - (insets.left +insets.right+10),CGRectGetHeight(_placeHolderLabel.frame))];
        [self sendSubviewToBack:_placeHolderLabel];
    }
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 ) {
        [[self viewWithTag:999] setAlpha:1];
    } else {
        [[self viewWithTag:999] setAlpha:0];
    }
    
    [super drawRect:rect];
}
- (void)setPlaceholder:(NSString *)placeholder{
    if (_placeholder != placeholder) {
        _placeholder = placeholder;
        [self setNeedsDisplay];
    }
    
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    if (_placeholderFont != placeholderFont) {
        _placeholderFont = placeholderFont;
        [self setNeedsDisplay];
    }
}

@end
