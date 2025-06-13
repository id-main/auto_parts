//
//  CellMasinileMeleRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 28/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface CellMasinileMeleRow:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property (nonatomic,strong) IBOutlet UILabel *TitluRand;
@property (nonatomic,strong) IBOutlet UIImageView *sageatagri;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different cell height




@end