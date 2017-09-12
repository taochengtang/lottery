//
//  CommentTableViewCell.m
//  NewsComing
//
//  Created by 陶成堂 on 2017/9/4.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(instancetype)getWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
         NSString *cellId = @"CommentTableViewCell";
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
       cell = [[[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil] lastObject];
    }
    
    cell.headImg.layer.masksToBounds = YES;
    cell.headImg.layer.cornerRadius = 23;
    
    return cell;
}

@end
