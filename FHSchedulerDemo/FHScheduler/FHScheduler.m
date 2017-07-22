//
//  FHScheduler.m
//  FHSchedulerDemo
//
//  Created by 李浩 on 2017/7/23.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "FHScheduler.h"
#import "FHMainQueueScheduler.h"
#import "FHSerialQueueScheduler.h"
#import "FHConcurrentQueueScheduler.h"

@implementation FHScheduler

FOUNDATION_STATIC_INLINE FHScheduler *FHSerialQosScheduler(NSQualityOfService qos) {
    static NSMutableDictionary<NSNumber *,FHScheduler *> *schedulerPool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        schedulerPool = [NSMutableDictionary dictionary];
    });
    FHScheduler *scheduler = [schedulerPool objectForKey:@(qos)];
    if (!scheduler) {
        @synchronized (schedulerPool) {
            scheduler = [[FHSerialQueueScheduler alloc] initWithQos:qos];
            [schedulerPool setObject:scheduler forKey:@(qos)];
        }
    }
    return scheduler;
}

FOUNDATION_STATIC_INLINE FHScheduler *FHConcurrentQosScheduler(NSQualityOfService qos) {
    static NSMutableDictionary<NSNumber *,FHScheduler *> *schedulerPool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        schedulerPool = [NSMutableDictionary dictionary];
    });
    FHScheduler *scheduler = [schedulerPool objectForKey:@(qos)];
    if (!scheduler) {
        @synchronized (schedulerPool) {
            scheduler = [[FHConcurrentQueueScheduler alloc] initWithQos:qos];
            [schedulerPool setObject:scheduler forKey:@(qos)];
        }
    }
    return scheduler;
}

+ (instancetype)mainThreadScheduler {
    static FHMainQueueScheduler *main = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        main = [[FHMainQueueScheduler alloc] initWithQueue:nil];
    });
    return main;
}

+ (instancetype)serialScheduler {
    return [self serialSchedulerWithQos:NSQualityOfServiceDefault];
}

+ (instancetype)serialSchedulerWithQos:(NSQualityOfService)qos {
    return FHSerialQosScheduler(qos);
}

+ (instancetype)concurrentScheduler {
    return [self concurrentSchedulerWithQos:NSQualityOfServiceDefault];
}

+ (instancetype)concurrentSchedulerWithQos:(NSQualityOfService)qos {
    return FHConcurrentQosScheduler(qos);
}

- (void)schedule:(dispatch_block_t)block {
    [self afterDelay:0 schedule:block];
}

- (void)afterDelay:(NSTimeInterval)delay schedule:(dispatch_block_t)block {
    NSAssert(NO, @"must overwrite with subclass");
}

@end
