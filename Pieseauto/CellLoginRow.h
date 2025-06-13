//
//  CellLoginRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface CellLoginRow:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UITextField *texteditabil;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
@property (nonatomic,strong) IBOutlet UILabel *TitluRand;
@property (nonatomic,strong) IBOutlet UILabel *TitluRandlogin; //e ultimul row 
@property (nonatomic,strong) IBOutlet UIImageView *pozaRow; //  sageata blue
@property (nonatomic,strong) IBOutlet UIButton *suntDeAcord; //  sageata blue


@end