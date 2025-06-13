//
//  CellDetaliuOferta.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 04/05/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"

//@protocol HeightForTextView
//-(void)heightOfTextView:(UITextView *)textView Withwheight:(CGFloat)height;
//
//@end

@interface CellDetaliuOferta:UITableViewCell<UITextFieldDelegate,UITextViewDelegate> {
    
    Utile *utilitarx;
}

//sunt grupate pe views
//@property (nonatomic, weak) id <HeightForTextView> delegate;

@property (nonatomic,strong) IBOutlet UIImageView *favoritagri;//apare cand cererea e adaugata la favorite
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *TitluRand; //nume oferta
@property (nonatomic,strong) IBOutlet UILabel *tipoferta; //noua second
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *pretoferta; //pret buc. set
@property (nonatomic,strong) IBOutlet UIImageView *pozaRow; // daca vrem img
@property (nonatomic,strong) IBOutlet CustomBadge *badgeRow; //  
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamiccellLEFT; // different cell text align (cu sau fara poza)
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictableheightJ; // different cell height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toptitlurand; // daca e castigatoare sau nu  marginea top titlu oferta
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heighttitlurand; //titlu oferta height automat
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toppoza; // daca e castigatoare sau nu marginea top poza
@property (nonatomic,strong) IBOutlet UIImageView *cupaverde; // e vizibil doar cand exista o oferta castigatoare
@property (nonatomic,strong) IBOutlet UILabel *verdetop; // e vizibil doar cand exista o oferta castigatoare
@property(nonatomic, strong) IBOutlet UIButton *bifablue; //bifa check
@property(nonatomic, strong) IBOutlet UIImageView *salvatabifablue; //bifa check

@property(nonatomic, strong) IBOutlet UIButton *expandcollapsecell; //buton care extinde sau strange rows
@property(nonatomic, strong) IBOutlet UIButton *expandcollapsecellspecial; //buton care extinde sau strange rows
@property(nonatomic, strong) IBOutlet UILabel *textmesaj;
@property (nonatomic,strong) IBOutlet UIImageView *pozamesajdejatrimis; // e vizibil doar cand exista o oferta castigatoare



@property(nonatomic, strong) IBOutlet UIView *randul1; //contine date despre ofertant
@property (nonatomic,strong) IBOutlet UILabel *titlurandul1; //oferta facuta de
@property (nonatomic,strong) IBOutlet UILabel *numeofertant; //nume ofertant
@property (nonatomic,strong) IBOutlet UIImageView *stelutacalificative;//steluta user
@property (nonatomic,strong) IBOutlet UIImageView *icontelefon;//icon tel
@property (nonatomic,strong) IBOutlet UILabel *catecalificative;
@property (nonatomic,strong) IBOutlet UILabel *telefonuser; // suna la ofertant
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;//sageata blue


@property(nonatomic, strong) IBOutlet UIView *randul2; //garantie etc
@property (nonatomic,strong) IBOutlet UILabel *titlurandul2; // subitems la garantie etc
@property (nonatomic,strong) IBOutlet UILabel *titlurandulextra; //titlu garantie da nu

@property(nonatomic, strong) IBOutlet UIView *ultimulrand; //contine 2 butoane:
@property(nonatomic, strong) IBOutlet UIButton *salveazalapreferate; //salveaza la pref
@property(nonatomic, strong) IBOutlet UIButton *acceptaoferta; //accepta

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


@property(nonatomic, strong) IBOutlet UIView *bluecell; //icons
@property(nonatomic, strong) IBOutlet UILabel *Altrandalbastru; //cell cu icon in stanga
@property(nonatomic, strong) IBOutlet UIImageView *sageataBlue;
@property(nonatomic, strong) IBOutlet UIImageView *IconRand; //icons
@property (nonatomic,strong) IBOutlet UIImageView *sageataGri3;



@end

