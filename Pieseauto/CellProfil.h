//
//  CellProfil.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 31/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellProfil:UITableViewCell<UITextFieldDelegate> {
    
    Utile *utilitarx;
}
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *HeaderTabel;
@property (nonatomic,strong) IBOutlet UILabel *NUMEPROFIL; //name
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellnumeprofil;
@property (nonatomic,strong) IBOutlet UILabel *score; //score
@property (nonatomic,strong) IBOutlet UIImageView *stars_class; // ":"stars_green",
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row1;
@property (nonatomic,strong) IBOutlet UIImageView *sellericon; //icon platinum etc
@property (nonatomic,strong) IBOutlet UILabel *sellerlabel; //vanzator platinum
@property (nonatomic,strong) IBOutlet UILabel *score_percent; //
@property (nonatomic,strong) IBOutlet UIImageView *verdepozitiv; //fundal verde procent scor
@property (nonatomic,strong) IBOutlet UIImageView *iconpozitivnegativ;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT; // cand e seller 0 si nu  are label vanzator
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT2; // cand e seller 0 si nu  are label vanzator
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row2;
@property (nonatomic,strong) IBOutlet UIImageView *telefonicon; //icon platinum etc
@property (nonatomic,strong) IBOutlet UILabel *telefon; //vanzator platinum
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row3;
@property (nonatomic,strong) IBOutlet UIImageView *siglafirma; //icon platinum etc
@property (nonatomic,strong) IBOutlet UILabel *numefirma;
@property (nonatomic,strong) IBOutlet UILabel *reprezinta;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row4;
@property (nonatomic,strong) IBOutlet UILabel *membrudindata; //
@property (nonatomic,strong) IBOutlet UILabel *ultimadataonline;
@property (nonatomic,strong) IBOutlet UILabel *localizarea;
@property (nonatomic,strong) IBOutlet UILabel *nranunturipublicate;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue2;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row5;
@property (nonatomic,strong) IBOutlet UILabel *calificative;
@property (nonatomic,strong) IBOutlet UILabel *calificativedetaliate;
@property (nonatomic,strong) IBOutlet UILabel *ultimulan;
@property (nonatomic,strong) IBOutlet UILabel *intotal;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row6;
@property (nonatomic,strong) IBOutlet UIImageView *iconpozitive;
@property (nonatomic,strong) IBOutlet UILabel *descrierepozitive;
@property (nonatomic,strong) IBOutlet UILabel *nrpean;
@property (nonatomic,strong) IBOutlet UILabel *total;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row7;
@property (nonatomic,strong) IBOutlet UILabel *descriereRandCal;
@property (nonatomic,strong) IBOutlet UILabel *nrrating;
@property (nonatomic,strong) IBOutlet UIImageView *stelutarosie;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row8;
@property (nonatomic,strong) IBOutlet UISegmentedControl *SEGCNTRL;
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row12;
@property (nonatomic,strong) IBOutlet UIImageView *iconcalificativprimit;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *comentariu;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *dela;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *numecomentator;
@property (nonatomic,strong) IBOutlet UIImageView *stelutaverde;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *scorcomentator;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellcomentariuheight; // comentariul are h dinamic
///////////////////////////////////////////////////////////
@property (nonatomic,strong) IBOutlet UIView *Row13;
@property (nonatomic,strong) IBOutlet UIImageView *iconmaimult;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *vezimaimult;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT3; // cand nu are poza la reprezinta magazin
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT4; // idem
@property (nonatomic,strong) IBOutlet UILabel *nusuntcalificative;

@end

