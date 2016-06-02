//
//  OtherMessageTableViewCell.h
//  JustChat
//
//  Created by admin on 5/31/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OtherMessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *oMLabel;
@property (strong, nonatomic) IBOutlet UIImageView *oHeadImageV;
@property (strong, nonatomic) IBOutlet UILabel *oTimeLabel;
- (CGFloat)setFrameOfCurrentCell:(NSString *)text;
@end
