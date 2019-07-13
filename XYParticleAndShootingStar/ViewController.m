//
//  ViewController.m
//  XYParticleAndShootingStar
//
//  Created by 闫世超 on 2019/7/11.
//  Copyright © 2019 闫世超. All rights reserved.
//

#import "ViewController.h"
#import "XYParticAndShootingStarController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(UIButton *)sender {
    XYParticAndShootingStarController * vc = [[XYParticAndShootingStarController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
