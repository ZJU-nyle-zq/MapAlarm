//
//  CoreDataManager.m
//  MapAlarm
//
//  Created by Bran on 12/17/14.
//  Copyright (c) 2014 邓永辉. All rights reserved.
//
#import "CoreDataManager.h"

@implementation CoreDataManager
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//获取Document的路径
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - 增删改查

//插入数据
-(void)insertCoreData:(NSString*)event atDate:(NSDate*)date atTime:(NSString*)time isAlert:(BOOL)alert
{
    NSManagedObjectContext *context = [self managedObjectContext];
    Schedule *newevent = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
    newevent.event =event;
    newevent.date=date;
    newevent.time=time;
    newevent.alert=[NSNumber numberWithBool:alert];
    NSError *error;
        if(![context save:&error]) {
            NSLog(@"不能插入：%@",[error localizedDescription]);
        } else {
            NSLog(@"插入数据成功！");
        }
}
//选择数据,根据程序需要必须日期一致
/*-(NSMutableArray*)selectData:(NSString*)date
{
    //创建取回数据请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 设置要检索哪种类型的实体对象，设置请求实体（选择哪个表）
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // 限定查询结果的数量
    [fetchRequest setFetchLimit:50];
    
    // 查询的偏移量
    [fetchRequest setFetchOffset:0];
    
    // 排序(根据title排序)
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    [sortDescriptors addObject:[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // 查询条件（相当于sqlite中的查询条件，具体格式参考苹果文档）https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date=%@",date];
    [fetchRequest setPredicate:predicate];
    
    // 分页
    [fetchRequest setFetchBatchSize:50];
    
    //查询的字段，一般不需要
    // [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"title", @"newsid", nil]];
    
    // 这个是啥意思？
    // [fetchRequest setReturnsObjectsAsFaults:YES];
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // 执行获取数据请求，返回数组
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"HH:mm"];
    for (Schedule *info in fetchedObjects) {
        //NSString *dayInWeekFormattedString = [dateFormatter stringFromDate:info.time];
        NSLog(@"Event:%@，time:%@,alert:%@", info.event,info.time,info.alert);
        [resultArray addObject:info];
    }
    return resultArray;
}*/
-(NSMutableArray*)selectData
{
    //创建取回数据请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 设置要检索哪种类型的实体对象，设置请求实体（选择哪个表）
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // 限定查询结果的数量
    [fetchRequest setFetchLimit:50];
    
    // 查询的偏移量
    [fetchRequest setFetchOffset:0];
    
    // 排序(根据title排序)
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    [sortDescriptors addObject:[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // 查询条件（相当于sqlite中的查询条件，具体格式参考苹果文档）https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    
    // 分页
    [fetchRequest setFetchBatchSize:50];
    
    //查询的字段，一般不需要
    // [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"title", @"newsid", nil]];
    
    // 这个是啥意思？
    // [fetchRequest setReturnsObjectsAsFaults:YES];
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // 执行获取数据请求，返回数组
    //NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"HH:mm"];
    for (Schedule *info in fetchedObjects) {
        //NSString *dayInWeekFormattedString = [dateFormatter stringFromDate:info.time];
        NSLog(@"Event:%@，time:%@,alert:%@", info.event,info.time,info.alert);
        [resultArray addObject:info];
    }
    return resultArray;
}
-(void)deleteOneSchedule:(NSDate*)date atTime:(NSString*)time{
    //创建取回数据请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // 设置要检索哪种类型的实体对象，设置请求实体（选择哪个表）
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // 限定查询结果的数量
    [fetchRequest setFetchLimit:5];
    
    // 查询的偏移量
    [fetchRequest setFetchOffset:0];
    
    // 排序(根据title排序)
    NSMutableArray *sortDescriptors = [NSMutableArray array];
    [sortDescriptors addObject:[[NSSortDescriptor alloc] initWithKey:@"time" ascending:YES]];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // 查询条件（相当于sqlite中的查询条件，具体格式参考苹果文档）https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"time = %@ AND date=%@",time,(NSDate*)date];
    [fetchRequest setPredicate:predicate];
    
    // 分页
    [fetchRequest setFetchBatchSize:5];
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // 执行获取数据请求，返回数组
    for (Schedule *info in fetchedObjects) {
        NSLog(@"Event:%@，time:%@,alert:%@", info.event,info.time,info.alert);
        [resultArray addObject:info];
    }
    if ([fetchedObjects count]){
        for (NSManagedObject *obj in fetchedObjects) {
            [self.managedObjectContext deleteObject:obj];
        }
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } else {
            NSLog(@"delete success!");
        }
    }
}

//删除所有数据，可以看作清空数据库
- (void)deleteData
{
    // 注：NSManagedObject对象必须先取出来，用managedObjectContext删除，保存就好
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:[NSEntityDescription entityForName:TableName inManagedObjectContext:self.managedObjectContext]];
    
    NSError *error = nil;
    NSArray *datas = [self.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!error && datas && [datas count])
    {
        for (NSManagedObject *obj in datas) {
            [self.managedObjectContext deleteObject:obj];
        }
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        } else {
            NSLog(@"delete success!");
        }
    }
}
#pragma mark - Core Data stack

/**
 * Returns the managed object context for the application.
 * If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 **/
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

/**
 * Returns the managed object model for the application.
 * If the model doesn't already exist, it is created from the application's model.
 **/
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

/**
 * Returns the persistent store coordinator for the application.
 * If the coordinator doesn't already exist, it is created and the application's store added to it.
 **/
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    //得到数据库的路径
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:SQLFileName];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
