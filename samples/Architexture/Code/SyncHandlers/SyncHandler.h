//
//  SyncHandler.h
//  rankrunner
//
//  Created by Josep Maria Pinyol Fontseca on 07/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

//----IMPORTS-->
#import <Foundation/Foundation.h>
#import "BaseObject.h"
//<-------------

#define SYNC_HANDLER_TYPE_NONE              0


@class SyncHandler;
@class BaseObjectDelegate;

@protocol SyncHandlerDelegate <NSObject>

- (void) syncDone:(BOOL)success object:(BaseObject*)obj;

@end

@interface SyncHandler : NSObject <NSURLConnectionDataDelegate>
{
    NSMutableData *_responseData;
    NSURLConnection *conn;
    long count;
}

@property (nonatomic, strong) BaseObjectDelegate *delegate;
@property (nonatomic, readonly) BOOL cancelled;
@property (nonatomic) long offset;
@property (nonatomic) long limit;
@property (nonatomic) float progressIni;
@property (nonatomic) float progressMax;

- (id) init:(BaseObjectDelegate*)del;

- (int) getType;
- (NSString*) getMethod;

- (void) syncDone:(BOOL)success object:(BaseObject*)obj;
- (void) fillRequestParams:(NSMutableDictionary*)data;
- (void) setParamDate:(NSDate*)date forKey:(NSString*)key inParams:(NSMutableDictionary*)data;
- (void) setParamDateTime:(NSDate*)date forKey:(NSString*)key inParams:(NSMutableDictionary*)data;
- (void) setParamBOOL:(BOOL)val forKey:(NSString*)key inParams:(NSMutableDictionary*)data;
- (void) setParamString:(NSString*)str forKey:(NSString*)key inParams:(NSMutableDictionary*)data;
- (BOOL) start;
- (void) cancel;
- (NSURLConnection*) createConnection;
- (BOOL) processJSON:(id)data;
- (void) didReceiveData:(NSMutableData*)data;

- (NSDate*) dateTimeFromJSONString:(NSString*)str;
- (NSDate*) dateFromJSONString:(NSString*)str;
- (NSString*) stringFromJSON:(id)val;

@end
