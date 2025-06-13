//
//  CellCalificativAcordatsauPrimit.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface CellCalificativAcordatsauPrimit:UITableViewCell {
    
    Utile *utilitarx;
}
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *titluROW;
@property(nonatomic, strong) IBOutlet UIImageView *sageatagri;
@property(nonatomic, strong) IBOutlet UIImageView *pozacerere;
@property(nonatomic, strong) IBOutlet UIImageView *iconuser;
@property(nonatomic, strong) IBOutlet UIImageView *iconcalificativ;
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *titlucalificativ; //Calificativ negativ pozitiv etc
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *textcalificativ;

@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different cell height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ2; // different cell height 2
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictleftpoza; // different cell left
@property(nonatomic, strong) IBOutlet UIView *detaliucomentariu;

@end