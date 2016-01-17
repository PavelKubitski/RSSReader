//
//  RKNews.m
//  RSSReader
//
//  Created by Pavel Kubitski on 16.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import "RKNews.h"

@implementation RKNews

+ (RKObjectMapping *) responseMapping {
    
    
    
    RKObjectMapping *articleMapping = [RKObjectMapping mappingForClass:[RKNews class]];
    
    
    
    
    [articleMapping addAttributeMappingsFromDictionary:@{@"title.text" : @"title"}];
    
    
    
    return articleMapping;
}







@end
