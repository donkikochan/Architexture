//
//  EDatabase.h
//
//  Created by Jordi Badia Santaulària on 23/02/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sqlite3.h>

typedef sqlite3_int64 EInt64;

@class EQuery;

@interface EDatabase : NSObject

@property (nonatomic, readonly) sqlite3 *db;
@property (nonatomic, readonly, strong) NSString *dbFilename;
@property (nonatomic, readonly, strong) NSString *errMessage;
@property (nonatomic, readonly) int script;

- (id)init;
- (id)initWithScript:(int)script;

- (NSString*) defaultPath;
- (BOOL) openWithName:(NSString*)name;
- (BOOL) openWithPath:(NSString*)path andName:(NSString*)name;
- (void) close;

- (BOOL) beginTransaction;
- (BOOL) commitTransaction;
- (BOOL) rollbackTransaction;

- (EQuery*) createQuery;
- (EQuery*) prepareQuery:(NSString*)querySQL;
- (BOOL) execSQL:(NSString*)sql;

- (int) getMaxValueFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond;
- (int) getMaxValueFrom:(NSString*)table inField:(NSString*)field;
- (int) getMinValueFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond;
- (int) getMinValueFrom:(NSString*)table inField:(NSString*)field;
- (NSDate*) getMaxValueDateTimeFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond;
- (NSDate*) getMaxValueDateTimeFrom:(NSString*)table inField:(NSString*)field;
- (NSDate*) getMinValueDateTimeFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond;
- (NSDate*) getMinValueDateTimeFrom:(NSString*)table inField:(NSString*)field;
- (BOOL) recordExists:(NSString*)table useField:(NSString*)field andCondition:(NSString*)cond;
- (BOOL) recordExists:(NSString*)table useField:(NSString*)field;
- (int) getTableCount:(NSString*)table useField:(NSString*)field andCondition:(NSString*)cond;
- (int) getTableCount:(NSString*)table useField:(NSString*)field;
- (int) getTableCount:(NSString*)table;

- (NSString*) parseStringToSql:(NSString*)str;
- (NSString*) parseDateTimeToSql:(NSDate*)date;
- (NSString*) parseDateToSql:(NSDate*)date;
- (NSString*) parseDateTimeToSql:(NSDate*)date withQuotes:(BOOL)quotes;
- (NSString*) parseDateToSql:(NSDate*)date  withQuotes:(BOOL)quotes;

- (NSString*) dateFormat;
- (NSString*) dateTimeFormat;

- (void) setError;
- (void) setErrorCharPtr:(const char *)error;
- (void) setErrorString:(NSString*)error;

- (void) handleException:(NSException*)ex;

- (EInt64) getLastInsertRowID;
- (BOOL) existsTable:(NSString*)table;
- (BOOL) isEmptyDatabase;
- (BOOL) existsDatabaseControlTable;
- (BOOL) createDatabaseStructure;
- (BOOL) createDatabaseControlTable;
- (int) getDatabaseCurrentScript;
- (BOOL) upgradeDatabaseStructureFromStript:(int)fromScript;
- (BOOL) processScript:(int)script;
- (BOOL) processResourceFile:(NSString*)filename withTransaction:(BOOL)useTransaction;
- (BOOL) processResourceFile:(NSString*)filename;
@end


@interface EQuery : NSObject
{
    EDatabase *_database;
    sqlite3_stmt *_statement;
}

- (id) initWithDatabase:(EDatabase*)database;
- (BOOL) prepareWithSQL:(NSString*)sql;

- (BOOL) paramNull:(int)index;
- (BOOL) paramInt:(int)index value:(int)val;
- (BOOL) paramString:(int)index value:(NSString*)val;
- (BOOL) paramDouble:(int)index value:(double)val;
- (BOOL) paramDecimalNumber:(int)index value:(NSDecimalNumber*)val;
- (BOOL) paramDateTime:(int)index value:(NSDate*)val;
- (BOOL) paramDate:(int)index value:(NSDate*)val;
- (BOOL) paramData:(int)index value:(NSData*)data;
- (BOOL) paramImage:(int)index value:(UIImage *)image;
- (BOOL) read;
- (BOOL) execPrepared;

- (int) columnIndex:(NSString*)colName;
- (int) columnValueInt:(int)col;
- (EInt64) columnValueInt64:(int)col;
- (NSString*) columnValueString:(int)col;
- (double) columnValueDouble:(int)col;
- (NSDecimalNumber*) columnValueDecimalNumber:(int)col;
- (NSDate*) columnValueDateTime:(int)col;
- (NSDate*) columnValueDate:(int)col;
- (NSData*) columnValueData:(int)col;
- (UIImage*) columnValueImage:(int)col;
- (int) columnValueIntName:(NSString*)colName;
- (EInt64) columnValueInt64Name:(NSString*)colName;
- (NSString*) columnValueStringName:(NSString*)colName;
- (double) columnValueDoubleName:(NSString*)colName;
- (NSDecimalNumber*) columnValueDecimalNumberName:(NSString*)colName;
- (NSDate*) columnValueDateTimeName:(NSString*)colName;
- (NSDate*) columnValueDateName:(NSString*)colName;
- (NSData*) columnValueDataName:(NSString*)colName;
- (UIImage*) columnValueImageName:(NSString*)colName;

- (BOOL) reset;
- (BOOL) close;

@end