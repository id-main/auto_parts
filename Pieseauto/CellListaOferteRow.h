//
//  CellListaOferteRow.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 06/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellListaOferteRow:UITableViewCell<UITextFieldDelegate,UITextViewDelegate> {
    
    Utile *utilitarx;
}
//  badgeRow,cercalbastru,cupaverde,dynamiccellLEFT,favoritagri,pozaRow,pretoferta,sageatablue,sageatagri,tipoferta,TitluRand,toppoza,toptitlurand,verdetop
@property (nonatomic,strong) IBOutlet CustomBadge *badgeRow; //
@property (nonatomic,strong) IBOutlet UIImageView *cercalbastru;//apare cand cererea nu a fost vizualizata inca
@property (nonatomic,strong) IBOutlet UIImageView *cupaverde; // e vizibil doar cand exista o oferta castigatoare
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT; // different cell text align (cu sau fara poza)

@property (nonatomic,strong) IBOutlet UIImageView *favoritagri;//apare cand cererea e adaugata la favorite
@property (nonatomic,strong) IBOutlet UIImageView *pozaRow; // daca vrem img
@property (nonatomic,strong) IBOutlet UILabel *pretoferta; //pret buc. set
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;//sageata blue
@property (nonatomic,strong) IBOutlet UIImageView *sageatagri;//sageata gri
@property (nonatomic,strong) IBOutlet UILabel *tipoferta; //noua second
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TitluRand; //nume oferta
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toptitlurand; // daca e castigatoare sau nu  marginea top titlu oferta
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toppoza; // daca e castigatoare sau nu marginea top poza
@property (nonatomic,strong) IBOutlet UILabel *verdetop; // e vizibil doar cand exista o oferta castigatoare

@end

