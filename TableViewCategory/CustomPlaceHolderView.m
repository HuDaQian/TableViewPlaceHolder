//
//  CustomPlaceHolderView.m
//  TableViewCategory
//
//  Created by HuDaQian on 2016/12/19.
//  Copyright © 2016年 HuXiaoQian. All rights reserved.
//

#define SeparaHeight 20

#import "CustomPlaceHolderView.h"

@interface CustomPlaceHolderView(){
    UIImageView *customImageView;
    UILabel *customLabel;
}

@end

@implementation CustomPlaceHolderView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *cover = [[UIView alloc] initWithFrame:self.bounds];
        cover.backgroundColor = [UIColor blackColor];
        cover.alpha = 0.1;
        [self addSubview:cover];
        customImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, SeparaHeight, self.bounds.size.width, 2*(self.bounds.size.height-SeparaHeight*2)/3)];
        customImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:customImageView];
        customLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SeparaHeight+2*(self.bounds.size.height-SeparaHeight*2)/3, self.bounds.size.width, (self.bounds.size.height-SeparaHeight*2)/3)];
        customLabel.font = [UIFont systemFontOfSize:14.0f];
        customLabel.textAlignment = NSTextAlignmentCenter;
        customLabel.contentMode = UIViewContentModeCenter;
        [self addSubview:customLabel];
    }
    return self;
}

- (void)setPlaceHolderDataWithStatus:(BOOL)status {
    if (status) {
        customLabel.text = NSLocalizedString(@"NoData", nil);
        [customImageView setImage:[UIImage imageNamed:@"no_goods_pic"]];
    } else {
        customLabel.text = NSLocalizedString(@"ConnectError", nil);
        [customImageView setImage:[UIImage imageNamed:@"error"]];
    }
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

@end
