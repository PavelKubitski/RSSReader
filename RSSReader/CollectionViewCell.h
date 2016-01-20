//
//  CollectionViewCell.h
//  RSSReader
//
//  Created by Pavel Kubitski on 18.01.16.
//  Copyright (c) 2016 Pavel Kubitski. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;


- (void) show;

@end
