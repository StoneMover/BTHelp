//
//  SMBtnAutoLayout.m
//  Base
//
//  Created by whbt_mac on 15/11/6.
//  Copyright © 2015年 StoneMover. All rights reserved.
//

#import "BTKeyboardHelp.h"

@interface BTKeyboardHelp()


@property(nonatomic,assign)int windowOriY;//需要不被键盘遮挡的view在屏幕上的Y坐标
@property(nonatomic,weak)UIView * viewDisplay;//需要显示的view对象

@property (nonatomic, assign) int viewDisplayScreenY;//需要显示的view在屏幕的y坐标

@property(nonatomic,assign)int resutlY;//计算出需要移动的距离

//将要移动的rootView,当键盘收起的时候会将其返回到0点的位置
@property (nonatomic, weak) UIView * moveView;

@end


@implementation BTKeyboardHelp

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView margin:(NSInteger)margin{
    self=[super init];
    self.moveView=moveView;
    if (!self.moveView) {
        self.moveView=[[[UIApplication sharedApplication] delegate] window];
    }
    [self addKeyBoardNofication];
    [self replaceDisplayView:showView withDistance:margin];
    return self;
}

- (instancetype)initWithShowView:(UIView*)showView moveView:(UIView*)moveView{
    return [self initWithShowView:showView moveView:moveView margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView{
    return [self initWithShowView:showView moveView:nil margin:0];
}

- (instancetype)initWithShowView:(UIView*)showView margin:(NSInteger)margin{
    return [self initWithShowView:showView moveView:nil margin:margin];
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
- (void)keyboardWillHide:(NSNotification *)not{
    _isKeyBoardOpen=NO;
    self.moveView.frame = CGRectMake(self.moveView.frame.origin.x,0, self.moveView.frame.size.width, self.moveView.frame.size.height);
    if(self.delegate&&[self.delegate respondsToSelector:@selector(keyBoardWillHide)]){
        [self.delegate keyBoardWillHide];
    }
    self.resutlY=0;
}

//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (self.isPause) {
        return;
    }
    
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int keyboardHeight = keyboardRect.size.height;
    UIWindow * window=[[[UIApplication sharedApplication] delegate] window];
    int keyboardY=window.frame.size.height-keyboardHeight;
    
    //计算需要移动的距离,键盘针对屏幕的y坐标如果大于需要显示view的y+height说明不会被遮挡则不需要移动,否则则需要将view的y坐标减去result的值保证不被遮挡
    int result=keyboardY-self.viewDisplay.frame.size.height-self.viewDisplayScreenY;
    if (result<0){
        int newY=self.windowOriY+result;
        
        if (self.moveView==nil) {
            self.moveView=window;
        }
        self.moveView.frame = CGRectMake(0, newY, self.moveView.frame.size.width, self.moveView.frame.size.height);
        _isKeyBoardOpen=YES;
    }
    
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyBoardWillShow:)]) {
        [self.delegate keyBoardWillShow:keyboardHeight];
    }
    self.resutlY=result;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(keyBoardMove:)]) {
        [self.delegate keyBoardMove:result];
    }
    
}

-(void)removeNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


-(void)replaceDisplayView:(UIView*)displayView withDistance:(NSInteger)distance{
    self.viewDisplay=displayView;
    self.windowOriY=self.moveView.frame.origin.y;
    //将移动view的坐标转换为屏幕坐标
    self.viewDisplayScreenY=[self.viewDisplay convertRect: self.viewDisplay.bounds toView:self.moveView].origin.y+distance;
    
}

-(void)dealloc{
    [self removeNotification];
}

@end
