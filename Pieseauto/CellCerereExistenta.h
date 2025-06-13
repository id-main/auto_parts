//
//  CellCerereExistenta.h
//  Piese auto
//
//  Created by Ioan Ungureanu on 26/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"
@interface CellCerereExistenta:UITableViewCell {
    
    Utile *utilitarx;
}
@property(nonatomic, strong) IBOutlet UIView *primulcell; //titlu date masina tip zona poza
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *TitluRand; //tilu cerere si  rows
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *DateMasina;
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *Tipnoisausecond;
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *ZonaLivrare;
//azi
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheightTITLUCERERE; //
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicheightDATEMASINA; //


@property (weak, nonatomic) IBOutlet CustomBadge *badgenecitite;

@property(nonatomic, strong) IBOutlet UIImageView *PozaCerere;

@property(nonatomic, strong) IBOutlet UIView *bluecell; //icons
@property(nonatomic, strong) IBOutlet UILabel *Altrandalbastru; //cell cu icon in stanga
@property(nonatomic, strong) IBOutlet UIImageView *sageataBlue;
@property(nonatomic, strong) IBOutlet UIImageView *IconRand; //icons

@property(nonatomic, strong) IBOutlet UIView *ofertacastigatoare; //icons
@property(nonatomic, strong) IBOutlet UIView *topdetofer;
@property(nonatomic, strong) IBOutlet UIImageView *PozaOferta;
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *LEFTPOZAOFERTA; //
@property(nonatomic, strong) IBOutlet UIImageView *sageataGri;
@property(nonatomic, strong) IBOutlet UIView *detofer;
@property(nonatomic, strong) IBOutlet UILabel *RandGri; //cell background gri
@property(nonatomic, strong) IBOutlet UILabel *HeadOferta; //textul oferta castigatoare
@property(nonatomic, strong) IBOutlet UILabel *numartoate; //contine text toate si in paranteza nr-> cate oferte sunt la cerere
@property(nonatomic, strong) IBOutlet TTTAttributedLabel *TitluOferta; //
@property(nonatomic, strong) IBOutlet UILabel *TipOferta; //now second
@property(nonatomic, strong) IBOutlet UILabel *PretOferta; //now second
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heightHeadOferta; //view header oferta height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *heighttitlurand; //titlu oferta height
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *toppoza;
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue2;//sageata blue a nu se confunda cu sageataBlue etc
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamictitluheight; //pt oferta are inaltime diferita rows sunt max 2 ->difera doar cand titlul e mai mare de  1 linie
@property (nonatomic,weak) IBOutlet  NSLayoutConstraint *dynamicDETOFERHEIGHT;
@property(nonatomic, strong) IBOutlet UIView *discutieuser; //icons
@property(nonatomic, strong) IBOutlet UILabel *TitluMesaj; //
@property(nonatomic, strong) IBOutlet UILabel *NumePersoanaMesaj; // de la cine e mesajul
@property(nonatomic, strong) IBOutlet UIImageView *roundalbastru; //icon blue
@property(nonatomic, strong) IBOutlet UIImageView *pozauser; //icon user
@property(nonatomic, strong) IBOutlet UIImageView *sageataGri2; //
@property(nonatomic, strong) IBOutlet UIButton *expandcollapsecell; //buton care extinde sau strange rows

@property(nonatomic, strong) IBOutlet UIView *randgrenaanulata; //icons
@property(nonatomic, strong) IBOutlet UILabel *numerandanulata; //cell cu icon in stanga

@property(nonatomic, strong) IBOutlet UIImageView *sageataGri3; //


@property(nonatomic, strong) IBOutlet UIView *randul1; //contine date despre ofertant
@property (nonatomic,strong) IBOutlet TTTAttributedLabel *titlurandul1; //oferta facuta de
@property (nonatomic,strong) IBOutlet UILabel *numeofertant; //nume ofertant
@property (nonatomic,strong) IBOutlet UIImageView *stelutacalificative;//steluta user
@property (nonatomic,strong) IBOutlet UIImageView *icontelefon;//icon tel
@property (nonatomic,strong) IBOutlet UILabel *catecalificative;
@property (nonatomic,strong) IBOutlet UILabel *telefonuser; // suna la ofertant
@property (nonatomic,strong) IBOutlet UIImageView *sageatablue;//sageata blue a nu se confunda cu sageataBlue




@end