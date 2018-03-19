//
//  GameViewController.m
//  WD_ZOO
//
//  Created by 吴冬 on 2018/3/19.
//  Copyright © 2018年 吴冬. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController
{
    GameScene *scene;
    CGFloat   _last;
    CGFloat   _lastScale;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    //初始化数据
    _lastScale = 1;
    _last      = 1;
    
    
    
    // Load the SKScene from 'GameScene.sks'
    scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    
    // Set the scale mode to scale to fit the window
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.name = @"hahaha";
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:scene];
    
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinch.delegate = self;
    [self.view addGestureRecognizer:pinch];
    
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    
    if (pinch.scale > 1) {
        _lastScale = pinch.scale - _last + _lastScale;
        if (_lastScale > 3.0) {
            _lastScale = 3;
        }
        [scene pinchAction:_lastScale];
    }else{
        _lastScale = _lastScale - (_last - pinch.scale);
        if (_lastScale < 0.5) {
            _lastScale = 0.5;
        }
        [scene pinchAction:_lastScale];
    }
    
    _last = pinch.scale;
    if (pinch.state == UIGestureRecognizerStateEnded) {
        _last = 1;
    }
}



- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
