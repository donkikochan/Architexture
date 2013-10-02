//
//  SyncHandler.m
//  rankrunner
//
//  Created by Josep Maria Pinyol Fontseca on 07/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

//----IMPORTS-->
#import "SyncHandler.h"
#import "EConsts.h"
#import "ECommon.h"
#import "JSONKit.h"
#import "BaseObject.h"
#import "BaseObjectDelegate.h"
//<-------------


@implementation SyncHandler

@synthesize delegate;
//@synthesize errorMessage;
//@synthesize errorDetails;
@synthesize cancelled = _cancelled;
@synthesize offset = _offset;
@synthesize limit = _limit;
@synthesize progressIni = _progressIni;
@synthesize progressMax = _progressMax;


- (id) init:(id<SyncHandlerDelegate>)del
{
    self = [super init];
    if (self)
    {
        //_db = db;
        self.delegate = del;
        //count = cnt;
        _offset = 0;
        _limit = SYNC_LIMIT_DEFAULT;
        //_progressIni = progressIni;
        //_progressMax = progressMax;
    }
    return self;
}
 

- (int) getType
{
    return SYNC_HANDLER_TYPE_NONE;
}

- (NSString*) getMethod
{
    return SERVER_METHOD_LOGIN;
}

- (void) syncDone:(BOOL)success object:(BaseObject*)obj
{
    if (delegate != nil)
    {
        [delegate syncDone:success object:obj];
    }
}

- (BOOL) start
{
    
    /*if (count <= 0)
    {
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(syncDone) userInfo:nil repeats:NO];
        return YES;
    }*/
    
    conn = [self createConnection];
    if (conn == nil)
    {
        return NO;
    }
    else
    {
        if (_responseData == nil)
            _responseData = [[NSMutableData alloc] init];
        else
            _responseData.length = 0;
        [ECommon showNetworkActivityIndicator];
        return YES;
    }
}

- (void) cancel
{
    _cancelled = YES;
    [conn cancel];
    //errorMessage = NSLocalizedString(@"Sincronización cancelada", @"");
    [self syncDone:NO object:nil];
}

- (NSURLConnection*) createConnection
{
    NSString *server = SERVER_ADDRESS;
    NSString *path = [NSString stringWithFormat:@"%@%@",SERVER_PATH_BASE,[self getMethod]];
    
#ifdef DEBUG_SYNC
    NSLog(@"URL: %@%@", server, path);
#endif
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    @try
    {
        [self fillRequestParams:data];
    }
    @catch (NSException *exception)
    {
       // self.errorDetails = exception.description;
       // self.errorMessage = @"";    //Se pondrá en la View
        [self syncDone:NO object:nil];
#ifdef DEBUG_SYNC
        NSLog(@"Exception: %@ - %@",exception.description, exception.reason);
        return nil;
#endif
    }
    
#ifdef DEBUG_SYNC
    NSLog(@"Body: %@", [data JSONString]);
#endif
    
    return [ECommon createURLConnectionJSONTo:server path:path delegate:self body:[data JSONData]];
}

- (void) fillRequestParams:(NSMutableDictionary*)data
{
}

- (void) setParamDate:(NSDate*)date forKey:(NSString*)key inParams:(NSMutableDictionary*)data
{
    if (date == nil)
    {
        [data setValue:@"" forKey:key];
#ifdef DEBUG_SYNC
        NSLog(@"%@: (null)", key);
#endif
    }
    else
    {
        NSString *str = [ECommon formatDate:date withFormat:JSON_DATE_FORMAT];
        [data setValue:str forKey:key];
        
#ifdef DEBUG_SYNC
        NSLog(@"%@: %@", key, str);
#endif
    }
}

- (void) setParamDateTime:(NSDate*)date forKey:(NSString*)key inParams:(NSMutableDictionary*)data
{
    if (date == nil)
    {
        [data setValue:@"" forKey:key];
#ifdef DEBUG_SYNC
        NSLog(@"%@: (null)", key);
#endif
    }
    else
    {
        NSString *str = [ECommon formatDate:date withFormat:JSON_DATE_TIME_FORMAT];
        [data setValue:str forKey:key];
        
#ifdef DEBUG_SYNC
        NSLog(@"%@: %@", key, str);
#endif
    }
}

- (void) setParamBOOL:(BOOL)val forKey:(NSString*)key inParams:(NSMutableDictionary*)data
{
#ifdef DEBUG_SYNC
    NSLog(@"%@: %d", key, (int)val);
#endif
    
    [data setValue:[NSNumber numberWithInt:val] forKey:key];
}

- (void) setParamString:(NSString*)str forKey:(NSString*)key inParams:(NSMutableDictionary*)data
{
    if (str == nil)
        [data setValue:@"" forKey:key];
    else
        [data setValue:str forKey:key];
}

- (BOOL) processJSON:(id)data;
{
    return YES;
}

- (NSDate*) dateTimeFromJSONString:(NSString*)str
{
    return [ECommon dateFromString:str withFormat:JSON_DATE_TIME_FORMAT];
}

- (NSDate*) dateFromJSONString:(NSString*)str
{
    return [ECommon dateFromString:str withFormat:JSON_DATE_FORMAT];
}

- (NSString*) stringFromJSON:(id)val
{
    if (val == nil || [val isKindOfClass:[NSNull class]])
        return @"";
    
    return (NSString*)val;
}

- (void) didReceiveData:(NSMutableData*)data
{
    @autoreleasepool
    {
#ifdef DEBUG_SYNC
        NSString *strData = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Data Received: %@", strData);
#endif
        
        NSDictionary *json = [data objectFromJSONData];
        if(json != nil)
        {
            NSNumber *success = [json objectForKey:JSON_SUCCESS];
            if ([success boolValue])
            {
                id data = [json objectForKey:JSON_DATA];
                
                int syncDone = -1;
                @try
                {
                    BOOL ok = [self processJSON:data];
                    if (ok && !self.cancelled)
                    {
                        _offset += _limit;
                        if (_offset >= count)
                            syncDone = 1;
                        else if (![self start])
                            syncDone = 0;
                    }
                    else
                    {
                        if (!_cancelled)
                        {
                            //self.errorMessage = NSLocalizedString(@"Error al guardar la información recibida", @"");
                            //self.errorDetails = @"";
                        }
                        syncDone = 0;
                    }
                }
                @catch (NSException *exception)
                {
                    //self.errorDetails = exception.description;
                    //self.errorMessage = NSLocalizedString(@"Error de sincronización", @"");
                    syncDone = 0;
#ifdef DEBUG_SYNC
                    NSLog(@"Exception: %@ - %@",exception.description, exception.reason);
#endif
                }
                
                //Se hace después para cerrar primero la conexión a la BD
                //if (syncDone >= 0)
                //    [self syncDone:syncDone==1 handler:self];
            }
            else
            {
                BaseObject *response = [[BaseObject alloc] init:NO message:[json objectForKey:JSON_MSG]];
                [self syncDone:NO object:response];
            }
        }
        else
        {
            //self.errorMessage = NSLocalizedString(@"Error de conexión", @"");
            [self syncDone:NO object:nil];
        }
    }
}

#pragma mark - NSURLConnectionDataDelegate

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (!_cancelled)
        [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [ECommon hideNetworkActivityIndicator];

    if (!_cancelled)
    {
        [self didReceiveData:_responseData];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [ECommon hideNetworkActivityIndicator];
#ifdef DEBUG_SYNC
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
#endif
    
    //errorMessage = NSLocalizedString(@"Error de conexión", @"");
    //errorDetails = error.localizedDescription;
    _responseData.length = 0;
    [self syncDone:NO object:nil];
}
 

@end
