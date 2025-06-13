//
//  CellFormularComanda.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 25/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"


@interface CellFormularComanda:UITableViewCell<UITextViewDelegate> {
    
    Utile *utilitarx;
}



@property (nonatomic,strong) IBOutlet UIView *DATEOFERTA; //  SECTIUNE 0
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TITLUOFERTA; //  row 0
@property (nonatomic,strong) IBOutlet UILabel *PRETOFERTA; //  row 0

@property (nonatomic,strong) IBOutlet UIView *RANDNORMAL; //  SECTIUNE 1 2 3 4 si 6 [row 0]
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TitluRand;
@property (nonatomic,strong) IBOutlet UILabel *LIVRARELABEL;
@property (nonatomic,strong) IBOutlet UILabel *labelModifica;
@property (nonatomic,strong) IBOutlet UIImageView *imgModifica;

@property (nonatomic,strong) IBOutlet UIView *RANDADRESA; //  SECTIUNE 5
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TitluAdresa;
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *labelSalveaza;
@property (nonatomic,strong) IBOutlet UIButton *btnSalveaza;

@property (nonatomic,strong) IBOutlet UIView *OBSERVATIICOMANDA; //  SECTIUNE 6 [row 1]
@property (nonatomic,strong) IBOutlet UITextView *textObservatii;

@property (nonatomic,strong) IBOutlet UIView *UTLIMULRAND; //  SECTIUNE 7
@property (nonatomic,strong) IBOutlet UIButton *btntrimiteComanda;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heighttitlurand;  // e dinamic height la titlu oferta
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heightlabelAdresa;  // e dinamic height la adresa
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheightTEXTVIEW; // la text compus


@end

