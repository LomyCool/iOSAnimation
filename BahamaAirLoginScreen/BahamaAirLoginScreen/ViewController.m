//
//  ViewController.m
//  BahamaAirLoginScreen
//
//  Created by Lomo on 16/10/5.
//  Copyright © 2016年 Lomo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cloud1;
@property (weak, nonatomic) IBOutlet UIImageView *cloud2;
@property (weak, nonatomic) IBOutlet UIImageView *cloud3;
@property (weak, nonatomic) IBOutlet UIImageView *cloud4;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
/**<#注释#>*/
@property(nonatomic,weak)UIImageView *status;

/**<#注释#>*/
@property(nonatomic,weak)UIActivityIndicatorView *spinner;
/**<#注释#>*/
@property(nonatomic,weak)UILabel *label;

/*<#注释#>*/
@property(nonatomic,copy) NSArray *messages;
@end

@implementation ViewController{
    CGPoint statusPosition;
}

- (void)viewDidLoad {
    [super viewDidLoad];
// set up UI
    //set up the UI
    _loginBtn.layer.cornerRadius = 8.0;
    _loginBtn.layer.masksToBounds = YES;
    UIActivityIndicatorView * spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _spinner = spinner;
    _spinner.frame = CGRectMake(20, 6, 20, 20);
    [_spinner startAnimating];
    _spinner.alpha = 0.0;
    [_loginBtn addSubview:spinner];
    UIImageView * status = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"banner"]];
    status.hidden = YES;
    status.center = _loginBtn.center;
    _status = status;
    [self.view addSubview:status ];
    UILabel * label = [[UILabel alloc] init];
    
    label.frame = CGRectMake(0, 0, status.frame.size.width, status.frame.size.height);
    label.font =  [UIFont fontWithName:@"HelveticaNeue" size:18.0];
    label.textColor = [UIColor colorWithRed:.89 green:.38 blue:0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    [status addSubview:label];
    _label = label;
    
    statusPosition = status.center;
    
    _messages = @[@"Connecting ...", @"Authorizing ...", @"Sending credentials ...", @"Failed"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    CGPoint center = _loginBtn.center;
    center.y += 30;
    _loginBtn.center = center;
    _loginBtn.alpha = 0.0;
    
    center = _userName.layer.position;
    center.x -=  self.view.bounds.size.width;
    _userName.layer.position = center;

    center = _password.layer.position;
    center.x -=  self.view.bounds.size.width;
    _password.layer.position = center;

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    CABasicAnimation * flyRight = [CABasicAnimation animationWithKeyPath:@"position.x"];
    flyRight.fromValue = @(- self.view.frame.size.width/2);
    flyRight.toValue = @(self.view.frame.size.width / 2);
    flyRight.duration = 0.5;
    flyRight.fillMode = kCAFillModeBoth;
//    flyRight.removedOnCompletion = NO;
    [_header.layer addAnimation:flyRight forKey:nil];
    
    flyRight.beginTime = CACurrentMediaTime() + 0.3;
    [_userName.layer addAnimation:flyRight forKey:nil];
//    _userName.layer.position = CGPointMake(self.view.frame.size.width * 0.5, _userName.layer.position.y);
    
    flyRight.beginTime = CACurrentMediaTime() + 0.4;
    [_password.layer addAnimation:flyRight forKey:nil];
    _password.layer.position = CGPointMake(self.view.frame.size.width * 0.5, _password.layer.position.y);
    
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0;
    fadeIn.toValue = @1.0;
    fadeIn.duration = 0.5;
    fadeIn.fillMode = kCAFillModeBackwards;
    fadeIn.beginTime = CACurrentMediaTime() + 0.5;
    [_cloud1.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.7;
    [_cloud2.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 0.9;
    [_cloud3.layer addAnimation:fadeIn forKey:nil];
    
    fadeIn.beginTime = CACurrentMediaTime() + 1.1;
    [_cloud4.layer addAnimation:fadeIn forKey:nil];
    
    
    [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0 options:0 animations:^{
        self.loginBtn.center = CGPointMake(self.loginBtn.center.x, self.loginBtn.center.y - 30);
        self.loginBtn.alpha = 1.0;
    } completion:^(BOOL finished) {
        
    }];
    
    [self animateCloud:_cloud1];
     [self animateCloud:_cloud2];
     [self animateCloud:_cloud3];
     [self animateCloud:_cloud4];
}



-(void)animateCloud:(UIImageView *)imageView{
    CGFloat speed = 60.0 / self.view.frame.size.width;
    CGFloat duration  = (self.view.frame.size.width - imageView.frame.origin.x) * speed;
    
    [UIView animateWithDuration:(NSTimeInterval)duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = imageView.frame;
        imageView.frame = CGRectMake(self.view.frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        CGRect initFrame = imageView.frame;
        initFrame.origin.x = - imageView.frame.size.width;
        imageView.frame = initFrame;
        [self animateCloud:imageView];
        NSLog(@"animateCloud");
    }];
}
-(void)animateCloud:(UIImageView *)imageView speed:(CGFloat )speed{
    speed = speed / self.view.frame.size.width;
    CGFloat duration  = (self.view.frame.size.width - imageView.frame.origin.x) * speed;
    
    [UIView animateWithDuration:(NSTimeInterval)duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = imageView.frame;
        imageView.frame = CGRectMake(self.view.frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        CGRect initFrame = imageView.frame;
        initFrame.origin.x = - imageView.frame.size.width;
        imageView.frame = initFrame;
        [self animateCloud:imageView];
    }];
}
- (IBAction)loginAction:(id)sender {
    self.loginBtn.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect frame = self.loginBtn.bounds;
        frame.size.width += 80;
        self.loginBtn.bounds = frame;
    } completion:^(BOOL finished) {
        
       
    }];

    [UIView animateWithDuration:0.33 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:0 animations:^{
        CGPoint center = self.loginBtn.center;
        center.y += 60;
        self.loginBtn.center =center;
        _spinner.center = CGPointMake(40, self.loginBtn.frame.size.height / 2);
        self.spinner.alpha = 1.0;
    } completion:^(BOOL finished) {
         [self showMessage:0];
    }];
    
    UIColor * tinColor = [UIColor colorWithRed:.85 green:.83 blue:.45 alpha:1];
    [self tintBackgroundColor:self.loginBtn.layer toColor:tinColor];
    [self roundCorners:self.loginBtn.layer toCornerRadius:25.0];
    
}

-(void)tintBackgroundColor:(CALayer *)layer toColor:(UIColor *)color{
    CABasicAnimation * tint = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    tint.fromValue = (__bridge id _Nullable)(layer.backgroundColor);
    tint.toValue = (__bridge id _Nullable)(color.CGColor);
    tint.duration = 1.0;
    [layer addAnimation:tint forKey:nil];
    layer.backgroundColor = color.CGColor;
}

-(void)roundCorners:(CALayer *)layer toCornerRadius:(CGFloat)cornerRadius{
    CABasicAnimation *round = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    round.fromValue = @(layer.cornerRadius);
    round.toValue = @(cornerRadius);
    round.duration =1.0;
    [layer addAnimation:round forKey:nil];
    layer.cornerRadius = cornerRadius;
}

-(void)showMessage:(NSInteger)index{
     _label.text = _messages[index];
    [UIView transitionWithView:_status duration:0.33 options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromBottom animations:^{
        self.status.hidden = NO;
    } completion:^(BOOL finished) {
        [self delay:2 completion:^{
            if (index < self.messages.count -1) {
                [self removeMessages:index];
            }
            else{
                [self resetForm];
            }
        }];
    }];
}

-(void)removeMessages:(NSInteger)index{
    [UIView animateWithDuration:0.33 delay:0 options:0 animations:^{
        CGPoint center = self.status.center;
        center.x += self.view.frame.size.width;
        self.status.center = center;
    } completion:^(BOOL finished) {
        self.status.hidden = true;
        self.status.center = statusPosition;
        [self showMessage:index+1];
    }];
}

-(void)resetForm{
    [UIView transitionWithView:_status duration:0.2 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        //隐藏tipMsg
        self.status.hidden = YES;
        self.status.center = statusPosition;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:0 animations:^{
            self.spinner.center = CGPointMake(-20, 16);
            self.spinner.alpha = 0;
            CGRect bounds = self.loginBtn.bounds;
            bounds.size.width -= 80;
            self.loginBtn.bounds = bounds;
            CGPoint center = self.loginBtn.center;
            center.y -=60;
            self.loginBtn.center = center;
            
        } completion:^(BOOL finished) {
            UIColor *tincolor = [UIColor colorWithRed:0.63 green:0.84 blue:0.35 alpha:1];
            [self tintBackgroundColor:self.loginBtn.layer toColor:tincolor];
            [self roundCorners:self.loginBtn.layer toCornerRadius:10.0];
             self.loginBtn.userInteractionEnabled = YES;
        }];
    }];
}

-(void)delay:(CGFloat)seconds completion:(void(^)())completion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !completion?:completion();
    });
}
@end
