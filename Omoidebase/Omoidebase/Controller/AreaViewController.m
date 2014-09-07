//
//  MasterViewController.m
//  Omoidebase
//


#import "AreaViewController.h"
#import "DetailViewController.h"
#import "AreaCell.h"

@interface AreaViewController () {
    NSMutableArray *_objects;
}
@end

@implementation AreaViewController

- (void)awakeFromNib
{
  if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
      self.clearsSelectionOnViewWillAppear = NO;
      self.preferredContentSize = CGSizeMake(320.0, 600.0);
  }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  
  NSError *error = nil;
  CBLQuery *query = [Area findAreas:&error];

  CBLQueryEnumerator *rows = [query run:&error];
  int cnt = rows.count;
  NSLog(@"Area=%d", cnt);

  if (_dataSource) {
    _dataSource.query = query.asLiveQuery;
    _dataSource.query.descending = NO;
    _dataSource.tableView = self.tableView;
  }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  CBLQueryRow *row = [self.dataSource rowAtIndex:indexPath.row];
  Area *area = [Area modelForDocument: row.document];

  CommentViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"comment"];
  ctrl.area = area;
  
  // 画面遷移
  [self.navigationController pushViewController:ctrl animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = _objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

/*
 * QRコードメニュー
 */
- (IBAction)actionTappedQR:(id)sender
{
  UIActionSheet *sheet = [[UIActionSheet alloc] init];
  sheet.tag = 1;
  sheet.delegate = self;
  sheet.cancelButtonIndex = 2;
  
  [sheet addButtonWithTitle:@"カメラから取得"];
  [sheet addButtonWithTitle:@"写真ライブラリから取得"];
  [sheet addButtonWithTitle:@"キャンセル"];

  [sheet showInView:self.view];
}

/**
 * アクションシートのボタンがタップされた時のデリゲートメソッドです。
 *
 * @param actionSheet アクションシート
 * @param buttonIndex ボタン番号
 */
- (void)actionSheet:(UIActionSheet *)actionSheet
  clickedButtonAtIndex:(NSInteger)buttonIndex
{
  if (buttonIndex == 0) {
    // カメラ起動
    QRCaptureViewController *ctrl = [self.storyboard instantiateViewControllerWithIdentifier:@"qrcapture"];
    ctrl.delegete = self;
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:ctrl];
    [self presentViewController:navi animated:YES completion: nil];
  } else if (buttonIndex == 1) {
    // ライブラリ
    UIImagePickerController *ctrl = [[UIImagePickerController alloc] init];
    ctrl.allowsEditing = NO;
    ctrl.delegate = self;
    ctrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:ctrl  animated:YES completion: nil];
  }
}

/**
 * 選択
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
  UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
  if (!image) {
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
  }
  
  NSString *qrcode = @"a0261b89-3344-4626-b6c9-8232f916d969";
  [self setQRcode:qrcode];
  
  // モーダルビューを閉じる
  [self dismissViewControllerAnimated:YES completion:NULL];
}

/**
 * 閉じる
 */
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
  // モーダルビューを閉じる
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)auth:(NSString *)qrcode
{
  qrcode = @"a0261b89-3344-4626-b6c9-8232f916d969";

  // TODO
  if (!(qrcode == Nil || qrcode.length <= 0)) {
    if (qrcode.length == 36) {
      return YES;
    }
  }
  
  return NO;
}

- (void)setQRcode:(NSString *)qrcode
{
  NSError *error = nil;

  if (!(qrcode == Nil || qrcode.length <= 0)) {
    
    
    self.qrcode = qrcode;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *uid = [userDefaults stringForKey:@"uid"];
    if (uid == Nil || uid.length <= 0) {
      return;
    }
    
    User *user = [User findUser:uid error:&error];
    if (user) {
      NSMutableArray *items = [NSMutableArray arrayWithArray:user.places];
      [items addObject:qrcode];
      user.places = items;
      [user save:&error];

    }
    
    
  } else {
    self.qrcode = @"";
  }
/*
  UIAlertView *alert =
  [[UIAlertView alloc] initWithTitle:@"debug" message:qrcode
                            delegate:self cancelButtonTitle:@"確認" otherButtonTitles:nil];
  [alert show];
 */
}


- (void)couchTableSource:(CBLUITableSource*)source
         updateFromQuery:(CBLLiveQuery*)query
            previousRows:(NSArray *)previousRows
{
  [self.tableView reloadData];
}

- (UITableViewCell *) couchTableSource:(CBLUITableSource *)source
                 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  AreaCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
  
  CBLQueryRow *queryRow =  [source rowAtIndex:indexPath.row];
  Area *area = [Area modelForDocument:queryRow.document];
  
  cell.name.text = area.name;
  
  NSData *data = [[NSData alloc] initWithBase64EncodedString:area.image options:NSDataBase64DecodingIgnoreUnknownCharacters];
  if (data) {
    UIImage *img = [[UIImage alloc] initWithData:data];
    [cell.image setImage:img];
  }
  
  return cell;
  
}
@end
