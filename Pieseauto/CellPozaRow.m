//
//  CellPozaRow.m
//  Piese auto
//
//  Created by Ioan Ungureanu on 18/03/16.
//  Copyright © 2016 Activesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellPozaRow.h"
#import "AppDelegate.h"

@interface CellPozaRow ()

@end


@implementation CellPozaRow
@synthesize  SubtitluRand,pozaRow,butonaddpoza,stergeRand;
-(void)viewWillAppear:(BOOL)animated {
}
-(void)loadObjectCell{
   NSLog(@"aici cell poza row");
  
}
- (void)awakeFromNib
{
    // Initialization code
    //NSLog(@"aici cell choose nib");
    self.contentView.frame = self.bounds;
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    butonaddpoza.layer.borderWidth=1.0f;
    butonaddpoza.layer.cornerRadius = 1.0f;
    butonaddpoza.layer.borderColor= [[UIColor lightGrayColor]CGColor] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end