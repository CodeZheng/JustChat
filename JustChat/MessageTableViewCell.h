//
//  MessageTableViewCell.h
//  JustChat
//
//  Created by admin on 5/30/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImageV;
@property (strong, nonatomic) IBOutlet UILabel *friendNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *lastMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeMessageLabel;

@end
