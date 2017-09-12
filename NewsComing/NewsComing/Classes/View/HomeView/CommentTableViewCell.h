//
//  CommentTableViewCell.h
//  NewsComing
//
//  Created by 陶成堂 on 2017/9/4.
//  Copyright © 2017年 renbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UIImageView *headImg;
@property (nonatomic,strong)IBOutlet UILabel *connetLab;
@property (nonatomic,strong)IBOutlet UILabel *nameLab;
@property (nonatomic,strong)IBOutlet UILabel *timeLab;

+(instancetype)getWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end
