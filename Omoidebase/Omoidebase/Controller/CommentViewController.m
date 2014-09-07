//
//  CommentViewController.m
//  Omoidebase
//
//  Created by Couchmemories on 2014/09/07.
//  Copyright (c) 2014年 Ajinosashimi. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
  
  NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
  NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
  NSString *web = [dict valueForKeyPath:@"web"];

  web = [NSString stringWithFormat:web, self.area.code];
  NSLog(@"URL=%@", web);
  NSURL *url = [NSURL URLWithString:web];

  //self.web.scalesPageToFit = YES;
  NSURLRequest *req = [NSURLRequest requestWithURL:url];
  [self.web loadRequest:req];
  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



@end
