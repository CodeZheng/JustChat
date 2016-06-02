//
//  MessageTableViewCell.m
//  JustChat
//
//  Created by admin on 5/30/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageV.layer.cornerRadius = 30;
    self.headImageV.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
