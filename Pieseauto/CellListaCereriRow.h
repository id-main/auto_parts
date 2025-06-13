//
//  CellListaCereriRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellListaCereriRow:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;//sageata gri jos
@property (nonatomic,strong) IBOutlet UIImageView *sageatagri; //sageata gri middle
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TitluRand;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *numaroferteRand;
@property (nonatomic,strong) IBOutlet UIImageView *pozaRow; // daca vrem img
@property (nonatomic,strong) IBOutlet CustomBadge *badgeRow; //  nr oferte nevazute
@property (nonatomic,strong) IBOutlet UILabel *labelanulate;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictitluheight; // are inaltime diferita rows sunt max 2 ->difera doar cand titlul e mai mare de  1 linie



@end

