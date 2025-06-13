//
//  EcranMesajeViewController.h
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
#import "CellDetaliuMesaj.h"
#import "MBAutoGrowingTextView.h"

@interface EcranMesajeViewController : UIViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UISearchBarDelegate,UINavigationControllerDelegate>{
    Utile * utilitar;
}
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet UIButton *faPozaButton;
@property (weak, nonatomic) IBOutlet UIImageView *faPozaImageView;
@property (weak, nonatomic) IBOutlet MBAutoGrowingTextView *compuneTextView;
@property (weak, nonatomic) IBOutlet UIView *compuneView;
@property (weak, nonatomic) IBOutlet UIView *trimiteView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) IBOutlet UITableView *LISTASELECT; //  tabel
@property (nonatomic,strong) NSArray *titluriCAMPURI; //  titluriCAMPURI
@property (nonatomic,strong) NSMutableArray *TOATE; //  contine randuri oferta + inca 5randuri cu titluri si expandable
@property (nonatomic,strong) NSMutableArray *RANDURIOFERTA; //RANDURI OFERTA
@property (nonatomic,strong) NSMutableArray *RANDOFERTANT; //CINE A FACUT OFERTA CU LINK LA EL
@property (nonatomic,strong) NSMutableArray *RANDURIEXPANDABILE; // 4 GARANTIE RETUR  EXPEDIERE MESAJE
@property (nonatomic,strong) NSMutableDictionary *CORPDATE; //  contine detaliu oferta + ARRAY OFERTE  -> vine din ecranul anterior lista oferte
@property (nonatomic,strong) NSMutableDictionary *DETALIUCERERE;
@property (nonatomic, retain) NSMutableArray *itemsInTable;
@property (nonatomic, retain) NSMutableArray *pieseselectate;
@property (nonatomic, strong) CAShapeLayer *ladreapta;
@property (nonatomic, strong) CAShapeLayer *lastanga;
@property (nonatomic, strong) NSString *lastmessageid; // e messageid al ofertei sau ultimul id de mesaj din comentarii care nu este al meu [daca exista]
@property (nonatomic,strong) NSMutableArray *stareexpand; // tine starea expand sau nu pt rows =0
@property (nonatomic, strong) NSString *TEXTMESAJTEMPORAR; //vezi si appdel
@property (nonatomic,strong) NSArray *pozetemporare; //  suntpoze de pe mesaje deja trimise
@property (nonatomic,strong) NSMutableArray *pozeprocesate; //  suntpoze de pe mesaje deja trimise
@property (nonatomic,strong) NSMutableDictionary *MESAJEFULL;
@property (nonatomic,strong) NSDictionary *PRIMULMESAJ; //este primul mesaj din lista am nevoie pentru a face reload cu aria ce-l contine
@property (nonatomic, strong) NSString *IDCERERE;
@property (nonatomic,strong) NSString *CE_TIP_E;
@property (nonatomic,strong) NSString *NUMEUSERDISCUTIE;
@property (nonatomic,strong) IBOutlet UIView *titluecran; //apare cand vine din notificari
@property (nonatomic,strong) IBOutlet UILabel *labeltitluecran;
@property (nonatomic,strong) IBOutlet UIButton *backbuton; //buton de back custom
@property (nonatomic,strong) NSMutableArray *pozele;

@property (nonatomic,strong) IBOutlet UIView *baradesus;
@property (nonatomic,strong) IBOutlet UILabel *titludesus;
@property (nonatomic,strong) IBOutlet UILabel *butondebackdesus;



@end
@interface ClockFace1: CAShapeLayer
//private properties
@property (nonatomic, strong) CAShapeLayer *ceva;
@end
@interface IMAGINESERVER1: UIImageView
//private properties
@property (nonatomic, strong) UIImageView *IMAGINEX;
@end

@interface SpecialText1: UILabel
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