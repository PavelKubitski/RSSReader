//
//  RKArticleList.h
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
//#import "RKXMLReaderSerialization.h"


@interface RKArticleList : NSObject

@property (nonatomic, retain) NSString * article_description;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSArray  * articles;

+ (RKObjectMapping *) responseMapping;

@end
