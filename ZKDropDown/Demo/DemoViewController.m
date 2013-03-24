//
//  DemoViewController.m
//  ZKDropDown
//
//  Created by Kheam on 21/03/13.
//  Copyright (c) 2013 zack. All rights reserved.
//

#import "DemoViewController.h"

@interface DemoViewController (){
    ZKDropdown *drop;
}

@end

@implementation DemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    drop = [[ZKDropdown alloc] initDropdownToObject:self.moveableBtn WithKeys:@[@"1234", @"Number 2", @"1234", @"Number 2", @"1234", @"Number 2",@"1234", @"Number 2"] andValues:nil withType:ZKSelectionModeSingle complete:^(BOOL isSelectedMade, id key, id value) {
        if (isSelectedMade) {
            [self.moveableBtn setTitle:key forState:UIControlStateNormal];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)dragMoveableBtn:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

- (IBAction)selectForMoveableBtn:(id)sender {
    NSLog(@"Clicked");
    [drop dropList];
}
@end
