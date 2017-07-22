//
//  FHMainQueueScheduler.m
//  FHSchedulerDemo
//
//  Created by 李浩 on 2017/7/23.
//  Copyright © 2017年 GodL. All rights reserved.
//

#import "FHMainQueueScheduler.h"

@implementation FHMainQueueScheduler

- (instancetype)initWithQueue:(dispatch_queue_t)queue {
    dispatch_queue_t new = dispatch_queue_create("org.FHScheduler.mainScheduler", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(new, dispatch_get_main_queue());
    return [super initWithQueue:new];
}

@end
