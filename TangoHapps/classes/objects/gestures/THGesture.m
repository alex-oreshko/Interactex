//
//  THGestures.m
//  TangoHapps
//
//  Created by Timm Beckmann on 03/04/14.
//  Copyright (c) 2014 Technische Universität München. All rights reserved.
//

#import "THGesture.h"
#import "THHardwareComponentEditableObject.h"
#import "THGesturePaletteItem.h"
#import "THCustomPaletteItem.h"
#import "THGestureProperties.h"

@implementation THGesture

-(void) load{
    
    self.sprite = [CCSprite spriteWithFile:@"gesture.png"];
    [self addChild:self.sprite];
        
    self.canBeAddedToPalette = YES;
    
    self.scale = 1;
    
    _attachments = [NSMutableArray array];
    
    _layer = [CCLayerColor node];
    _layer.color = ccc3(200, 200, 200);
    _layer.opacity = 255;
    _layer.contentSize = self.sprite.boundingBox.size;
    _layer.visible = false;
    [self addChild:_layer];
    
    /*_closeButton = [CCSprite spriteWithFile:@"delete.png"];
    _closeButton.scale = 0.2f;
    _closeButton.position = CGPointMake(_layer.boundingBox.size.height - _closeButton.boundingBox.size.height/2, _layer.boundingBox.size.width - _closeButton.boundingBox.size.width/2);
    [_layer addChild:_closeButton];*/

}

-(id) initWithName:(NSString*) name{
    self = [super init];
    if(self){
        self.name = name;
        [self load];
    }
    return self;
}


#pragma mark - Archiving

-(id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self){
        self.name = [decoder decodeObjectForKey:@"name"];
        
        [self load];
        
        NSArray * attachments = [decoder decodeObjectForKey:@"attachments"];
        for (THHardwareComponentEditableObject * attachment in attachments) {
            [self attachGestureObject:attachment];
        }
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:_attachments forKey:@"attachments"];
}

-(id)copyWithZone:(NSZone *)zone {
    THGesture * copy = [super copyWithZone:zone];
    copy.name = self.name;

    [copy load];
    
    for (TFEditableObject * attachment in _attachments) {
        [copy attachGestureObject:[attachment copy]];
    }
    
    return copy;
}


#pragma mark - Property Controllers

-(NSArray*)propertyControllers {
    NSMutableArray *controllers = [NSMutableArray array];
    if (_isOpen)[controllers addObject:[THGestureProperties properties]];
    return controllers;
}

#pragma mark - World and Layer

-(void) addToWorld{
    THProject * project = (THProject*) [THDirector sharedDirector].currentProject;
    [project addGesture:self];
    
    for (TFEditableObject * attachment in _attachments) {
        [attachment addToWorld];
    }
}

-(void) removeFromWorld{
    NSMutableArray * attachments = [NSMutableArray arrayWithArray:_attachments];
    for (TFEditableObject * object in attachments) {
        [object removeFromWorld];
    }
    
    THProject * project = (THProject*) [THDirector sharedDirector].currentProject;
    [project removeGesture:self];
    [super removeFromWorld];
}

-(void) addToLayer:(TFLayer*) layer{
    [layer addEditableObject:self];
}

-(void) removeFromLayer:(TFLayer*) layer{
    [layer removeEditableObject:self];
}

#pragma mark - Methods

-(THPaletteItem*) paletteItem{
    THGesturePaletteItem * paletteItem = [THCustomPaletteItem customPaletteItemWithName:self.name object:self];
    return paletteItem;
}

-(void) objectRemoved:(NSNotification*) notification{
    TFEditableObject * object = notification.object;
    [_attachments removeObject:object];
}

-(void) attachGestureObject:(THHardwareComponentEditableObject*) object{
    
    [_attachments addObject:object];
    [self addChild:object z:1];
    if (object.scale ==1) object.scale /= 15;
    if (!_layer.visible) object.visible = false;
    object.attachedToGesture = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(objectRemoved:) name:kNotificationObjectRemoved object:object];
}

-(void) deattachGestureObject:(THHardwareComponentEditableObject*) object{
    
    [_attachments removeObject:object];
    [object removeFromParentAndCleanup:YES];
    object.scale = 1;
    object.attachedToGesture = nil;

    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationObjectRemoved object:object];
}

-(void) openClose {
    _isOpen = !_isOpen;
    if (_isOpen) {
        _layer.visible = true;
        self.scale = 10;
        self.z = kGestureZ;
        for (THHardwareComponentEditableObject* obj in _attachments) {
            obj.visible = true;
        }
    } else {
        _layer.visible = false;
        self.scale = 1;
        self.z = kGestureObjectZ;
        for (THHardwareComponentEditableObject* obj in _attachments) {
            obj.visible = false;
        }
    }
}

-(NSString*) description{
    return @"Gesture";
}

-(void) prepareToDie{
    
    _attachments = nil;
    [super prepareToDie];
}

@end
