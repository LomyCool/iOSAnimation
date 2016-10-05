//
//  ViewController.m
//  aotulayout
//
//  Created by Lomo on 16/10/4.
//  Copyright © 2016年 Lomo. All rights reserved.
//

#import "ViewController.h"
#import "HorizontalItemList.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;
@property (weak, nonatomic) IBOutlet UIButton *menuBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuBtnHeightCons;
/*<#注释 #>*/
@property(nonatomic,strong)  NSMutableArray *  items;
/**<#注释#>*/
@property(nonatomic,weak)HorizontalItemList *horizontalList;
@end

static NSString  * const cellID = @"cellID";
@implementation ViewController{
    BOOL isMenuOpen;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [NSMutableArray arrayWithObjects:@5,@6,@7,nil];
  
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
      self.tableView.delegate = self;
    self.tableView.dataSource = self;
}


#pragma mark -UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _items.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSString * imageName = [NSString stringWithFormat:@"summericons_100px_0%@.png",_items[indexPath.row]];
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = imageName;
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    NSInteger tag = [_items[indexPath.row] integerValue];
    [self showItem:tag];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 动态添加一个imageView
//1.通过代码创建的控件,使用Autolayout布局时,需要手动关闭AutoresizingMask
// translatesAutoresizingMaskIntoConstraints = NO;
//2.使用9.0新出的api constraintEqualToAnchor: 添加约束
-(void)showItem:(NSInteger)tag{
    NSString * imageName = [NSString stringWithFormat:@"summericons_100px_0%zd.png",tag];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self.view addSubview:imageView];
    
    imageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    imageView.layer.cornerRadius = 5.0;
    imageView.layer.masksToBounds = YES;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;


    NSLayoutConstraint *conX = [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]; // centerX
     NSLayoutConstraint * conBottom = [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:imageView.frame.size.height]; // bottom 往下移动imageViewHeight距离
    NSLayoutConstraint * conWidth = [imageView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:0.33 constant:-50]; // 确定宽度 0x7ff452743560.width == 0.33*UIView:0x7ff452692a30.width + 50>
    NSLayoutConstraint * conHeight = [imageView.heightAnchor constraintEqualToAnchor:imageView.widthAnchor ]; // 宽高相等
    [NSLayoutConstraint activateConstraints:@[conX,conBottom,conHeight,conWidth]];
    [self.view layoutIfNeeded];
    
    
    [UIView animateWithDuration:0.8 delay: 0.0 usingSpringWithDamping: 0.4 initialSpringVelocity: 0.0 options: 0 animations:^{
                                   conBottom.constant = -imageView.frame.size.height/2;
                                   conWidth.constant = 0.0;
                                   [self.view layoutIfNeeded];

    }completion:^(BOOL finished) {
                NSLog(@"++++++%@",imageView);
    }];
    

    [UIView animateWithDuration:0.8 delay: 1.0
                               usingSpringWithDamping: 0.4 initialSpringVelocity: 0.0
                               options:0 animations:^{
                                   conBottom.constant = imageView.frame.size.height;
                                   conWidth.constant = -50.0;
                                   [self.view layoutIfNeeded ];
                               } completion:^(BOOL finished) {
                                   [imageView removeFromSuperview];
                               }];
     
}
- (IBAction)titleMenuBtnClick:(id)sender {
    //打印约束
    for (NSLayoutConstraint *con in _titleLabel.superview.constraints) {
        NSLog(@"->%@",[con description]);
    }
    
    isMenuOpen =! isMenuOpen;
    
    for (NSLayoutConstraint * con in _titleLabel.superview.constraints) {
        
        if (con.firstItem == _titleLabel && con.firstAttribute == NSLayoutAttributeCenterX) {
            con.constant = isMenuOpen ? -100:0;
            continue;
        }
        
        if ([con.identifier isEqualToString:@"TitleCenterY"]) {
            con.active = false;
            
            //添加新约束
            NSLayoutConstraint * newCon = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_titleLabel.superview attribute:NSLayoutAttributeCenterY multiplier:isMenuOpen? 0.67 :1.0 constant:0.5];
            newCon.identifier = @"TitleCenterY";
            newCon.active = YES;
            continue;
        }
    }
    _menuBtnHeightCons.constant
    = isMenuOpen ? 200:60;
    _titleLabel.text = isMenuOpen ? @"杂货区" :@"商店";
    
    // 旋转 + 按钮
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.view layoutIfNeeded];
        CGFloat angle = isMenuOpen ? M_PI_4 : 0;
        _menuBtn.transform = CGAffineTransformMakeRotation(angle);
    } completion:^(BOOL finished) {
        
    }];
    
    //添加水平list
    if (isMenuOpen) {
     
        HorizontalItemList * horizontalItemList = [HorizontalItemList HorizontalItemListWithSuperView:self.view];
        _horizontalList = horizontalItemList;
        [self.titleLabel.superview addSubview:horizontalItemList];
        horizontalItemList.selectItem = ^(NSInteger tag){
            [_items addObject:@(tag)];
            
            [self.tableView reloadData];
            [self titleMenuBtnClick:nil];
        };
    }
    else{
        [_horizontalList removeFromSuperview];
    }
   
    
}

@end
