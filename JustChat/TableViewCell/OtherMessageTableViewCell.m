//
//  OtherMessageTableViewCell.m
//  JustChat
//
//  Created by admin on 5/31/16.
//  Copyright © 2016 zhengxinxin. All rights reserved.
//

#import "OtherMessageTableViewCell.h"

@implementation OtherMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (CGFloat)setFrameOfCurrentCell:(NSString *)text{
    CGRect frame = [text boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width/2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
   
    return self.oMLabel.frame.origin.y+frame.size.height+25;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
