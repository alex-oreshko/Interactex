/*
THCollectionProjectCell.m
Interactex Designer

Created by Juan Haladjian on 05/10/2013.

Interactex Designer is a configuration tool to easily setup, simulate and connect e-Textile hardware with smartphone functionality. Interactex Client is an app to store and replay projects made with Interactex Designer.

www.interactex.org

Copyright (C) 2013 TU Munich, Munich, Germany; DRLab, University of the Arts Berlin, Berlin, Germany; Telekom Innovation Laboratories, Berlin, Germany
	
Contacts:
juan.haladjian@cs.tum.edu
katharina.bredies@udk-berlin.de
opensource@telekom.de

    
The first version of the software was designed and implemented as part of "Wearable M2M", a joint project of UdK Berlin and TU Munich, which was founded by Telekom Innovation Laboratories Berlin. It has been extended with funding from EIT ICT, as part of the activity "Connected Textiles".

Interactex is built using the Tango framework developed by TU Munich.

In the Interactex software, we use the GHUnit (a test framework for iOS developed by Gabriel Handford) and cocos2D libraries (a framework for building 2D games and graphical applications developed by Zynga Inc.). 
www.cocos2d-iphone.org
github.com/gabriel/gh-unit

Interactex also implements the Firmata protocol. Its software serial library is based on the original Arduino Firmata library.
www.firmata.org

All hardware part graphics in Interactex Designer are reproduced with kind permission from Fritzing. Fritzing is an open-source hardware initiative to support designers, artists, researchers and hobbyists to work creatively with interactive electronics.
www.frizting.org

Martijn ten Bhömer from TU Eindhoven contributed PureData support. Contact: m.t.bhomer@tue.nl.

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 
You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.

*/

#import "THCollectionProjectCell.h"

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

@implementation THCollectionProjectCell


-(void) setEditing:(BOOL)editing{
    if(editing != _editing){
        _editing = editing;
        
        if(editing){
            
            [self startShaking];
            
            self.deleteButton.hidden = NO;
            self.nameTextField.enabled = YES;
            self.nameTextField.borderStyle = UITextBorderStyleLine;

            [self updateBorders];
        } else {
            
            [self stopShaking];
            
            self.deleteButton.hidden = YES;
            self.nameTextField.enabled = NO;
            [self updateBorders];
        }
    }
}

-(void) updateBorders{
    if(self.highlighted){
        
        UIColor * tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
        
        self.imageView.layer.borderColor = tintColor.CGColor;
        self.imageView.layer.borderWidth = 1.0f;
        self.nameTextField.layer.borderColor = tintColor.CGColor;
        self.nameTextField.layer.borderWidth = 1.0f;
        
    } else {
        
        self.imageView.layer.borderWidth = 0.0f;
        
        if(self.editing){
            self.nameTextField.layer.borderWidth = 2.0;
            self.nameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        } else {
            
            self.nameTextField.borderStyle = UITextBorderStyleNone;
            self.nameTextField.layer.borderColor = [[UIColor clearColor] CGColor];
        }
    }
}

#pragma mark - UI Interaction

- (IBAction)textEditingWillBegin:(id)sender {
    
    [self.delegate willStartEditingCellName:self];
}

- (IBAction)deleteTapped:(id)sender {
    
    [self.delegate didDeleteProjectCell:self];
}

- (IBAction)textChanged:(id)sender {
    [self.delegate didRenameProjectCell:self toName:self.nameTextField.text];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [self.nameTextField resignFirstResponder];
    
    return YES;
}

#pragma mark - Effects

- (void)startShaking {
    self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-kShakingEffectAngleInRadians));
    
    [UIView animateWithDuration:kShakingEffectRotationTime
                          delay:0.0
                        options:(UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse)
                     animations:^ {
                        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(kShakingEffectAngleInRadians));
                     }
                     completion:nil
     ];
}

- (void)stopShaking {
    [self.layer removeAllAnimations];
    self.transform = CGAffineTransformIdentity;
}

-(void)fadeView:(UIView*)view toHidden:(BOOL)hidden {
    if(!hidden){
        [view setAlpha:0];
        [view setHidden:NO];
    }
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [view setAlpha:(hidden ? 0 : 1)];
                     } completion:^(BOOL finished) {
                         if(hidden){
                             [view setHidden:YES];
                         }
                     }];
}

-(void) scaleEffect{
    
    [UIView animateWithDuration:kProjectCellScaleEffectDuration/2.0f
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         self.transform = CGAffineTransformMakeScale(1.1, 1.1);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:kProjectCellScaleEffectDuration/2.0f
                                               delay:0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:(void (^)(void)) ^{
                                              self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                                          }
                                          completion:^(BOOL finished){
                                              
                                              self.transform = CGAffineTransformIdentity;
                                              
                                          }];
                         
                     }];
}

-(BOOL) canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(duplicate:));
}

-(void) duplicate: (id) sender {
    [self.delegate didDuplicateProjectCell:self];
}

-(void) setHighlighted:(BOOL)highlighted{
    if(self.highlighted != highlighted){
        [super setHighlighted:highlighted];
        
        [self updateBorders];

    }
}

/*
#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if(range.length + range.location > textField.text.length)     {
        return NO;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return newLength <= kProjectNameMaxCharacters && newLength > 0;
}*/

@end
