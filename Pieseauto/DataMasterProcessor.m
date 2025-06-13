//
//  DataMasterProcessor.m
//  PieseAuto
//
//  Created by Ioan Ungureanu far away in future
//  Copyright (c) 2016 Active Soft SRL. All rights reserved.
//

#import "DataMasterProcessor.h"
#import "DB_template.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "FMDatabaseAdditions.h"
@interface DataMasterProcessor()

@end
@implementation DataMasterProcessor
//1
//string is empty
+(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}
+(BOOL)insertJudete:(NSArray*)JUDETE :(NSString*)metoda{
    BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSArray *documentsJSONStream = JUDETE;
    static NSString *insertSQLStatment = @"REPLACE INTO judete (`id`,`name`) VALUES ( ?, ?)";
    [db.db beginTransaction];
    for (NSDictionary *dJ in documentsJSONStream)
    {
        NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
        NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
        
        if([metoda isEqualToString:@"insert"]||[metoda isEqualToString:@"update"]) {
            [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,NAME]];
        }
      /* slow and bad :) if([metoda isEqualToString:@"update"]) {
            NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
            NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
            //UPDATE Cars SET Name='Skoda Octavia' WHERE Id=3;
            NSString *QUERYBUN = [NSString stringWithFormat:@"select count(*) as cnt from judete WHERE id=%@",ID];
            FMResultSet *rs = [db.db executeQuery:QUERYBUN];
            NSUInteger count =0;
            while ([rs next]) {
               count = [rs intForColumn:@"cnt"];
            }
        //    NSLog(@"count %lu",(unsigned long)count);
            if(count ==0) {
             
               [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,NAME]];
            } else {
               
            NSString* replaceSQLStatment=[NSString stringWithFormat:@"UPDATE judete set `id`=\"%@\",`name`=\"%@\" WHERE id=%@",ID,NAME,ID];
         //   NSLog(@"upd %@", replaceSQLStatment);
            [db.db executeUpdate:replaceSQLStatment];
          }
         }*/
    }
    ok= [db.db commit];
    [db.db close];
    return ok;
}
//2
+(BOOL)insertProducatori:(NSArray*)PRODUCATORI :(NSString*)metoda{
    BOOL ok =NO;
    
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSArray *documentsJSONStream = PRODUCATORI;
    static NSString *insertSQLStatment = @"REPLACE INTO producatori (`id`,`name`) VALUES ( ?, ?)";
    [db.db beginTransaction];
    for (NSDictionary *dJ in documentsJSONStream)
    {
        NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
        NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
        if([metoda isEqualToString:@"insert"]|| [metoda isEqualToString:@"update"]) {
          [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,NAME]];
        }
    }
    ok= [db.db commit];
    [db.db close];
    return ok;
}

//3
+(BOOL)insertCarModels:(NSArray*)MARCIAUTO :(NSString*)metoda{
    BOOL ok =NO;
    
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSArray *documentsJSONStream = MARCIAUTO;
    static NSString *insertSQLStatment = @"REPLACE INTO marci (`id`,`carmaker_id`,`name`,`year_end`,`year_start`) VALUES ( ?, ?, ?, ?, ?)";
    [db.db beginTransaction];
    for (NSDictionary *dJ in documentsJSONStream)
    {
        NSString *carmaker_id=[NSString stringWithFormat:@"%@",dJ[@"carmaker_id"]];
        NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
        NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
        NSString *year_end =[NSString stringWithFormat:@"%@",dJ[@"year_end"]];
        NSString *year_start =[NSString stringWithFormat:@"%@",dJ[@"year_start"]];
        if([metoda isEqualToString:@"insert"] ||[metoda isEqualToString:@"update"]) {
                [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,carmaker_id,NAME,year_end,year_start]];
        }
     }
    
    ok= [db.db commit];
    [db.db close];
    return ok;
}
//4
+(BOOL)insertLocalitati:(NSArray*)LOCALITATI :(NSString*)metoda{
    BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSArray *documentsJSONStream = LOCALITATI;
    static NSString *insertSQLStatment = @"REPLACE INTO localitati (`id`,`county_id`,`name`) VALUES (?, ?, ?)";
    [db.db beginTransaction];
    for (NSDictionary *dJ in documentsJSONStream)
    {
        NSString *county_id=[NSString stringWithFormat:@"%@",dJ[@"county_id"]];
        NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
        NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
        if([metoda isEqualToString:@"insert"]||[metoda isEqualToString:@"update"]) {
            [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,county_id,NAME]];
        }
      
    }
    ok= [db.db commit];
    [db.db close];
    return ok;
}
//5
+(BOOL)insertCurrencies:(NSArray*)CURRENCIES :(NSString*)metoda {
    BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSArray *documentsJSONStream = CURRENCIES;
    static NSString *insertSQLStatment = @"REPLACE INTO currencies (`id`,`name`) VALUES ( ?, ?)";
    [db.db beginTransaction];
    for (NSDictionary *dJ in documentsJSONStream)
    {
        NSString *ID=[NSString stringWithFormat:@"%@",dJ[@"id"]];
        NSString *NAME =[NSString stringWithFormat:@"%@",dJ[@"name"]];
        if([metoda isEqualToString:@"insert"]||[metoda isEqualToString:@"update"]) {
            [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[ID,NAME]];
     }
        }
    ok= [db.db commit];
    [db.db close];
    return ok;
}
//6
+(BOOL)updateUsers:(NSDictionary*)DATEUSER{
    [self  delogheazatotiuserii];
    /*
     "U_adresa" = "";
     "U_authtoken" = "1248f7g5718a2bagrjfEhW7MbsX-CmisuhO5veYE1izRyXICRFwU4Q9ooA8";
     "U_cod_postal" = "";
     "U_email" = "ioan.ungureanu@activesoft.ro";
     "U_judet" = "";
     "U_lastupdate" = 0;
     "U_localitate" = 0;
     "U_nume" = "";
     "U_preferinte_notificari" = 3;
     "U_prenume" = "";
     "U_telefon" = 0726744222;
     "U_telefon2" = 0726744222;
     "U_telefon3" = 0726744222;
     "U_telefon4" = 0726744222;
     "U_userid" = 1198327;
     "U_username" = ioanungureanu;*/
    
    NSDictionary *userd =[[NSDictionary alloc]init];
    userd = DATEUSER;
  //  NSLog(@"DATEUSER UPDATE %@", DATEUSER);
    
    NSString *U_authtoken= [NSString stringWithFormat:@"%@",userd[@"U_authtoken"]]; //*
    NSString *U_lastupdate=  [NSString stringWithFormat:@"%@",userd[@"U_lastupdate"]];//*
    NSString *U_username=  [NSString stringWithFormat:@"%@",userd[@"U_username"]];//*
    NSString *U_logat= @"1"; //*
    NSString *U_preferinte_notificari=  [NSString stringWithFormat:@"%@",userd[@"U_preferinte_notificari"]];//*
    NSString *U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];//*
    NSString *U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];//*
    NSString *U_email=  [NSString stringWithFormat:@"%@",userd[@"U_email"]];//*
    NSString *U_telefon=  [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];//*
    NSString *U_telefon2=  [NSString stringWithFormat:@"%@",userd[@"U_telefon2"]];//*
    NSString *U_telefon3=  [NSString stringWithFormat:@"%@",userd[@"U_telefon3"]];//*
    NSString *U_telefon4=  [NSString stringWithFormat:@"%@",userd[@"U_telefon4"]];//*
    NSString *U_judet=  [NSString stringWithFormat:@"%@",userd[@"U_judet"]];//*
    NSString *U_localitate=  [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];//*
    NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];//*
    NSString *U_adresa=  [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];//*
    NSString *U_userid= [NSString stringWithFormat:@"%@",userd[@"U_userid"]];//*
    
    BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db beginTransaction];
    NSString *insertSQLStatment = [NSString stringWithFormat: @"UPDATE  users set `U_lastupdate` ='%@',`U_username`='%@',`U_preferinte_notificari`='%@',`U_logat`='%@',`U_prenume`='%@',`U_nume`='%@',`U_email`='%@',`U_telefon`='%@',`U_telefon2`='%@',`U_telefon3`='%@',`U_telefon4`='%@',`U_judet`='%@',`U_localitate`='%@',`U_cod_postal`='%@',`U_adresa`='%@',`U_authtoken`='%@',`U_userid`='%@' WHERE `U_userid`='%@'",U_lastupdate,U_username,U_preferinte_notificari,U_logat,U_prenume,U_nume,U_email,U_telefon,U_telefon2,U_telefon3,U_telefon4,U_judet,U_localitate,U_cod_postal,U_adresa,U_authtoken, U_userid ,U_userid];
    NSLog(@"update_query %@",insertSQLStatment);
    [db.db executeUpdate:insertSQLStatment];
    ok= [db.db commit];
    [db.db close];
    NSLog(@"update users ok %i", ok);
    return ok;
}
+(BOOL)insertUsers:(NSDictionary*)DATEUSER{ //toti userii care s-au logat inregistrat
 [self  delogheazatotiuserii];
  /*
  CREATE TABLE "users" ("U_authtoken" VARCHAR NOT NULL  UNIQUE,
  "U_lastupdate" VARCHAR,
  "U_username" VARCHAR,
  "U_logat" VARCHAR,
  "U_preferinte_notificari" VARCHAR,
  "U_prenume" VARCHAR,
  "U_nume" VARCHAR,
  "U_email" VARCHAR,
  "U_telefon" VARCHAR,
   "U_telefon2" = 0726744222;
   "U_telefon3" = 0726744222;
   "U_telefon4" = 0726744222;
  "U_judet"  VARCHAR,
  "U_localitate"  VARCHAR,
  "U_cod_postal" VARCHAR,
  "U_adresa" VARCHAR,
  "U_parola" VARCHAR,
  "U_userid" VARCHAR
   )
  */

    NSDictionary *userd =[[NSDictionary alloc]init];
    userd = DATEUSER;
    NSString *U_authtoken= [NSString stringWithFormat:@"%@",userd[@"U_authtoken"]];
    NSString *U_lastupdate=  [NSString stringWithFormat:@"%@",userd[@"U_lastupdate"]];
    NSString *U_username=  [NSString stringWithFormat:@"%@",userd[@"U_username"]];
    NSString *U_logat=  [NSString stringWithFormat:@"%@",userd[@"U_logat"]];
    NSString *U_preferinte_notificari=  [NSString stringWithFormat:@"%@",userd[@"U_preferinte_notificari"]];
    NSString *U_prenume=  [NSString stringWithFormat:@"%@",userd[@"U_prenume"]];
    NSString *U_nume=  [NSString stringWithFormat:@"%@",userd[@"U_nume"]];
    NSString *U_email=  [NSString stringWithFormat:@"%@",userd[@"U_email"]];
    NSString *U_telefon=  [NSString stringWithFormat:@"%@",userd[@"U_telefon"]];
    NSString *U_telefon2=  [NSString stringWithFormat:@"%@",userd[@"U_telefon2"]];
    NSString *U_telefon3=  [NSString stringWithFormat:@"%@",userd[@"U_telefon3"]];
    NSString *U_telefon4=  [NSString stringWithFormat:@"%@",userd[@"U_telefon4"]];
    NSString *U_judet=  [NSString stringWithFormat:@"%@",userd[@"U_judet"]];
    NSString *U_localitate=  [NSString stringWithFormat:@"%@",userd[@"U_localitate"]];
    NSString *U_cod_postal=  [NSString stringWithFormat:@"%@",userd[@"U_cod_postal"]];
    NSString *U_adresa=  [NSString stringWithFormat:@"%@",userd[@"U_adresa"]];
    NSString *U_parola=  [NSString stringWithFormat:@"%@",userd[@"U_parola"]];
    NSString *U_userid=  [NSString stringWithFormat:@"%@",userd[@"U_userid"]];
    BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    static NSString *insertSQLStatment = @"REPLACE INTO users (`U_authtoken`,`U_lastupdate`,`U_username`,`U_logat`,`U_preferinte_notificari`,`U_prenume`,`U_nume`,`U_email`,`U_telefon`,`U_telefon2`,`U_telefon3`,`U_telefon4`,`U_judet`,`U_localitate`,`U_cod_postal`,`U_adresa`,`U_parola`,`U_userid`) VALUES ( ?, ?, ?, ?, ?, ?, ? , ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? )";
    [db.db beginTransaction];
    [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[U_authtoken,U_lastupdate,U_username,U_logat,U_preferinte_notificari,U_prenume,U_nume,U_email,U_telefon,U_telefon2,U_telefon3,U_telefon4,U_judet,U_localitate,U_cod_postal,U_adresa,U_parola,U_userid]];
     ok= [db.db commit];
    [db.db close];
    NSLog(@"bad insert ?%i", ok);
   
    return ok;
}
//7
+(BOOL)schimbaauthtokensiusername:(NSString *)AUTHTOKEN :(NSMutableDictionary*)AUTHNOU {
    BOOL ok =NO;
    NSMutableDictionary *userd =[[NSMutableDictionary alloc]init];
    NSString *U_authtoken= [NSString stringWithFormat:@"%@",userd[@"U_authtoken"]];
    NSString *U_username=  [NSString stringWithFormat:@"%@",userd[@"U_username"]];
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    NSString *insertSQLStatment = [NSString stringWithFormat:@"UPDATE users SET `U_authtoken`='%@',`U_username`='%@' WHERE U_username='%@'",U_authtoken,U_username,U_username];
    [db.db executeUpdate:insertSQLStatment];
    ok= [db.db commit];
    [db.db close];
    return ok;
}
+(void)updateUsers_cars:(NSArray*)ARIEMASINI :(NSString*)userid{
    /*
     {
     "model_id" = 2;
     motorizare = resdg;
     "talon_an_fabricatie" = 1981;
     "talon_tip_varianta" = "test f";
     }
    */
       BOOL ok =NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    //se sterg masinile  vechi //mereu se face update cu ce aduce de la server
    static NSString *deleteSQLStatment = @"DELETE * from users_cars";
    [db.db beginTransaction];
    [db.db executeUpdate:deleteSQLStatment];
    ok= [db.db commit];
    [db.db close];
    NSLog(@"machinete de insert %@", ARIEMASINI);
    NSArray *masiniuserdelaserver = [NSArray arrayWithArray:ARIEMASINI];
    for(int i =0; i< masiniuserdelaserver.count;i++) {
        NSDictionary *caruser =[[NSDictionary alloc]init];
        caruser= [masiniuserdelaserver objectAtIndex:i];
     
    NSString *C_producator_id= @"";
    NSString *C_model_id=  @"";
    NSString *C_talon_an_fabricatie=  @"";
    NSString *C_talon_tip_varianta=  @"";
    NSString *C_motorizare=  @"";
    NSString *C_talon_nr_identificare= @"";
    NSString *C_userid= userid;
    if(caruser[@"model_id"]) {
        C_model_id= [NSString stringWithFormat:@"%@",caruser[@"model_id"]];
        NSDictionary *producatornecesar = [self getMarcaAuto:C_model_id];
        if( producatornecesar[@"carmaker_id"])  C_producator_id = producatornecesar[@"carmaker_id"];
        
    }
        if(caruser[@"motorizare"]) C_motorizare= [NSString stringWithFormat:@"%@",caruser[@"motorizare"]];
        if(caruser[@"talon_an_fabricatie"]) C_talon_an_fabricatie= [NSString stringWithFormat:@"%@",caruser[@"talon_an_fabricatie"]];
        if(caruser[@"talon_tip_varianta"]) C_talon_tip_varianta= [NSString stringWithFormat:@"%@",caruser[@"talon_tip_varianta"]];
     NSLog(@" %@ %@ %@ %@ %@ %@ %@", C_userid,C_producator_id,C_model_id,C_talon_an_fabricatie,C_talon_tip_varianta,C_motorizare,C_talon_nr_identificare);
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    static NSString *insertSQLStatment = @"REPLACE INTO users_cars (`C_producator_id`,`C_model_id`,`C_talon_an_fabricatie`,`C_talon_tip_varianta`,`C_motorizare`,`C_talon_nr_identificare`,`C_userid`) VALUES ( ?, ?, ?, ?, ?, ?, ?)";
    [db.db beginTransaction];
    [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[C_producator_id,C_model_id,C_talon_an_fabricatie,C_talon_tip_varianta,C_motorizare,C_talon_nr_identificare,C_userid]];
  ok= [db.db commit];
    [db.db close];
    }
}
+(BOOL)insertUsers_cars:(NSDictionary*)DATECARCERERE :(NSString*)userid{ //se insereaza toate masinile pt care s-au facut cereri
    BOOL ok =NO;
    NSString *C_userid = userid;
    NSDictionary *caruser =[[NSDictionary alloc]init];
    caruser = DATECARCERERE;
    NSLog(@"machineta de insert %@", DATECARCERERE);
    /*
     [corpcerere setObject:C_producator_id forKey:@"producator_id"];
     [corpcerere setObject:C_model_id forKey:@"model_id"];
     [corpcerere setObject:C_talon_tip_varianta forKey:@"talon_tip_varianta"];
     [corpcerere setObject:C_talon_an_fabricatie forKey:@"talon_an_fabricatie"];
     [corpcerere setObject:C_motorizare forKey:@"motorizare"];
     [corpcerere setObject:C_talon_nr_identificare forKey:@"talon_nr_identificare"];
     
     CREATE TABLE "users_cars" ("id"  INTEGER
     "C_producator_id" VARCHAR,
     "C_model_id" VARCHAR,
     "C_talon_an_fabricatie" VARCHAR,
     "C_talon_tip_varianta" VARCHAR,
     "C_motorizare" VARCHAR,
     "C_talon_nr_identificare" VARCHAR,
     "C_authtoken" VARCHAR NOT NULL  UNIQUE
     )
     
     CREATE TABLE "users_cars" ("id"  INTEGER
     "C_producator_id" VARCHAR,
     "C_model_id" VARCHAR,
     "C_talon_an_fabricatie" VARCHAR,
     "C_talon_tip_varianta" VARCHAR,
     "C_motorizare" VARCHAR,
     "C_talon_nr_identificare" VARCHAR,
     "C_authtoken" VARCHAR
     )REPLACE INTO users_cars (C_producator_id,C_model_id,C_talon_an_fabricatie,C_talon_tip_varianta,C_motorizare,C_talon_nr_identificare,C_authtoken) VALUES ( '3', '39', '1982', 'ggxhxhh', 'sdxc', 'dcv', "1248f7g56f8ec0cgyjkcXQUS4zFv6xo-Pm3zE0EpU5k3hWmI14B9Y_duF5s")
     
     */
    NSString *C_producator_id= [NSString stringWithFormat:@"%@",caruser[@"producator_id"]];
    NSString *C_model_id= [NSString stringWithFormat:@"%@",caruser[@"model_id"]];
    NSString *C_talon_an_fabricatie= [NSString stringWithFormat:@"%@",caruser[@"talon_an_fabricatie"]];
    NSString *C_talon_tip_varianta= [NSString stringWithFormat:@"%@",[caruser  objectForKey:@"talon_tip_varianta"]];
    NSString *C_motorizare= [NSString stringWithFormat:@"%@",caruser[@"motorizare"]];
    NSString *C_talon_nr_identificare=[NSString stringWithFormat:@"%@",[caruser  objectForKey:@"talon_nr_identificare"]];
    NSLog(@" %@ %@ %@ %@ %@ %@ %@", C_userid,C_producator_id,C_model_id,C_talon_an_fabricatie,C_talon_tip_varianta,C_motorizare,C_talon_nr_identificare);
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    static NSString *insertSQLStatment = @"REPLACE INTO users_cars (`C_producator_id`,`C_model_id`,`C_talon_an_fabricatie`,`C_talon_tip_varianta`,`C_motorizare`,`C_talon_nr_identificare`,`C_userid`) VALUES ( ?, ?, ?, ?, ?, ?, ?)";
    [db.db beginTransaction];
    [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[C_producator_id,C_model_id,C_talon_an_fabricatie,C_talon_tip_varianta,C_motorizare,C_talon_nr_identificare,C_userid]];
    ok= [db.db commit];
    [db.db close];
     return ok;
}
+(NSArray*)getCURRENCIES {
    NSArray* data;
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    query=[NSString stringWithFormat:@"SELECT * FROM currencies"];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    return data;
}
+(NSDictionary*)getCURRENCY:(NSString*)CURRENCYID{
    NSArray* data;
    NSDictionary *currency =[[NSDictionary alloc]init];
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    if (![self MyStringisEmpty:CURRENCYID]){
        query=[NSString stringWithFormat:@"SELECT * FROM currencies WHERE id='%@'", CURRENCYID];
    }
    NSLog(@"acest query %@", query);
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        currency = [data objectAtIndex:0];
    }
    NSLog(@"currency %@", currency);
    return currency;
}
/*
 CREATE TABLE "close_alerta" ("A_afisat" VARCHAR,
 "U_userid" VARCHAR  NOT NULL  UNIQUE)
 */
+(BOOL)updatePreferintaUsers:(NSMutableDictionary*)DATEPREFERINTAUSER{
    BOOL ok=NO;
    NSMutableDictionary *prefuser =[[NSMutableDictionary alloc]init];
    prefuser = DATEPREFERINTAUSER;
    NSString *U_userid= [NSString stringWithFormat:@"%@",prefuser[@"U_userid"]];
    NSString *preferinta= [NSString stringWithFormat:@"%@",prefuser[@"preferinta"]];
    NSLog(@"U_userid PREFERINTA  %@ %@", U_userid,preferinta);
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db setShouldCacheStatements:YES];
    static NSString *insertSQLStatment = @"REPLACE INTO close_alerta (`U_userid`,`A_afisat`) VALUES ( ?, ?)";
    [db.db beginTransaction];
    [db.db executeUpdate:insertSQLStatment withArgumentsInArray:@[U_userid,preferinta]];
    ok= [db.db commit];
    [db.db close];
    return ok;
}
+(NSDictionary*) getuser_closealerta:(NSString*)USERID {
    NSDictionary *PREFERINTAUSERA =[[NSDictionary alloc]init];
    NSString* query=@"";
    NSArray* data;
    DB_template *db = [[DB_template alloc] initDB];
    query=[NSString stringWithFormat:@"SELECT * FROM close_alerta WHERE `U_userid`=%@",USERID];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        PREFERINTAUSERA = [data objectAtIndex:0];
    }
    return PREFERINTAUSERA;
}
+(NSArray*)getYEARS:(NSString*)IDMODEL{
    NSArray* data = [[NSArray alloc]init];
    NSMutableArray* years=[[NSMutableArray alloc]init];
    NSArray *ani =[[NSArray alloc]init];
    NSDictionary* model;
    DB_template *db = [[DB_template alloc] initDB];
    NSString* query=[NSString stringWithFormat:@"SELECT * FROM marci WHERE id='%@'",IDMODEL];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count>0) {
    model = [data objectAtIndex:0];
   if(model[@"year_start"] && model[@"year_end"]) {
        int startyear =(int)[model[@"year_start"]integerValue];
        int endyear =(int)[model[@"year_end"]integerValue];
         NSLog(@"model e %@ ys %d ye %d",model, startyear,endyear);
        for (int i=startyear; i<= endyear;i++) {
            NSString *ceva = [NSString stringWithFormat:@"%d",i];
            [years addObject:ceva];
        }
        ani = [NSArray arrayWithArray:years];
   }
   }
    //// NSLog(@"aniiii %@", ani );
    return ani;
    
}
+(NSArray*)getJudete {
     NSArray* data;
     NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    query=[NSString stringWithFormat:@"SELECT * FROM judete"];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
     return data;
}
+(NSDictionary*)getJudet:(NSString*)JUDETID {
    NSArray* data;
    NSDictionary *judet =[[NSDictionary alloc]init];
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
   //int ceva =(int)JUDETID.integerValue;
    if (![self MyStringisEmpty:JUDETID]){
    query=[NSString stringWithFormat:@"SELECT * FROM judete WHERE id='%@'", JUDETID];
    }
    NSLog(@"acest query %@", query);
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        judet = [data objectAtIndex:0];
    }
    NSLog(@"jjj %@", judet);
    return judet;
}
//daca nu se da parametru intoarce toate
+(NSArray*)getLocalitati:(NSString*)JUDET {
    NSString* query=@"";
    NSArray* data;
    DB_template *db = [[DB_template alloc] initDB];
    if ([self MyStringisEmpty:JUDET]){
        query=[NSString stringWithFormat:@"SELECT * FROM localitati"];
    } else {
        query=[NSString stringWithFormat:@"SELECT * FROM localitati WHERE county_id='%@'", JUDET];
    }
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    
    return data;
}
+(NSDictionary*)getLocalitate:(NSString*)LOCALITATEID {
    NSArray* data;
    NSDictionary *localitate =[[NSDictionary alloc]init];
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    if (![self MyStringisEmpty:LOCALITATEID]){
        query=[NSString stringWithFormat:@"SELECT * FROM localitati WHERE id='%@'",LOCALITATEID];
    }
    // NSLog(@"acest query %@", query);
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        localitate = [data objectAtIndex:0];
    }
    return localitate;
}


+(NSArray*)getProducatori {
    NSArray* data;
    DB_template *db = [[DB_template alloc] initDB];
    NSString* query=[NSString stringWithFormat:@"SELECT * FROM producatori"];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    
    return data;
}
+(NSDictionary*)getProducator:(NSString*)PRODUCATORID{
    NSArray* data;
    NSDictionary *producator =[[NSDictionary alloc]init];
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    if (![self MyStringisEmpty:PRODUCATORID]){
        query=[NSString stringWithFormat:@"SELECT * FROM producatori WHERE id='%@'", PRODUCATORID];
    }
    // NSLog(@"acest query %@", query);
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        producator = [data objectAtIndex:0];
    }
    return producator;
}

//daca nu se da parametru intoarce toate marcile
+(NSArray*)getMarciAuto:(NSString*)PRODUCATOR {
    NSString* query=@"";
    NSArray* data;
    DB_template *db = [[DB_template alloc] initDB];
    if ([self MyStringisEmpty:PRODUCATOR]){
           query=[NSString stringWithFormat:@"SELECT * FROM marci"];
     } else {
   query=[NSString stringWithFormat:@"SELECT * FROM marci WHERE carmaker_id='%@'", PRODUCATOR];
     }
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    
    return data;
}
+(NSDictionary*)getMarcaAuto:(NSString*)MARCAUTOID{
    NSArray* data;
    NSDictionary *MARCA =[[NSDictionary alloc]init];
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    if (![self MyStringisEmpty:MARCAUTOID]){
        query=[NSString stringWithFormat:@"SELECT * FROM marci WHERE id='%@'",MARCAUTOID];
    }
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        MARCA = [data objectAtIndex:0];
    }
    return MARCA;
}
+(NSDictionary*)getLOGEDACCOUNT {
   
    NSDictionary *USERACCOUNT =[[NSDictionary alloc]init];
    NSArray* data;
    NSString* query=@"";
    DB_template *db = [[DB_template alloc] initDB];
    query=[NSString stringWithFormat:@"SELECT * FROM users WHERE `U_logat`='1'"];
    data=[db getArrayForQuerry:query];
    [db deallocDB];
    if(data.count >0) {
        USERACCOUNT = [data objectAtIndex:0];
    }
    //nu uita daca vrei sa vezi toti userii ...
//    for(int i=0;i<data.count;i++) {
//          NSDictionary *USERACCOUNTx = [data objectAtIndex:i];
//      NSLog(@"USERACCOUNTx%@",USERACCOUNTx);
//    }
    return USERACCOUNT;
}
+(NSDictionary*)getUSERACCOUNT:(NSString*)USERID { //ia date user pe baza id
     NSDictionary *USERACCOUNT =[[NSDictionary alloc]init];
     NSArray* data;
     NSString* query=@"";
     DB_template *db = [[DB_template alloc] initDB];
    if (![self MyStringisEmpty:USERID]){

            query=[NSString stringWithFormat:@"SELECT * FROM users WHERE `U_userid`='%@'",USERID];
        }
        data=[db getArrayForQuerry:query];
        [db deallocDB];
        if(data.count >0) {
            USERACCOUNT = [data objectAtIndex:0];
        }
   return USERACCOUNT;
}
+(NSMutableArray*)getCars:(NSString*)userid{ //toate masinile pe user la care s-au facut cereri
    NSLog(@"authh %@", userid);
    NSString *cevaauth= [NSString stringWithFormat:@"%@", userid];
    NSMutableArray *MASINIUNICE = [[NSMutableArray alloc]init];
    NSString* query=@"";
    NSArray* data;
    DB_template *db = [[DB_template alloc] initDB];
    query=[NSString stringWithFormat:@"SELECT * FROM users_cars  WHERE `C_userid` = '%@'", cevaauth];
    data=[db getArrayForQuerry:query];
    NSLog(@"masini user %@", data);
    [db deallocDB];
    //pentru ca vrem masinile unice trebuie filtrat
    for(int i=0;i<data.count;i++) {
        NSDictionary *ceva =[data objectAtIndex:i];
        if(![MASINIUNICE containsObject:ceva]) {
            [MASINIUNICE addObject:ceva];
        }
    }
    return MASINIUNICE;
}


+(void)delogheazatotiuserii { //pune valori 0 pe U_logat in db users
    NSLog(@"ARGGGG ");
    BOOL ok=NO;
    DB_template* db = [[DB_template alloc] initDB];
    [db.db open];
    [db.db beginTransaction];
     static NSString *updateSQLStatment = @"UPDATE users set `U_logat` ='0'";
    [db.db executeUpdate:updateSQLStatment];
    ok= [db.db commit];
    [db.db close];
    AppDelegate * del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if(del.NOTIFY_COUNT) { // ca sa nu ramana badges de la ceilalti
        del.NOTIFY_COUNT= [[NSDictionary alloc]init];
    }
    NSLog(@"update users ok %i", ok);
    
    ///// [self getLOGEDACCOUNT];
}

////////////////////////////////////////////////


@end
