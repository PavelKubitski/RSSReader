//
//  RKArticle.h
//  RSSReader
//
//  Created by Pavel Kubitski on 14.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface RKArticle : NSObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate   * pubDate;
@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * description_article;
@property (nonatomic, retain) NSString * imageURL;



+ (RKObjectMapping *) responseMapping;

@end
