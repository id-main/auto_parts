//
//  DataMasterProcessor.h
//  PieseAuto
//
//  Created by Ioan Ungureanu far away in future
//  Copyright (c) 2016 Active Soft SRL. All rights reserved.
//
//
/********************* db define ************************
 
 CREATE TABLE "judete" ("id"  INTEGER  NOT NULL  UNIQUE , "name" VARCHAR) ;
 CREATE TABLE "currencies" ("id"  INTEGER NOT NULL  UNIQUE,"name" VARCHAR);
 CREATE TABLE "localitati" ("id" INTEGER NOT NULL  UNIQUE,"county_id" INTEGER,"name" VARCHAR);
 CREATE TABLE "marci" ("id" INTEGER NOT NULL  UNIQUE,"carmaker_id" INTEGER,"name" VARCHAR,"year_end" VARCHAR,"year_start" VARCHAR);
 CREATE TABLE "producatori" ("id" INTEGER NOT NULL  UNIQUE,"name" VARCHAR);
 
 CREATE TABLE "users_cars" ("id"  INTEGER,
 "C_producator_id" VARCHAR,
 "C_model_id" VARCHAR,
 "C_talon_an_fabricatie" VARCHAR,
 "C_talon_tip_varianta" VARCHAR,
 "C_motorizare" VARCHAR,
 "C_talon_nr_identificare" VARCHAR,
 "C_userid" VARCHAR
 )
 CREATE TABLE "users" ("U_authtoken" VARCHAR NOT NULL  UNIQUE,
 "U_lastupdate" VARCHAR,
 "U_username" VARCHAR,
 "U_logat" VARCHAR,
 "U_preferinte_notificari" VARCHAR,
 "U_prenume" VARCHAR,
 "U_nume" VARCHAR,
 "U_email" VARCHAR,
 "U_telefon" VARCHAR,
 "U_judet"  VARCHAR,
 "U_localitate"  VARCHAR,
 "U_cod_postal" VARCHAR,
 "U_adresa" VARCHAR,
 "U_parola" VARCHAR,
 "U_userid" VARCHAR
 )

 ********************* db define ************************/
#import <Foundation/Foundation.h>
@interface DataMasterProcessor : NSObject{
   }
//totate apelurile locale pentru date
//INSERT JUDETE
+(BOOL)insertJudete:(NSArray*)JUDETE :(NSString*)metoda;  //1.
+(BOOL)insertProducatori:(NSArray*)PRODUCATORI :(NSString*)metoda; //2
+(BOOL)insertCarModels:(NSArray*)MARCIAUTO :(NSString*)metoda; //3
+(BOOL)insertLocalitati:(NSArray*)LOCALITATI :(NSString*)metoda; //4
+(BOOL)insertCurrencies:(NSArray*)CURRENCIES :(NSString*)metoda; //5
/////////+(BOOL)insertUsers; //6 toti userii care s-au logat inregistrat
+(BOOL)insertUsers:(NSDictionary*)DATEUSER; //7 toti userii care s-au logat inregistrat
+(BOOL)insertUsers_cars:DICTIONAR_CERERE_ADD :(NSString*)userid; //8 masina salvata la cerere
+(BOOL)updateUsers:(NSDictionary*)DATEUSER; //9 update date la get_profile etc
+(BOOL)updatePreferintaUsers:(NSDictionary*)DATEPREFERINTAUSER; //10 userul a bifat cancel in ecranul de calificative
+(BOOL)schimbaauthtokensiusername:(NSString *)AUTHTOKEN :(NSMutableDictionary*)AUTHNOU;
+(void)updateUsers_cars:(NSArray*)ARIEMASINI :(NSString*)userid;//ultimile 5 masini de la server
+(void)delogheazatotiuserii;

+(NSArray*)getJudete; //toate jud
+(NSDictionary*)getJudet:(NSString*)JUDETID; //un JUDET pe id
+(NSArray*)getLocalitati:(NSString*)JUDET; // toate LOCALITATI pe JUDET id
+(NSDictionary*)getLocalitate:(NSString*)LOCALITATEID; // o LOCALITATE pe id-ul ei
+(NSArray*)getProducatori; //toti producatorii
+(NSDictionary*)getProducator:(NSString*)PRODUCATORID; //un PRODUCATOR pe id
+(NSArray*)getMarciAuto:(NSString*)PRODUCATOR; //toate MARCIAUTO pe PRODUCATOR id
+(NSDictionary*)getMarcaAuto:(NSString*)MARCAUTOID; //o MARCAAUTO pe id-ul ei
+(NSArray*)getYEARS:(NSString*)IDMODEL; //toti anii pe o MARCAAUTO
+(NSArray*)getCURRENCIES; //toate monedele USD EUR etc
+(NSDictionary*)getCURRENCY:(NSString*)CURRENCYID; //o singura CURRENCY pe id-ul ei
+(NSDictionary*)getUSERACCOUNT:(NSString*)USERID; //ia date user pe baza id
+(NSDictionary*)getLOGEDACCOUNT; //ia date despre userul logat
+(NSMutableArray*)getCars:(NSString*)userid; //toate masinile pe user la care s-au facut cereri
+(NSDictionary*) getuser_closealerta:(NSString*)USERID;





@end
