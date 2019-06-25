//
//  SMBtnAutoLayout.m
//  Base
//
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTKeyboardHelp.h"
#import "BTUtils.h"
#import "UIView+BTViewTool.h"

@interface BTKeyboardHelp()

//需要不被键盘遮挡的view在屏幕上的Y坐标
//@property(nonatomic,assign)CGFloat windowOriY;

//需要不被键盘遮挡的view对象
@property(nonatomic,weak)UIView * viewDisplay;

//需要显示的view在屏幕的y坐标
@property (nonatomic, assign) CGFloat viewDisplayScreenY;

//计算出需要移动的距离
@property(nonatomic,assign)CGFloat resutlY;

//将要移动的rootView,当键盘收起的时候会将其返回到0点的位置
@property (nonatomic, weak) UIView * viewMove;

//需要移动的view的 原始的y坐标
@property (nonatomic, assign) CGFloat viewMoveOriY;

//需要多加的间距
@property (nonatomic, assign) CGFloat moreMargin;

//是否有导航器，修正起始坐标问题
@property (nonatomic, assign) BOOL isNavHidden;

//约束的原始位置点
@property (nonatomic, assign) CGFloat viewOriContraintTop;

@end


@implementation BTKeyboardHelp

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin{
    self=[super init];
    self.moreMargin=margin;
    self.isKeyboardMoveAuto=YES;
    self.viewMove=moveView;
    [self addKeyBoardNofication];
    [self replaceDisplayView:showView withDistance:margin];
    return self;
}

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView{
    return [self initWithShowView:showView moveView:moveView margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin{
    return [self initWithShowView:showView moveView:[[[UIApplication sharedApplication] delegate] window] margin:margin];
}





//添加键盘监听通知
-(void)addKeyBoardNofication{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

//当键盘消失的时候调用
- (void)keyboardWillHide:(NSNotification *)notification{
    _isKeyBoardOpen=NO;
    
    if (self.isKeyboardMoveAuto) {
        if (self.contraintTop) {
            [UIView animateWithDuration:.25 animations:^{
                self.contraintTop.constant=self.viewOriContraintTop;
                [self.viewDisplay.superview layoutIfNeeded];
            }];
        }else{
            [UIView animateWithDuration:.25 animations:^{
                self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x,self.viewMoveOriY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
            }];
        }
        
    }
    
    if(self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillHide)]){
        [self.delegate keyboardWillHide];
    }
    self.resutlY=0;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification
{
    if (self.isPause) {
        return;
    }
    
    //获取键盘的高度
    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat keyboardHeight = keyboardRect.size.height;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    CGFloat keyboardY=window.frame.size.height-keyboardHeight;
    
    //计算需要移动的距离,键盘针对屏幕的y坐标如果大于需要显示view的y+height说明不会被遮挡则不需要移动,否则则需要将view的y坐标减去result的值保证不被遮挡
    CGFloat result=keyboardY-self.viewDisplay.frame.size.height-self.viewDisplayScreenY-self.moreMargin;
    if (result<0){
        CGFloat newY=self.viewMoveOriY+result;
        
        if (self.isKeyboardMoveAuto) {
            if (self.contraintTop) {
                [UIView animateWithDuration:.25 animations:^{
                    self.contraintTop.constant=self.viewOriContraintTop+result;
                    [self.viewDisplay.superview layoutIfNeeded];
                }];
            }else{
                [UIView animateWithDuration:.25 animations:^{
                    self.viewMove.frame = CGRectMake(self.viewMove.frame.origin.x, newY, self.viewMove.frame.size.width, self.viewMove.frame.size.height);
                }];
            }
            
        }
        
        
        _isKeyBoardOpen=YES;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardWillShow:)]) {
        [self.delegate keyboardWillShow:keyboardHeight];
    }
    self.resutlY=result;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyboardMove:)]) {
        [self.delegate keyboardMove:result];
    }
    
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)replaceDisplayView:(UIView*)viewDisplay withDistance:(NSInteger)distance{
    self.viewDisplay=viewDisplay;
    self.isNavHidden=self.viewDisplay.viewController.navigationController.navigationBar.hidden;
    self.viewMoveOriY=self.viewMove.frame.origin.y;
    //将移动view的坐标转换为屏幕坐标
    CGRect rect =[self.viewDisplay convertRect: self.viewDisplay.bounds toView:[[[UIApplication sharedApplication] delegate] window]];
    self.viewDisplayScreenY=rect.origin.y;
    if (!self.isNavHidden) {
        self.viewDisplayScreenY+=BTUtils.NAVCONTENT_HEIGHT;
    }
    
    if (!self.contraintTop) {
        for (NSLayoutConstraint * c in viewDisplay.constraints) {
            if (c.identifier&&[c.identifier isEqualToString:@"BT_KEYBOARD_CONSTRAING_ID"]) {
                self.contraintTop=c;
                break;
            }
        }
    }
    
    
}

- (void)setIsNavHidden:(BOOL)isNavHidden{
    _isNavHidden=isNavHidden;
    if (!isNavHidden) {
        self.viewMoveOriY+=BTUtils.NAV_HEIGHT;
    }else{
        self.viewMoveOriY-=BTUtils.NAV_HEIGHT;
    }
}

- (void)setContraintTop:(NSLayoutConstraint *)contraintTop{
    _contraintTop=contraintTop;
    self.viewOriContraintTop=contraintTop.constant;
}

-(void)dealloc{
    [self removeNotification];
}

@end
