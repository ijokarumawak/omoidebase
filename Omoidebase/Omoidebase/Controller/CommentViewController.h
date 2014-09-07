//
//  CommentViewController.h
//  Omoidebase
//
//  Created by Couchmemories on 2014/09/07.
//  Copyright (c) 2014年 Ajinosashimi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Couchbaselite/CBLUITableSource.h>
#import "Area.h"

@interface CommentViewController : UIViewController
  <CBLUITableDelegate>

@property (nonatomic) IBOutlet CBLUITableSource* dataSource;

@property (nonatomic) Area *area;
@property (weak, nonatomic) IBOutlet UIWebView *web;

@end
