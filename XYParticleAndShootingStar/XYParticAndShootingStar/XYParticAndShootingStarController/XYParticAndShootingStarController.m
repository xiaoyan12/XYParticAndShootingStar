//
//  XYParticAndShootingStarController.m
//  XYParticleAndShootingStar
//
//  Created by 闫世超 on 2019/7/11.
//  Copyright © 2019 闫世超. All rights reserved.
//

#import "XYParticAndShootingStarController.h"


#define SCREEN_WIDTH     [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT    [[UIScreen mainScreen] bounds].size.height

@interface XYParticAndShootingStarController ()

@property (nonatomic , strong) UIImageView *bg_image;

@property (nonatomic , strong) UIButton *cancelBtn;

@property (nonatomic, strong) CAEmitterLayer *emitterLayer;
@property (nonatomic, strong) UIView *emitterView;

@end

@implementation XYParticAndShootingStarController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bg_image];
    [self.view addSubview:self.cancelBtn];
    
    [self initEmitterLayer];
    
    [self createShootingStarUI];
    
    // Do any additional setup after loading the view.
}

- (UIImageView *)bg_image{
    if (!_bg_image) {
        _bg_image = [[UIImageView alloc] init];
        _bg_image.frame = self.view.bounds;
        _bg_image.image = [UIImage imageNamed:@"bg_image"];
    }
    return _bg_image;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(0, 34.0f, 44.0f, 44.0f);
        _cancelBtn.backgroundColor = [UIColor yellowColor];
        [_cancelBtn addTarget:self action:@selector(cancelBtncClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (void)cancelBtncClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}



//粒子发射器
- (void)initEmitterLayer{
    
    _emitterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _emitterView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_emitterView];
    
    
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    //展示的图片
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"partic"].CGImage);
    
    //每秒粒子产生个数的乘数因子，会和layer的birthRate相乘，然后确定每秒产生的粒子个数
//    cell.birthRate = 2000;
    cell.birthRate = 10;
    //每个粒子存活时长
    cell.lifetime = 10.0;
    //粒子生命周期范围
    cell.lifetimeRange = 0.3;
    //粒子透明度变化，设置为－0.4，就是每过一秒透明度就减少0.4，这样就有消失的效果,一般设置为负数。
    cell.alphaSpeed = -0.1;
    cell.alphaRange = 0.5;
    //粒子的速度
    cell.velocity = 10;
    //粒子的速度范围
    cell.velocityRange = 20;
    //周围发射的角度，如果为M_PI*2 就可以从360度任意位置发射
            cell.emissionRange = M_PI*2;
    //粒子内容的颜色
    //    cell.color = [[UIColor whiteColor] CGColor];
    
    cell.redRange = 0.5;
    cell.blueRange = 0.5;
    cell.greenRange = 0.5;
    
    //缩放比例
    cell.scale = 0.2;
    //缩放比例范围
    cell.scaleRange = 0.02;
    
    //粒子的初始发射方向
    cell.emissionLongitude = M_PI;
    //Y方向的加速度
//    cell.yAcceleration = 40.0;
    //X方向加速度
    //    cell.xAcceleration = 20.0;
    
    _emitterLayer = [CAEmitterLayer layer];
    
    //发射位置
    _emitterLayer.emitterPosition = CGPointMake(SCREEN_WIDTH/2.0, 0);
    //粒子产生系数，默认为1
    _emitterLayer.birthRate = 1;
    //发射器的尺寸
    _emitterLayer.emitterSize = CGSizeMake(SCREEN_WIDTH, 0);
    //发射的形状
    _emitterLayer.emitterShape = kCAEmitterLayerCuboid;
    //发射的模式
    _emitterLayer.emitterMode = kCAEmitterLayerOutline;
    //渲染模式
    _emitterLayer.renderMode = kCAEmitterLayerUnordered;
    
    _emitterLayer.zPosition = -1;
    _emitterLayer.emitterCells = @[cell];
    [self.emitterView.layer addSublayer:_emitterLayer];
}


- (void)createShootingStarUI{
    CAEmitterLayer *rain = [CAEmitterLayer layer];
    //发射位置
    rain.emitterPosition = CGPointMake(-300, 0);
    //粒子产生系数，默认为1
    rain.birthRate = 1;
    //发射器的尺寸
    rain.emitterSize = CGSizeMake(4000, 0);
    //发射的形状
    rain.emitterShape = kCAEmitterLayerCuboid;
    //发射的模式
    rain.emitterMode = kCAEmitterLayerLine;
    //渲染模式
    rain.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *cell = [CAEmitterCell emitterCell];
    //设置粒子每秒的生成数量
    cell.birthRate = 10;
    //设置生成时的初始速度的变化范围
    cell.velocity = 500.0f;
    cell.velocityRange = 300.0f;
    //设置粒子的Y轴加速度
    cell.yAcceleration = 0.0f;
    //缩放比例
    cell.scale= 0.5f;
    //缩放速度
    cell.scaleSpeed = 0.1;
    //每个粒子存活时长
    cell.lifetime = 1.8f;
    //粒子的初始发射方向
    cell.emissionLongitude = 0.75*M_PI;
    //展示的图片
    cell.contents = (__bridge id _Nullable)([UIImage imageNamed:@"star"].CGImage);
    //设置颜色
    cell.color = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor;

    rain.emitterDepth = 10.0f;
    rain.shadowOpacity = 0.0f;
    rain.shadowRadius = 0.0f;
    rain.emitterCells = [NSArray arrayWithObject:cell];
    [self.view.layer addSublayer:rain];
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
