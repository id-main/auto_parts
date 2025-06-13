//
//  AppDelegate.h
//  Pieseauto
//
//  Created by Ioan Ungureanu on 23/02/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "utile.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
     Utile * utilitare;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableDictionary *DICTIONARICONS;
@property (strong, nonatomic) NSArray *PRODUCATORIAUTO;
@property (strong, nonatomic) NSArray *MARCIAUTO;
@property (strong, nonatomic) NSArray *JUDETE;
@property (strong, nonatomic) NSArray *LOCALITATI;
@property (strong, nonatomic) NSMutableDictionary *cererepiesa; // contine ce a selectat la cerere
//ce date vin la init
@property (strong, nonatomic) NSString *IMG_max_height; //max image height -> le-am facut strings sunt stocate in NSUserDefaults ca si key
@property (strong, nonatomic) NSString *IMG_max_width; //max image width
@property (strong, nonatomic) NSString *CERERE_max_images; //nr maxim imagini pe cerere
@property (strong, nonatomic) NSArray *CURRENCIES; //usd eur
@property (strong, nonatomic) NSMutableArray *POZECERERE; //contine id de asseturi de poze -> le tinem in appdel ...se sterg cand se face cerere noua si nu sunt links de la server sau la init cerere noua
@property (strong, nonatomic) NSMutableArray *ARRAYASSETURI; //contine poze reale scalate din cerere
@property (strong, nonatomic) NSMutableArray *ARRAYASSETURIEXTERNE; //contine poze reale salvate la server pentru o cerere deja trimisa
@property (strong, nonatomic) NSDictionary *NOTIFY_COUNT; //contine nr calificative de acordat si  nr oferte necitite
@property (strong, nonatomic) NSDictionary *USER_LOGAT; //contine datele userului logat
@property (strong, nonatomic) NSMutableArray *ARRAYCERERI_ACTIVE; //contine lista cereri user
@property (strong, nonatomic) NSMutableArray *ARRAYCERERI_REZOLVATE;
@property (strong, nonatomic) NSMutableArray *ARRAYCERERI_ANULATE;
@property (nonatomic,assign) BOOL aafisatTutorial;
@property (nonatomic,assign) BOOL vinedincerere; //e cazul cand il ducem la login register din cerere
@property (nonatomic,assign) BOOL inapoilacereredinlogin; //e cazul in care l-am logat si facem trimite cerere automat
@property (nonatomic,assign) BOOL reposteazacerere; //e cazul in care vrea sa reposteze cerere
@property (nonatomic,assign) BOOL afostanulata; //e necesar cand se face anulare la o oferta...
@property (nonatomic,assign) BOOL refreshdupaanulata;
@property (nonatomic,assign) BOOL amscrismesajboss;

@property (strong, nonatomic) NSMutableDictionary *MODPLATATEMPORAR; //modul de plata selectat la formular comanda are init de fiecare data cand alege modifica
@property (strong, nonatomic) NSMutableDictionary *MODLIVRARETEMPORAR;
@property (nonatomic,assign) BOOL modificariDateComanda; //e cazul in care editeaza date cerere
@property (strong, nonatomic) NSMutableDictionary *CLONADATEUSER; // contine ce a selectat la cerere
@property (strong, nonatomic) NSString *COMMENT_max_images; ///nr maxim imagini pe comentariu
@property (strong, nonatomic) NSMutableDictionary *temporaraddress; //contine adresa temporara cat timp nu a apasat gata in editeaza adresa.

@property (strong, nonatomic) NSMutableArray *POZEMESAJ; //contine contine id de asseturi de poze
@property (strong, nonatomic) NSMutableArray *ARRAYASSETURIMESAJ; //contine poze reale scalate din mesaj
@property (strong, nonatomic) NSMutableArray *ARRAYASSETURIMESAJEXTERNE; //contine poze reale salvate la server pentru un mesaj deja trimis -> la select se deschide slide cu poze
@property (nonatomic, strong) NSString *TEXTMESAJTEMPORAR; //tine textul din caseta editabila cat timp se plimba prin poze etc
@property (nonatomic, strong) NSString *STRINGOBSERVATII;
@property (strong, nonatomic) NSString *URL_terms;
@property (strong, nonatomic) NSString *URL_tutorial;
@property (nonatomic, strong) NSString *vendorToken;


-(void)preia_notify_count;
@end

// 