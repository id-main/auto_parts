//
//  CellPozaRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 18/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"

@interface CellPozaRow:UITableViewCell {
    
    Utile *utilitarx;
}

@property(nonatomic, strong) IBOutlet UILabel *SubtitluRand;
@property(nonatomic, strong) IBOutlet UIImageView *pozaRow; //sterge (cos imagine)
@property(nonatomic, strong) IBOutlet UIButton *butonaddpoza; //sterge (cos imagine)
@property(nonatomic, strong) IBOutlet UIImageView *stergeRand; //sterge (cos imagine)

-(void)loadObjectCell;


@end