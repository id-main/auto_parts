//
//  CellLoginRow.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 21/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellLoginRow.h"
#import "AppDelegate.h"

@interface CellLoginRow ()

@end


@implementation CellLoginRow
@synthesize texteditabil,sageatablue,pozaRow,TitluRand,TitluRandlogin,suntDeAcord;

-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
 //  NSLog(@"aici cell choose 4");
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)awakeFromNib
{
    
    // Initialization code
 //    NSLog(@"aici cell login email telefon");
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    texteditabil.delegate = self;
  
}
-(BOOL)MyStringisEmpty:(NSString *)str
{
    if(str.length==0 || [str isKindOfClass:[NSNull class]] || [str isEqualToString:@""]||[str  isEqualToString:@"NULL"]||[str isEqualToString:@"(null)"]|| [str isEqualToString:@"<null>"] || [str isEqualToString:@"null"] ||str==nil){
        return YES;
    }
    return NO;
}

@end