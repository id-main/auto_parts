//
//  CellContulMeuRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellContulMeuRow:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,strong) IBOutlet UILabel *TitluRandUNU; //black bold
@property (nonatomic,strong) IBOutlet UILabel *TitluRand;
@property (nonatomic,strong) IBOutlet UILabel *CONTINUTRand;
@property (nonatomic,strong) IBOutlet UILabel *labelModifica;
@property (nonatomic,strong) IBOutlet UIImageView *imgModifica;
@property (nonatomic,strong) IBOutlet UIImageView *pozaRow; //  sageata blue
@property (nonatomic,strong) IBOutlet UIImageView *badgeRow; //  badge
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheightCONTINUTRAND; //
@property (nonatomic,strong) IBOutlet CustomBadge *customBAADGE;

@end

