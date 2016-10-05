//
//  HorizontalItemList.h
//  aotulayout
//
//  Created by Lomo on 16/10/4.
//  Copyright © 2016年 Lomo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalItemList : UIScrollView
+(instancetype) HorizontalItemListWithSuperView:(UIView *)superView;
/*<#注释#>*/
@property(nonatomic,copy) void((^selectItem)(NSInteger tag));
@end
