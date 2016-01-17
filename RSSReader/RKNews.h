//
//  RKNews.h
//  RSSReader
//
//  Created by Pavel Kubitski on 16.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface RKNews : NSObject

@property (nonatomic, retain) NSString * title;



+ (RKObjectMapping *) responseMapping;

@end
