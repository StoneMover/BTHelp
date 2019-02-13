//
//  BTVerticalButton.m
//  VoiceBag
//
//  Created by HC－101 on 2018/6/20.
//  Copyright © 2018年 王迅. All rights reserved.
//

#import "BTButton.h"

@implementation BTButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews {
    [super layoutSubviews];
    switch (self.style) {
        case BTButtonStyleVertical:
        {
            // Center image
            CGPoint center = self.imageView.center;
            center.x = self.frame.size.width/2;
            center.y = self.imageView.frame.size.height/2;
            self.imageView.center = center;
            
            //Center text
            CGRect newFrame = [self titleLabel].frame;
            newFrame.origin.x = 0;
            newFrame.origin.y = self.imageView.frame.size.height + self.verticalValue;
            newFrame.size.width = self.frame.size.width;
            
            self.titleLabel.frame = newFrame;
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case BTButtonStyleHoz:
        {
            self.titleLabel.frame=CGRectMake(0, self.frame.size.height/2-self.titleLabel.frame.size.height/2, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
            self.imageView.frame=CGRectMake(self.titleLabel.frame.size.width+self.verticalValue, self.frame.size.height/2-self.imageView.frame.size.height/2, self.imageView.frame.size.width, self.imageView.frame.size.height);
            
        }
            break;
    }
    
}

-(void)setVerticalValue:(CGFloat)verticalValue{
    _verticalValue=verticalValue;
    [self setNeedsDisplay];
}

- (void)setStyle:(NSInteger)style{
    _style=style;
    [self setNeedsDisplay];
}

@end
