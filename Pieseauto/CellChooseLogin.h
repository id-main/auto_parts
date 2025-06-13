//
//  CellChooseLogin.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"

@interface CellChooseLogin:UITableViewCell {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UILabel *TitluRand;
@property(nonatomic, strong) IBOutlet UILabel *TitluRandaidejacont;
@property(nonatomic, strong) IBOutlet UIImageView *pozaRow; //poza icon rand
@property(nonatomic, strong) IBOutlet UIImageView *pozaSageataRow; //poza sageata rand

-(void)loadObjectCell;


@end