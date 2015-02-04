//
//  AddBookViewController.m
//  TestProlific
//
//  Created by Bharath G M on 2/3/15.
//  Copyright (c) 2015 Bharath G M. All rights reserved.
//

#import "AddBookViewController.h"

@interface AddBookViewController ()

@end

@implementation AddBookViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Add Book";
   
    UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    
    self.navigationItem.rightBarButtonItem = addBarButtonItem;

}

-(void)done
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
