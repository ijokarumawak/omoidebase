//
//  SettingsViewController.m
//  Omoidebase
//
//  Created by Couchmemories on 2014/09/07.
//  Copyright (c) 2014年 Ajinosashimi. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  NSString *uid = [userDefaults stringForKey:@"uid"];
  if (!uid) {
    uid = @"";
  }
  NSString *pwd = [userDefaults stringForKey:@"pwd"];
  if (!pwd) {
    pwd = @"";
  }
  
  self.user.text = uid;
  self.password.text = pwd;

  
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionTappedDone:(id)sender
{
  NSString *uid = self.user.text;
  NSString *pwd = self.password.text;
  
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  [userDefaults setObject:uid forKey:@"uid"];
  [userDefaults setObject:pwd forKey:@"pwd"];
  
  [userDefaults synchronize];

  NSError *error = nil;
  DBManager *mgr = [DBManager sharedManager];
  [mgr stop];
  [mgr start:&error];

  // モーダルビューを閉じる
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)actionTappedCancel:(id)sender
{
  // モーダルビューを閉じる
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
