//
//  DatabaseManager.h
//  Aviata
//
//  Created by Yerken on 05.06.14.
//  Copyright (c) 2014 Aviata. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DatabaseManager : NSObject{
    sqlite3 * _database;
}

+ (DatabaseManager*)database;
-(NSArray *)findeCity:(NSString*)string;
-(void) close;
@end
