//
//  QMShareViewProtocol.h
//  QMShareExtension
//
//  Created by Injoit on 10/9/17.
//  Copyright © 2017 QuickBlox. All rights reserved.
//

@protocol QMShareViewProtocol

@property (assign, nonatomic) BOOL checked;

- (void)setChecked:(BOOL)checked
          animated:(BOOL)animated;

+ (void)registerForReuseInView:(UIView *)viewForReuse;

+ (NSString *)cellIdentifier;

- (void)setTitle:(NSString *)title
       avatarUrl:(NSString *)avatarUrl;

@end

