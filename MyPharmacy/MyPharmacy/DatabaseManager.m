//
//  DatabaseManager.m
//  Aviata
//
//  Created by Yerken on 05.06.14.
//  Copyright (c) 2014 Aviata. All rights reserved.
//

#import "DatabaseManager.h"

@implementation DatabaseManager

#define DB_FILE_NAME @"myDrugsDB"

static DatabaseManager *_database;

+ (DatabaseManager*)database {
    if (_database == nil) {
        _database = [[DatabaseManager alloc] init];
    }
    return _database;
}

- (id)init {
   if ((self = [super init])) {
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dbPath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.sqlite", DB_FILE_NAME]];
        BOOL success = [fileMgr fileExistsAtPath:dbPath];
        if(!success)
        {
            dbPath = [[NSBundle mainBundle] pathForResource:DB_FILE_NAME ofType:@"sqlite"];
            success = [fileMgr fileExistsAtPath:dbPath];
            if(!success)
            {
                NSLog(@"Cannot locate database file '%@'.", dbPath);
            }
        }
        if(!(sqlite3_open([dbPath UTF8String], &_database) == SQLITE_OK))
        {
            NSLog(@"An error has occured.");
        }
   }

    return self;
}

-(void) close{
     sqlite3_close(_database);
}

-(NSArray *)findeCity:(NSString*)string{
    NSMutableArray *retval = [[NSMutableArray alloc] init];
//    NSString *query = [NSString stringWithFormat:@"SELECT * FROM cities WHERE city_ru LIKE '%@%%' ORDER BY id",string];
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM drugTable where drugsBarCode = '%@'",string];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)
        == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            char *title = (char *) sqlite3_column_text(statement, 1);
            char *uses = (char *) sqlite3_column_text(statement, 2);
            char *contraindications = (char *) sqlite3_column_text(statement, 3);
            char *sideEffects = (char *) sqlite3_column_text(statement, 4);
            char *howToUse = (char *) sqlite3_column_text(statement, 5);
            char *overDose = (char *) sqlite3_column_text(statement, 6);
            NSMutableDictionary * tablets = [[NSMutableDictionary alloc] init];
            [tablets setObject:[[NSString alloc] initWithUTF8String:title] forKey:@"title"];
            [tablets setObject:[[NSString alloc] initWithUTF8String:uses] forKey:@"uses"];
            [tablets setObject:[[NSString alloc] initWithUTF8String:contraindications] forKey:@"contraindications"];
            [tablets setObject:[[NSString alloc] initWithUTF8String:sideEffects] forKey:@"sideEffects"];
            [tablets setObject:[[NSString alloc] initWithUTF8String:howToUse] forKey:@"howToUse"];
            [tablets setObject:[[NSString alloc] initWithUTF8String:overDose] forKey:@"overDose"];
            [retval addObject:tablets];
//            NSLog(@"%@",[[retval objectAtIndex:0]valueForKey:@"title" ]);
        }
        sqlite3_finalize(statement);
    }
    return retval;
}
@end
