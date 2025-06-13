//
//  DetaliuOfertaViewController.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 13/04/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataMasterProcessor.h"
#import <UIKit/UIKit.h>
#import "utile.h"
#import "TTTAttributedLabel.h"
#import "CustomBadge.h"
#import "CellDetaliuOferta.h"

@interface DetaliuOfertaViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate>{
    Utile * utilitar;
    CGRect previousRect;
}
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSMutableArray *TOATE; //  contine randuri oferta + inca 5randuri cu titluri si expandable
@property (nonatomic,strong) NSMutableArray *RANDURIOFERTA; //RANDURI OFERTA
@property (nonatomic,strong) NSMutableArray *RANDOFERTANT; //CINE A FACUT OFERTA CU LINK LA EL
@property (nonatomic,strong) NSMutableArray *RANDURIEXPANDABILE; // 4 GARANTIE RETUR  EXPEDIERE MESAJE
@property (nonatomic,strong) NSString *idoferta;
@property (nonatomic,strong) NSMutableDictionary *CORPDATE; //  contine detaliu oferta + ARRAY OFERTE  -> vine din ecranul anterior lista oferte
@property (nonatomic,strong) NSMutableDictionary *DETALIUOFERTA;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@property (nonatomic, retain) NSMutableArray *pieseselectate;
@property (nonatomic, strong) CAShapeLayer *ladreapta;
@property (nonatomic, strong) CAShapeLayer *lastanga;
@property (nonatomic, strong) NSString *lastmessageid; // e messageid al ofertei sau ultimul id de mesaj din comentarii care nu este al meu [daca exista]
@property (nonatomic,strong) NSMutableArray *stareexpand; // tine starea expand sau nu pt rows =0
@property (nonatomic, strong) NSString *TEXTMESAJTEMPORAR; //vezi si appdel
@property (nonatomic,strong) NSArray *pozetemporare; //  suntpoze de pe mesaje deja trimise
@property (nonatomic,strong) NSMutableArray *pozeprocesate; //  suntpoze de pe mesaje deja trimise
-(void)offerPrefered  :(NSString *)AUTHTOKEN :(NSMutableDictionary *)OFFERTA_ID :(id)sender;
@property (nonatomic,strong) NSMutableArray *pozele;
@property (nonatomic,strong) NSString *idmesaj; // e stringul care vine din notificari // mesajul la care trebuie sa facem scroll automat si expand la cell mesaje
@property (nonatomic,assign) BOOL arewinner;
@property (nonatomic,assign) BOOL cerereexpirata;
@property (nonatomic,assign) BOOL afostanulata;
@property (nonatomic,assign) BOOL dinpush;
@end
@interface ClockFace: CAShapeLayer
//private properties
@property (nonatomic, strong) CAShapeLayer *ceva;
@end
@interface IMAGINESERVER: UIImageView
//private properties
@property (nonatomic, strong) UIImageView *IMAGINEX;
@end

@interface SpecialText: UILabel
//private properties
@property (nonatomic, strong) UILabel *cevaalttext;
@end
/**

 : UIView {
	NSString *badgeText;
	CGFloat badgeCornerRoundness;
	CGFloat badgeScaleFactor;
 BadgeStyle *badgeStyle;
 }
 

*/