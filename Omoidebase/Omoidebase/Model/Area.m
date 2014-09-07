//
//  Area.m
//  Omoidebase
//


#import "Area.h"

@implementation Area

@dynamic image;

#pragma mark -
#pragma mark Class Methods
/**
 * ユーザー一覧を取得します。
 *
 * @param outError  エラー情報
 * @return  ユーザー一覧
 */
+ (CBLQuery *)findAreas:(NSError **)outError
{
  NSParameterAssert(self.database);
  
  return [[self getView] createQuery];
}

#pragma mark -
#pragma mark Private Methods
/**
 * ビューを取得します。
 *
 * @return ビュー
 */
+ (CBLView *)getView
{
  CBLView *view = [self.database viewNamed:AREA_VIEW];
  if (view && view.mapBlock) {
    return view;
  }
  
  [view setMapBlock: MAPBLOCK({
    if ([AREA_TYPE isEqualToString:doc[@"type"]]) {
      emit(doc[@"code"], doc);
    }
  }) version: @"1.1"];
  
  return view;
}
@end
