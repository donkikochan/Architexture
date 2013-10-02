//
//  EConsts.h
//
//  Created by Jordi Badia Santaulària on 09/03/12.
//  Copyright (c) 2012 Endepro Software. All rights reserved.
//

#ifndef EConsts_h
#define EConsts_h

#ifndef NDEBUG
    //#define DEBUG_EDATABASE
    //#define DEBUG_ECOMMON
    #define DEBUG_SYNC
#endif

//Database
#define DATABASE_SCRIPT                 1
#define DB_CONTROL_TABLE_NAME           @"tbl_db_script"
#define DB_NAME                         @"db.db"
#define DB_CONTROL_TABLE_CREATE         @"CREATE TABLE IF NOT EXISTS tbl_db_script(script int primary key)"
#define DB_CONTROL_TABLE_CURR_SCRIPT    @"SELECT MAX(script) FROM tbl_db_script"
#define DB_CONTROL_TABLE_INSERT         @"INSERT INTO tbl_db_script(script) VALUES(%d)"
#define DB_SCRIPTS_NAME_FORMAT          @"%d.sql"

//Progress
#define PROGRESS_DONE_HIDE_DELAY        1
#define PROGRESS_BACKGROUND             YES
#define PROGRESS_MIN_SIZE               CGSizeMake(100.f, 100.f)

//Cascade
#define CASCADE_SPLIT_LEFT_INSERT       58.0f
#define CASCADE_SPLIT_WIDER_LEFT_INSERT 210.0f

//URL Connection
#define CONNECTION_TIMEOUT              60.0

//BSKeyboardControls
#define KEYBOARD_TOOLBAR_PREVIOUS       NSLocalizedString(@"PREVIOUS",@"")
#define KEYBOARD_TOOLBAR_NEXT           NSLocalizedString(@"NEXT",@"")
#define KEYBOARD_TOOLBAR_DONE           NSLocalizedString(@"DONE",@"")
#define KEYBOARD_TOOLBAR_BUTTON_TINT    [UIColor blackColor]
#define KEYBOARD_TOOLBAR_DONE_TINT      [UIColor colorWithR:34.0 G:164.0 B:255.0 A:1.0]
#define KEYBOARD_TOOLBAR_STYLE          UIBarStyleBlack

//AlertInfo
#define ALERT_OK_TEXT                   NSLocalizedString(@"ACCEPT", @"")

//HMSPickerView
#define HMS_PICKERVIEW_STR_FORMAT       @"%02d:%02d:%02d"
#define HMS_PICKERVIEW_HRS_ROW0         NSLocalizedString(@"00 hours",@"")
#define HMS_PICKERVIEW_HRS_ROW          @"%02d"
#define HMS_PICKERVIEW_MIN_ROW0         NSLocalizedString(@"00 mins",@"")
#define HMS_PICKERVIEW_MIN_ROW          @"%02d"
#define HMS_PICKERVIEW_SEC_ROW0         NSLocalizedString(@"00 secs",@"")
#define HMS_PICKERVIEW_SEC_ROW          @"%02d"

//PullRefreshTableViewController
#define PULL_TO_REFRESH_WHITE           NO
#define PULL_TO_REFRESH_HEADER_HEIGHT   52.0f
#define PULL_TO_REFRESH_PULL_DOWN       NSLocalizedString(@"Pull down to refresh...",@"")
#define PULL_TO_REFRESH_RELEASE         NSLocalizedString(@"Release to refresh...",@"")
#define PULL_TO_REFRESH_LOADING         NSLocalizedString(@"Loading...",@"")
#define PULL_TO_REFRESH_LAST_UPDATED    NSLocalizedString(@"Last updated: %@",@"")

//PullToRefreshView
#define PULL_TO_REFRESH_BG_COLOR        [UIColor colorWithR:226 G:231 B:237 A:1.0]
#define PULL_TO_REFRESH_TEXT_COLOR      [UIColor colorWithRed:(87.0/255.0) green:(108.0/255.0) blue:(137.0/255.0) alpha:1.0]

//Common
#define DATE_DEFAULT_LOCALE             @"es_ES"

//Si s'activa el "Automatic Reference Counting" en el projecte posar un 1
#define OBJC_ARC_ENABLED                1


/*
 * CUSTOM PROJECT CONSTS
 */

#define APP_WEBSITE                     @"www.YOKESE.com"
#define SOCIALS_MSG_DELAY_OFFSET        0.4 //MBProgressHUD takes 0.3 to hide
#define SYNC_LIMIT_DEFAULT              25

//User Defaults
#define USER_DEFAULT_USER_ID                @"user-id"
#define USER_UNITS_KM                       @"user-units-km"
#define USER_DEFAULT_SERVER_HOST            @"server-host"
#define USER_DEFAULT_USER_TOKEN             @"user-token"
#define USER_DEFAULT_REGISTER_TYPE          @"register-type"  //0->FACEBOOK, 1->TWITTER
#define USER_DEFAULT_FACEBOOK_CONNECTED     @"facebook-connected"
#define USER_DEFAULT_DEVICE_TOKEN           @"device-token"
#define USER_DEFAULT_MESSAGE_ID_TO_SHOW     @"message-id-to-show"
#define USER_DEFAULT_MESSAGE_TYPE_TO_SHOW   @"message-type-to-show"

//Server
#define SERVER_ADDRESS                      @"http://demos.endepro.com"
#define SERVER_PATH_BASE                    @"/weride"
#define SERVER_METHOD_LOGIN                 @"/login"
#define SERVER_METHOD_GET_PROVINCES         @"/get_countries"

#define JSON_USERID                         @"UserID"
#define JSON_DATE_FORMAT                    @"yyyy-MM-dd"
#define JSON_DATE_TIME_FORMAT               @"yyyy-MM-dd HH:mm:ss"
#define JSON_SUCCESS                        @"success"
#define JSON_MSG                            @"msg"
#define JSON_DATA                           @"data"
#define JSON_PROVINCE_ID                    @"ID"
#define JSON_PROVINCE                       @"Name"

#endif
