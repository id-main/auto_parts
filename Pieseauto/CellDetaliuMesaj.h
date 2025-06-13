//
//  CellDetaliuMesaj.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/05/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

@interface CellDetaliuMesaj:UITableViewCell<UITextFieldDelegate,UITextViewDelegate> {
    
    Utile *utilitarx;
}

//sunt grupate pe views



@property (nonatomic,strong) IBOutlet CustomBadge *badgeRow; //  
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT; // different cell text align (cu sau fara poza)
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different cell height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toptitlurand; // daca e castigatoare sau nu  marginea top titlu oferta
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heighttitlurand; //titlu oferta height automat
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toppoza; // daca e castigatoare sau nu marginea top poza
@property(nonatomic, strong) IBOutlet UIButton *bifablue; //bifa check



@property(nonatomic, strong) IBOutlet UILabel *textmesaj;
@property (nonatomic,strong) IBOutlet UIImageView *pozamesajdejatrimis; // e vizibil doar cand exista o oferta castigatoare

@property(nonatomic, strong) IBOutlet UIView *continutmesaj; //contine
@property (nonatomic,strong) IBOutlet UILabel *fundalmesaj; //pe rows cu mesaje dintre useri
@property (nonatomic,strong) IBOutlet UIImageView *elpozaalbastra;//icon la mesaj primit de la useri
@property (nonatomic,strong) IBOutlet UIImageView *eupozagri;//icon la mesaj trimis de user
@property (nonatomic,strong) IBOutlet UIImageView *cercalbastru;//apare cand mesajul nu a fost citit inca

/////////// un view pt compune mesaj
@property(nonatomic, strong) IBOutlet UIView *COMPUNE; //garantie etc
@property(nonatomic, strong) IBOutlet UITextView *compunetextmesaj;
@property (weak, nonatomic) IBOutlet UIImageView *fapozaImageView;
@property(nonatomic, strong) IBOutlet UIButton *fapoza;
////////// un view pt trimite mesaj [se verifica text mesaj]
@property(nonatomic, strong) IBOutlet UIView *TRIMITE; //label trimite
@property(nonatomic, strong) IBOutlet UIButton *trimitetextmesaj;
@property(nonatomic, strong) IBOutlet UIImageView *sageatatrimite;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicTEXTVIEWHEIGHT;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicCOMPUNEROWHEIGHT;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicLINIEGRIHEIGHT;



@end

