/*
THTouchpad.m
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


This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
 
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
 
You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import "THTouchpad.h"

@implementation THTouchpad

float const kNotifyMinDistance = 10.0f;

@synthesize dx = _dx;
@synthesize dy = _dy;

-(void) loadTouchpadView{
    
    UIView * view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.88 green:0.69 blue:0.48 alpha:1];
    view.frame = CGRectMake(0, 0, self.width, self.height);
    self.view = view;
    self.view.userInteractionEnabled = YES;
    self.view.multipleTouchEnabled = NO;
    
    self.view.layer.cornerRadius = 5;
    self.view.layer.borderColor = [UIColor blackColor].CGColor;
    self.view.layer.borderWidth = 1.0f;
    
    TFProperty * dxProperty = [TFProperty propertyWithName:@"dx" andType:kDataTypeFloat];
    TFProperty * dyProperty = [TFProperty propertyWithName:@"dy" andType:kDataTypeFloat];
    TFProperty * scaleProperty = [TFProperty propertyWithName:@"scale" andType:kDataTypeFloat];
    self.properties = [NSMutableArray arrayWithObjects:dxProperty,dyProperty,scaleProperty,nil];
    
    TFEvent * event1 = [TFEvent eventNamed:kEventDxChanged];
    event1.param1 = [TFPropertyInvocation invocationWithProperty:dxProperty target:self];
    TFEvent * event2 = [TFEvent eventNamed:kEventDyChanged];
    event2.param1 = [TFPropertyInvocation invocationWithProperty:dyProperty target:self];
    
    TFEvent * event3 = [TFEvent eventNamed:kEventTapped];
    TFEvent * event4 = [TFEvent eventNamed:kEventDoubleTapped];
    
    TFEvent * event5 = [TFEvent eventNamed:kEventScaleChanged];
    event5.param1 = [TFPropertyInvocation invocationWithProperty:scaleProperty target:self];
    
    TFEvent * event6 = [TFEvent eventNamed:kEventLongPressed];
    
    self.events = [NSMutableArray arrayWithObjects:event1,event2, event3,event4, event5, event6, nil];
    
    _scale = 1.0f;
    
}

-(id) init{
    self = [super init];
    if(self){
        
        self.width = 260;
        self.height = 200;
        
        self.xMultiplier = 1;
        self.yMultiplier = 1;
        
        [self loadTouchpadView];
        
    }
    return self;
}

#pragma mark - Archiving

-(id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    
    self.xMultiplier = [decoder decodeFloatForKey:@"xMultiplier"];
    self.yMultiplier = [decoder decodeFloatForKey:@"yMultiplier"];
    
    [self loadTouchpadView];
        
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeFloat:self.xMultiplier forKey:@"xMultiplier"];
    [coder encodeFloat:self.yMultiplier forKey:@"yMultiplier"];
}

-(id)copyWithZone:(NSZone *)zone {
    THTouchpad * copy = [super copyWithZone:zone];
    
    copy.xMultiplier = self.xMultiplier;
    copy.yMultiplier = self.yMultiplier;
    
    return copy;
}

#pragma mark - Methods

-(void) willStartSimulating {
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    _panRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_panRecognizer];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    _tapRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_tapRecognizer];
    
    _doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    _doubleTapRecognizer.cancelsTouchesInView = NO;
    _doubleTapRecognizer.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:_doubleTapRecognizer];
    
    //[_tapRecognizer requireGestureRecognizerToFail:_doubleTapRecognizer];
    
    _pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    _pinchRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_pinchRecognizer];
    
    _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:_longPressRecognizer];
    
    [super willStartSimulating];
}

-(void) stopSimulating {
    [self.view removeGestureRecognizer:_panRecognizer];
    [self.view removeGestureRecognizer:_tapRecognizer];
    [self.view removeGestureRecognizer:_doubleTapRecognizer];
    [self.view removeGestureRecognizer:_pinchRecognizer];
    [self.view removeGestureRecognizer:_longPressRecognizer];
    
    _panRecognizer = nil;
    _tapRecognizer = nil;
    _doubleTapRecognizer = nil;
    _pinchRecognizer = nil;
    _longPressRecognizer = nil;
    
    [super stopSimulating];
}

-(void) handleLongPress:(UILongPressGestureRecognizer*) recognizer{
    
    [self triggerEventNamed:kEventLongPressed];
}

-(void) handlePinch:(UIPinchGestureRecognizer*) recognizer{
    if(recognizer.state == UIGestureRecognizerStateChanged){
        self.scale *= recognizer.scale;
        [recognizer setScale:1.0f];
    }
}

-(void) handleTap:(UITapGestureRecognizer*) recognizer{

    [self triggerEventNamed:kEventTapped];
}

-(void) handleDoubleTap:(UITapGestureRecognizer*) recognizer{

    [self triggerEventNamed:kEventDoubleTapped];
}

- (void) handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    
    [self translateBy:translation];
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

-(void) translateBy:(CGPoint) translation{
    
    self.dx = translation.x * self.xMultiplier;
    self.dy = translation.y * self.yMultiplier;
}

-(void) setScale:(float)scale{
    _scale = scale;
    [self triggerEventNamed:kEventScaleChanged];
}

-(void) setDx:(float)dx{
    _dx = dx;
    [self triggerEventNamed:kEventDxChanged];
}

-(void) setDy:(float)dy{
    _dy = dy;
    [self triggerEventNamed:kEventDyChanged];
}

-(NSString*) description{
    return @"touchpad";
}

-(void) prepareToDie{

    [super prepareToDie];
}

@end
