//
//  HorizontalItemList.m
//  aotulayout
//
//  Created by Lomo on 16/10/4.
//  Copyright © 2016年 Lomo. All rights reserved.
//

#import "HorizontalItemList.h"
@interface HorizontalItemList()

@end

CGFloat const btnWidth = 60;
CGFloat const padding = 10;
@implementation HorizontalItemList

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)HorizontalItemListWithSuperView:(UIView*)superView{
    CGFloat width = superView.bounds.size.width;
    CGFloat height = 80;
    CGFloat y = 120;
    HorizontalItemList * horizontalItemList = [[HorizontalItemList alloc] initWithFrame:CGRectMake(width, y, width, height)];
    
    horizontalItemList.alpha = 0.0;
    [horizontalItemList itemsInit];
    horizontalItemList.contentSize = CGSizeMake(padding * btnWidth, btnWidth + padding * 2);
    return horizontalItemList;
}

-(void)itemsInit{
    for (NSInteger i = 0; i < 10; ++i) {
        
        UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"summericons_100px_0%zd.png",i]];
        UIImageView * imageView =[[UIImageView alloc] initWithImage:image];
        imageView.center = CGPointMake( i * btnWidth + btnWidth * 0.5, btnWidth * 0.5);
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectItem:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
    }

}

-(void)selectItem:(UITapGestureRecognizer *)tap{
    !_selectItem?:_selectItem(tap.view.tag);
}

-(void)didMoveToSuperview{
    [super didMoveToSuperview];
    if (!self.superview) {
        return;
    }
    
    [UIView animateWithDuration:1 delay:0.03 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0;
        CGPoint center = self.center;
        center.x -= self.superview.bounds.size.width;
        self.center = center;
    } completion:^(BOOL finished) {
        
    }];
}
@end
