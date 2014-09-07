//
//  Document.h
//  Omoidebase
//


#import <CouchbaseLite/CouchbaseLite.h>

@interface Document : CBLModel

/**
 * ドキュメント種別
 */
@property (copy) NSString *type;

/**
 * コード
 */
@property NSString *code;

/**
 * 名称
 */
@property NSString *name;

@end
