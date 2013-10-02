//
//  EDatabase.m
//
//  Created by Jordi Badia Santaulària on 23/02/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import "EDatabase.h"
#import "ECommon.h"
#import "FileReader.h"
#import "EConsts.h"

#pragma EDatabase

@implementation EDatabase

@synthesize db=_db, dbFilename, errMessage, script=_script;

- (id)init
{
    self = [super init];
    _script = 0;
    return self;
}

- (id)initWithScript:(int)script
{
    self = [super init];
    _script = script;
    return self;
}

- (NSString*) defaultPath
{
    return [ECommon documentsPath];
}

- (BOOL) openWithName:(NSString*)name
{
    return [self openWithPath:[self defaultPath] andName:name];
}

- (BOOL) openWithPath:(NSString*)path andName:(NSString*)name
{
#ifdef DEBUG_EDATABASE
    NSLog(@"EDatabase.m >> path: %@; name: %@", path, name);
#endif
    
    dbFilename = [path stringByAppendingPathComponent:name];

#ifdef DEBUG_EDATABASE
    NSLog(@"EDatabase.m >> dbFilename: %@", dbFilename);
#endif
    
    if (_db != nil)
        return TRUE;
    
    @try
    {
        BOOL result = sqlite3_open([dbFilename UTF8String], &_db) == SQLITE_OK;
        if (!result)
            [self setError];
        
        if (result && _script > 0)
        {
            int maxScript = [self getDatabaseCurrentScript];
#ifdef DEBUG_EDATABASE
            NSLog(@"EDatabase.m >> script: %d; maxScript: %d", _script, maxScript);
#endif
            if (maxScript <= 0)
            {
                if (![self createDatabaseStructure])
                {
                    [self close];
                    return FALSE;
                }
            }
            else if (maxScript < self.script)
            {
                if (![self upgradeDatabaseStructureFromStript:maxScript+1])
                {
                    [self close];
                    return FALSE;
                }
            }
        }
        return result;
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
        return FALSE;
    }
}

- (void) close
{
    if (_db != nil)
    {
        sqlite3_close(_db);
        _db = nil;
    }
}

- (BOOL) beginTransaction
{
    return [self execSQL:@"BEGIN TRANSACTION"];
}

- (BOOL) commitTransaction
{
    return [self execSQL:@"COMMIT"];
}

- (BOOL) rollbackTransaction
{
    return [self execSQL:@"ROLLBACK"];
}

- (EQuery*) createQuery
{
#if !OBJC_ARC_ENABLED
    return [[[EQuery alloc] initWithDatabase:self] autorelease];
#else
    return [[EQuery alloc] initWithDatabase:self];
#endif
}

- (EQuery*) prepareQuery:(NSString*) querySQL
{
    EQuery* query = [self createQuery];
    if ([query prepareWithSQL:querySQL])
        return query;
    else
        return nil;
}

- (BOOL) execSQL:(NSString*)sql
{
    char* errmsg;
    @try
    {
#ifdef DEBUG_EDATABASE
        NSLog(@"EDatabase.m >> execSQL: %@", sql);
#endif
        if (sqlite3_exec(_db, [sql UTF8String], NULL, NULL, &errmsg) == SQLITE_OK)
            return TRUE;
        else
        {
#ifdef DEBUG_EDATABASE
            NSLog(@"EDatabase.m >> execSQL error: %s", errmsg);
#endif
            [self setErrorCharPtr:errmsg];
            sqlite3_free(errmsg);
            return FALSE;
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
        return FALSE;
    }
}

- (int) getMaxValueFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond
{
    int result = 0;
    NSString* sql = [NSString stringWithFormat:@"SELECT MAX(%@) FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        if ([query read])
        {
            result = [query columnValueInt:0];
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (int) getMaxValueFrom:(NSString*)table inField:(NSString*)field
{
    return [self getMaxValueFrom:table inField:field andCondition:@""];
}

- (int) getMinValueFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond
{
    int result = 0;
    NSString* sql = [NSString stringWithFormat:@"SELECT MIN(%@) FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        if ([query read])
        {
            result = [query columnValueInt:0];
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (int) getMinValueFrom:(NSString*)table inField:(NSString*)field
{
    return [self getMinValueFrom:table inField:field andCondition:@""];
}

- (NSDate*) getMaxValueDateTimeFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond
{
    NSDate *result = nil;
    NSString* sql = [NSString stringWithFormat:@"SELECT MAX(%@) FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        if ([query read])
        {
            result = [query columnValueDateTime:0];
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (NSDate*) getMaxValueDateTimeFrom:(NSString*)table inField:(NSString*)field
{
    return [self getMaxValueDateTimeFrom:table inField:field andCondition:@""];
}

- (NSDate*) getMinValueDateTimeFrom:(NSString*)table inField:(NSString*)field andCondition:(NSString*)cond
{
    NSDate *result = nil;
    NSString* sql = [NSString stringWithFormat:@"SELECT MIN(%@) FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        if ([query read])
        {
            result = [query columnValueDateTime:0];
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (NSDate*) getMinValueDateTimeFrom:(NSString*)table inField:(NSString*)field
{
    return [self getMinValueDateTimeFrom:table inField:field andCondition:@""];
}

- (BOOL) recordExists:(NSString*)table useField:(NSString*)field andCondition:(NSString*)cond
{
    BOOL result = FALSE;
    NSString* sql = [NSString stringWithFormat:@"SELECT %@ FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        result = [query read];
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (BOOL) recordExists:(NSString*)table useField:(NSString*)field
{
    return [self recordExists:table useField:field andCondition:@""];
}

- (int) getTableCount:(NSString*)table useField:(NSString*)field andCondition:(NSString*)cond
{
    int result = 0;
    NSString* sql = [NSString stringWithFormat:@"SELECT COUNT(%@) FROM %@", field, table];
    if(cond != nil && cond.length > 0)
    {
        sql = [sql stringByAppendingFormat:@" WHERE %@", cond];
    }
    EQuery* query = [self prepareQuery:sql];
    @try
    {
        if ([query read])
        {
            result = [query columnValueInt:0];
        }
    }
    @catch (NSException *exception)
    {
        [self handleException:exception];
    }
    @finally
    {
        [query close];
    }
    
    return result;
}

- (int) getTableCount:(NSString*)table useField:(NSString*)field
{
    return [self getTableCount:table useField:field andCondition:@""];
}

- (int) getTableCount:(NSString*)table
{
    return [self getTableCount:table useField:@"*" andCondition:@""];
}

- (NSString*) parseStringToSql:(NSString*)str
{
    if (str == nil || str.length == 0)
        return @"";
    
    return [str stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
}

- (NSString*) parseDateTimeToSql:(NSDate*)date
{
    return [self parseDateTimeToSql:date withQuotes:true];
}

- (NSString*) parseDateToSql:(NSDate*)date
{
    return [self parseDateToSql:date withQuotes:true];
}

- (NSString*) parseDateTimeToSql:(NSDate*)date withQuotes:(BOOL)quotes
{
    if (date == nil)
        return @"null";
    
    NSString *format;
    if (quotes)
        format = @"'%@'";
    else
        format = @"%@";
    
    return [NSString stringWithFormat:format,[ECommon formatDate:date withFormat:[self dateTimeFormat]]];
}

- (NSString*) parseDateToSql:(NSDate*)date  withQuotes:(BOOL)quotes
{
    if (date == nil)
        return @"null";
    
    NSString *format;
    if (quotes)
        format = @"'%@'";
    else
        format = @"%@";
    
    return [NSString stringWithFormat:format,[ECommon formatDate:date withFormat:[self dateFormat]]];
}

- (NSString*) dateFormat
{
    return @"yyyy-MM-dd";
}

- (NSString*) dateTimeFormat;
{
    return @"yyyy-MM-dd HH:mm:ss";
}

- (void) setError
{
    [self setErrorCharPtr:sqlite3_errmsg(_db)];
}

- (void) setErrorCharPtr:(const char *)error
{
    NSLog(@"EDatabase.m >> setErrorCharPtr: %s", error);
    errMessage = [NSString stringWithCString:error encoding:NSUTF8StringEncoding];
}

- (void) setErrorString:(NSString*)error
{
    NSLog(@"EDatabase.m >> setErrorString: %@", error);
    errMessage = error;
}

- (void) handleException:(NSException*)ex
{
    NSLog(@"EDatabase.m >> handleException: %@", ex.description);
    errMessage = ex.description;
    NSLog(@"%@", ex.description);
}

- (BOOL) existsTable:(NSString*)table
{
    EQuery* query = nil;
    @try
    {
        query = [self prepareQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@",table]];
        if ([query read])
            return TRUE;
        else
            return FALSE;
    }
    @catch (NSException *exception)
    {
        return FALSE;
    }
    @finally
    {
        if (query != nil)
            [query close];
    }
}

- (EInt64) getLastInsertRowID
{
    EQuery *query = [self prepareQuery:@"select last_insert_rowid();"];
    if ([query read])
        return [query columnValueInt64:0];
    return -1;
}

- (BOOL) isEmptyDatabase
{
    return ![self existsDatabaseControlTable];
}

- (BOOL) existsDatabaseControlTable
{
    return [self existsTable:DB_CONTROL_TABLE_NAME];
}

- (BOOL) createDatabaseStructure
{
    if (![self createDatabaseControlTable])
        return FALSE;
    else
        return [self upgradeDatabaseStructureFromStript:1];
}

- (BOOL) createDatabaseControlTable
{
    return [self execSQL:DB_CONTROL_TABLE_CREATE];
}

- (int) getDatabaseCurrentScript
{
    EQuery* query = nil;
    @try
    {
        query = [self prepareQuery:DB_CONTROL_TABLE_CURR_SCRIPT];
        if ([query read])
            return [query columnValueInt:0];
        else
            return -1;
    }
    @catch (NSException *exception)
    {
        return -1;
    }
    @finally
    {
        if (query != nil)
            [query close];
    }
}

- (BOOL) upgradeDatabaseStructureFromStript:(int)fromScript
{
#ifdef DEBUG_EDATABASE
    NSLog(@"EDatabase.m >> upgradeDatabaseStructureFromStript: %d", fromScript);
#endif
    for (int i=fromScript; i<=_script; i++)
    {
        if (![self processScript:i])
            return FALSE;
    }
    return TRUE;
}


- (BOOL) processScript:(int)script
{
    [self beginTransaction];
    BOOL res = [self processResourceFile:[NSString stringWithFormat:DB_SCRIPTS_NAME_FORMAT,script] withTransaction:FALSE] &&
               [self execSQL:[NSString stringWithFormat:DB_CONTROL_TABLE_INSERT,script]];
    if (res)
        [self commitTransaction];
    else
        [self rollbackTransaction];
    return res;
}

- (BOOL) processResourceFile:(NSString*)filename  withTransaction:(BOOL)useTransaction
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:@""];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        [self setErrorString:[NSString stringWithFormat:@"File %@ not found!", filename]];
        return FALSE;
    }
    
    BOOL res = TRUE;
    NSString *line;
    FileReader *reader = [[FileReader alloc] initWithFilePath:filePath];
    if (useTransaction)
        [self beginTransaction];
    @try
    {
        while (res && (line = [reader readTrimmedLine]))
        {
            if (line.length>0 && ![line hasPrefix:@"--"] && ![line isEqualToString:@"\n"])
            {
                res = [self execSQL:line];
            }
        }
    }
    @catch (NSException *exception)
    {
        res = FALSE;
        [self setErrorString:exception.description];
    }
    @finally
    {
#if !OBJC_ARC_ENABLED
        [reader release];
#endif
        if (useTransaction)
        {
            if (res)
                [self commitTransaction];
            else
                [self rollbackTransaction];
        }
    }
    return res;
}

- (BOOL) processResourceFile:(NSString*)filename
{
    return [self processResourceFile:filename withTransaction:TRUE];
}
@end


#pragma EQuery

@implementation EQuery

- (id) initWithDatabase:(EDatabase*)database
{
    self = [super init];
    _database = database;
    return self;
}

- (BOOL) prepareWithSQL:(NSString*) sql
{
    if (_statement != nil)
        [self close];
    
#ifdef DEBUG_EDATABASE
    NSLog(@"EDatabase.m >> prepareWithSQL: %@", sql);
#endif
    
    @try
    {
        BOOL res = sqlite3_prepare_v2(_database.db, [sql UTF8String], -1, &_statement, NULL) == SQLITE_OK;
        if (!res)
            [_database setError];
        return res;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) paramNull:(int)index
{
    @try
    {
        return sqlite3_bind_null(_statement, index+1) == SQLITE_OK;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) paramInt:(int)index value:(int)val
{
    @try
    {
        return sqlite3_bind_int(_statement, index+1, val) == SQLITE_OK;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) paramString:(int)index value:(NSString*)val
{
    @try
    {
        return sqlite3_bind_text(_statement, index+1, [val UTF8String], -1, SQLITE_TRANSIENT) == SQLITE_OK;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) paramDouble:(int)index value:(double)val
{
    @try
    {
        return sqlite3_bind_double(_statement, index+1, val) == SQLITE_OK;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) paramDecimalNumber:(int)index value:(NSDecimalNumber*)val
{
    return [self paramDouble:index value:[val doubleValue]];
}

- (BOOL) paramDateTime:(int)index value:(NSDate*)val
{
    if (val == nil)
        return [self paramNull:index];
    else
        return [self paramString:index value:[_database parseDateTimeToSql:val withQuotes:FALSE]];
}

- (BOOL) paramDate:(int)index value:(NSDate*)val
{
    return [self paramString:index value:[_database parseDateToSql:val withQuotes:FALSE]];
}

- (BOOL) paramData:(int)index value:(NSData*)data
{
    if (data == nil || data.length == 0)
        return sqlite3_bind_blob(_statement, index+1, nil, -1, NULL) == SQLITE_OK;
    else
    {
#ifdef DEBUG_EDATABASE
        NSLog(@"EDatabase.m >> paramData > data.len: %d", data.length);
#endif
        return sqlite3_bind_blob(_statement, index+1, data.bytes, data.length, NULL) == SQLITE_OK;
    }
}

- (BOOL) paramImage:(int)index value:(UIImage *)image
{
    if (image == nil)
        return [self paramData:index value:nil];
    else
    {
        NSData* imgData = UIImagePNGRepresentation(image);
#ifdef DEBUG_EDATABASE
        NSLog(@"EDatabase.m >> paramImage > image.width: %f; image.height: %f", image.size.width, image.size.height);
#endif
        return [self paramData:index value:imgData];
    }
}

- (BOOL) read
{
    return sqlite3_step(_statement) == SQLITE_ROW;
}

- (BOOL) execPrepared
{
    @try
    {
        int r = sqlite3_step(_statement);
        BOOL res = r == SQLITE_OK || r == SQLITE_DONE;
        if (!res)
        {
            [_database setError];
        }
        return res;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (int) columnIndex:(NSString*)colName
{
    @try
    {
        const char* name = [colName UTF8String];
        for(int i=0; i<sqlite3_column_count(_statement); i++)
        {
            if (strcasecmp(name, sqlite3_column_name(_statement, i)) == 0)
                return i;
        }
        return -1;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (int) columnValueInt:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return 0;

    return sqlite3_column_int(_statement, col);
}

- (EInt64) columnValueInt64:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return 0;
    
    return sqlite3_column_int64(_statement, col);
}

- (NSString*) columnValueString:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return @"";

    return [NSString stringWithCString:(const char *)sqlite3_column_text(_statement, col) encoding:NSUTF8StringEncoding];
}

- (double) columnValueDouble:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return 0;

    return sqlite3_column_double(_statement, col);
}

- (NSDecimalNumber*) columnValueDecimalNumber:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return 0;

#if !OBJC_ARC_ENABLED
    NSDecimalNumber *val = [[[NSDecimalNumber alloc] initWithDouble:[self columnValueDouble:col]] autorelease];
#else
    NSDecimalNumber *val = [[NSDecimalNumber alloc] initWithDouble:[self columnValueDouble:col]];
#endif
    return val;
}

- (NSDate*) columnValueDateTime:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return nil;

    NSString* str = [self columnValueString:col];
    if (str == nil || str.length == 0)
        return nil;
    
    return [ECommon dateFromString:str withFormat:[_database dateTimeFormat]];
}

- (NSDate*) columnValueDate:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return nil;

    NSString* str = [self columnValueString:col];
    if (str == nil || str.length == 0)
        return nil;
    
    return [ECommon dateFromString:str withFormat:[_database dateFormat]];
}

- (NSData*) columnValueData:(int)col
{
    if (sqlite3_column_type(_statement, col) == SQLITE_NULL)
        return nil;

#if !OBJC_ARC_ENABLED
    NSData *data = [[[NSData alloc] initWithBytes:sqlite3_column_blob(_statement, col) length:sqlite3_column_bytes(_statement, col)] autorelease];
#else
    NSData *data = [[NSData alloc] initWithBytes:sqlite3_column_blob(_statement, col) length:sqlite3_column_bytes(_statement, col)];
#endif
    return data;
}

- (UIImage*) columnValueImage:(int)col;
{
    NSData *data = [self columnValueData:col];
    if (data == nil)
        return nil;
    
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

- (int) columnValueIntName:(NSString*)colName
{
    return [self columnValueInt:[self columnIndex:colName]];
}

- (EInt64) columnValueInt64Name:(NSString*)colName
{
    return [self columnValueInt64:[self columnIndex:colName]];
}

- (NSString*) columnValueStringName:(NSString*)colName
{    
    return [self columnValueString:[self columnIndex:colName]];
}

- (double) columnValueDoubleName:(NSString*)colName
{
    return [self columnValueDouble:[self columnIndex:colName]];
}

- (NSDecimalNumber*) columnValueDecimalNumberName:(NSString*)colName
{
    return [self columnValueDecimalNumber:[self columnIndex:colName]];
}

- (NSDate*) columnValueDateTimeName:(NSString*)colName
{
    return [self columnValueDateTime:[self columnIndex:colName]];
}

- (NSDate*) columnValueDateName:(NSString*)colName
{
    return [self columnValueDate:[self columnIndex:colName]];
}

- (NSData*) columnValueDataName:(NSString*)colName
{
    return [self columnValueData:[self columnIndex:colName]];
}

- (UIImage*) columnValueImageName:(NSString*)colName
{
    return [self columnValueImage:[self columnIndex:colName]];
}


- (BOOL) reset
{
    @try
    {
        return sqlite3_reset(_statement) == SQLITE_OK;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

- (BOOL) close
{
    @try
    {
        BOOL res = sqlite3_finalize(_statement) == SQLITE_OK;
        _statement = nil;
        return res;
    }
    @catch (NSException *exception)
    {
        [_database handleException:exception];
        return FALSE;
    }
}

@end
