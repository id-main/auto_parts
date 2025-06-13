//
//  CellAcorda.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 07/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellAcorda.h"
#import "AppDelegate.h"


@interface CellAcorda ()

@end


@implementation CellAcorda
@synthesize titluROW,sageatagri,dynamictableheightJ;
@synthesize pozacerere,iconuser,iconcalificativ,titlucalificativ,textcalificativ,dynamictleftpoza,dynamictableheightJ2,titlucalificativcentrat,cadrustele,texteditabil,bifablue,dynamicHEIGHTCOMENTARIU;


-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
  // NSLog(@"aici cell choose 4");
  
}
- (void)awakeFromNib
{
    // Initialization code
   ///// NSLog(@"aici cell acorda");
//    texteditabil.delegate =self;
//    AppDelegate *del = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSMutableDictionary *CERERE =[[NSMutableDictionary alloc]init];
//    CERERE = [del.cererepiesa copy];
//    NSString *TEXTCERERE = [NSString stringWithFormat:@"%@",CERERE[@"TEXTCERERE"]];
//    BOOL Egol  = [self MyStringisEmpty:TEXTCERERE];
//    if(!Egol) {
//        texteditabil.text = TEXTCERERE;
//        texteditabil.textColor=[UIColor blackColor];
//    } else {
    
    //}
  //  texteditabil.textColor = [UIColor lightGrayColor]; //optional
   
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}
//- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
//    [texteditabil resignFirstResponder];
//    return YES;
//    
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end