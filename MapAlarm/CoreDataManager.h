//
//  CoreDataManager.h
//  MapAlarm
//
//  Created by Bran on 12/17/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//


#define TableName @"Schedule"
#define SQLFileName @"Model.sqlite"

#import <Foundation/Foundation.h>
#import "Schedule.h"

@interface CoreDataManager : NSObject

//上下文对象(管理对象，上下文，持久性存储模型对象)
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型对象(被管理的数据模型，数据结构)
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久性存储区(连接数据库的)
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;


//插入数据
- (void)insertCoreData:(NSString*)event atDate:(NSString*)date atTime:(NSString*)time atLocation:(NSString*) location atLongitude:(float)longitude atLatitude:(float)latitude atTimestamp:(NSDate*)timestamp isAlert:(BOOL)alert;

//查询
-(NSMutableArray*)selectData;

-(NSMutableArray*)selectDataAtDate:(NSString*)date;
//删除某项
-(void)deleteOneSchedule:(NSString*)date atTime:(NSString*)time;
//删除全部
- (void)deleteData;
//更新
//- (void)updateData:(NSString*)newsId withIsLook:(NSString*)islook;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
