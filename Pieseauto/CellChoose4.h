//
//  CellChoose4.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"


@interface CellChoose4:UITableViewCell<UITextFieldDelegate,UITextViewDelegate> {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UITextField *texteditabil;
@property(nonatomic, strong) IBOutlet UITextView *maimulttext;
@property(nonatomic, strong) IBOutlet UILabel *titluROW;
@property(nonatomic, strong) IBOutlet UIImageView *sageatablue;
@property(nonatomic, strong) IBOutlet UIImageView *sageatagri;
@property(nonatomic, strong) IBOutlet UIImageView *sageatabluemare;
@property(nonatomic, strong) IBOutlet UILabel *continuaBTN;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicTEXTVIEWHEIGHT; // different cell height

@end