//
//  AppDelegate.h
//  redbull
//
//  Created by Xin Qin on 11/26/14.
//  Copyright (c) 2014 Xin Qin. All rights reserved.
//


@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) DDMenuController *menuController;
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

