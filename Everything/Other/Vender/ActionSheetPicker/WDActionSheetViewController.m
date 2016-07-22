
//
//  WDActionSheetViewController.m
//  Everything
//
//  Created by Louis on 16/7/22.
//  Copyright © 2016年 Louis. All rights reserved.
//

#import "WDActionSheetViewController.h"
#import "WDActionSheetPickerView.h"


@interface WDActionSheetViewController ()<UIApplicationDelegate>

@end

@implementation WDActionSheetViewController

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewDidLoad
{
    // 点击手势
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:singleRecognizer];
}

- (void)showPickerView:(WDActionSheetPickerView*)pickerView completion:(void (^)(void))completion
{
    _pickerView = pickerView;
    
    //  Getting topMost ViewController
    UIViewController *topController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    while ([topController presentedViewController])	topController = [topController presentedViewController];
    
    [topController.view endEditing:YES];
    
    //Sending pickerView to bottom of the View.
    __block CGRect pickerViewFrame = pickerView.frame;
    {
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        pickerView.frame = pickerViewFrame;
        [self.view addSubview:pickerView];
    }
    
    //Adding self.view to topMostController.view and adding self as childViewController to topMostController
    {
        self.view.frame = CGRectMake(0, 0, topController.view.bounds.size.width, topController.view.bounds.size.height);
        self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [topController addChildViewController: self];
        [topController.view addSubview: self.view];
    }
    
    //Sliding up the pickerView with animation
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
        
        pickerViewFrame.origin.y = self.view.bounds.size.height-pickerViewFrame.size.height;
        pickerView.frame = pickerViewFrame;
        
    } completion:^(BOOL finished) {
        if (completion) completion();
    }];
}

-(void)dismissWithCompletion:(void (^)(void))completion
{
    //Sliding down the pickerView with animation.
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState|7<<16 animations:^{
        
        self.view.backgroundColor = [UIColor clearColor];
        CGRect pickerViewFrame = _pickerView.frame;
        pickerViewFrame.origin.y = self.view.bounds.size.height;
        _pickerView.frame = pickerViewFrame;
        
    } completion:^(BOOL finished) {
        
        //Removing pickerView from self.view
        [_pickerView removeFromSuperview];
        
        //Removing self.view from topMostController.view and removing self as childViewController from topMostController
        [self willMoveToParentViewController:nil];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
        if (completion) completion();
    }];
}

- (void)singleTap:(id)sender
{
    if ([_pickerView.delegate respondsToSelector:@selector(actionSheetPickerViewWillCancel:)])
    {
        [_pickerView.delegate actionSheetPickerViewWillCancel:_pickerView];
    }
    [self dismissWithCompletion:nil];
}

@end
