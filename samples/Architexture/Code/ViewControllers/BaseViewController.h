//
//  BaseViewController.h
//  rankrunner
//
//  Created by Jordi Badia Santaulària on 10/05/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "BSKeyboardControls.h"
#import "PullRefreshTableViewController.h"



@interface BaseViewController : UIViewController

- (UIView*) mainView;
- (UIViewController*) mainViewController;

- (NSString*) getOfflinePathForFilename:(NSString*)filename;
- (BOOL) saveObjectOffileFor:(NSObject*)obj toFile:(NSString*)filename;
- (NSObject*) loadObjectOfflineFromFile:(NSString*)filename;

@end



@interface BaseTableViewController : PullRefreshTableViewController

@property (nonatomic) int offset;
@property (nonatomic) int prevItemsCount; //To know if there are more items
@property (nonatomic) BOOL moreItems;

- (void)scrollViewToTextField:(id)textField;
- (UIView*) mainView;
- (UIViewController*) mainViewController;
- (void) loadData;
- (void) resetOffset;

- (NSString*) getOfflinePathForFilename:(NSString*)filename;
- (BOOL) saveDataOffileFor:(NSArray*)arr toFile:(NSString*)filename;
- (NSMutableArray*) loadDataOfflineFromFile:(NSString*)filename;

@end

