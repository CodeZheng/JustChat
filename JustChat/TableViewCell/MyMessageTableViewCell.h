//
//  MyMessageTableViewCell.h
//  JustChat
//
//  Created by admin on 5/31/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyMessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *mHeadImageV;
@property (strong, nonatomic) IBOutlet UILabel *mMLabel;
@property (strong, nonatomic) IBOutlet UILabel *mTimeLabel;

@end
