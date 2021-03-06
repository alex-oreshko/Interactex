//
//  THOutputEditable.m
//  TangoHapps
//
//  Created by Timm Beckmann on 10.06.14.
//  Copyright (c) 2014 Technische Universität München. All rights reserved.
//

#import "THOutputEditable.h"
#import "THOutput.h"
#import "THGestureEditableObject.h"

@implementation THOutputEditable

-(void) load{

    self.simulableObject = [[THOutput alloc] init];
    
    self.sprite = [CCSprite spriteWithFile:@"outputEmpty.png"];
    [self addChild:self.sprite];
    
    self.canBeAddedToGesture = YES;
    self.acceptsConnections = YES;
    self.canBeMoved = NO;
    self.canBeDuplicated = NO;
    
    self.scale = 1;
    

    
}

-(id) init{
    self = [super init];
    if(self){
        
        [self load];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)decoder {
    self = [super initWithCoder:decoder];
    if(self){
        [self load];
        
        self.topConnected = [decoder decodeBoolForKey:@"topConnected"];
        
        self.botConnected = [decoder decodeBoolForKey:@"botConnected"];
        
        self.topType = (TFDataType) [decoder decodeIntForKey:@"topType"];
        
        self.botType= (TFDataType) [decoder decodeIntForKey:@"botType"];
        
        self.firstType = (TFDataType) [decoder decodeIntForKey:@"firstType"];

        [self chooseSprite];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder {
    [super encodeWithCoder:coder];
    
    [coder encodeBool:self.topConnected forKey:@"topConnected"];
    
    [coder encodeBool:self.botConnected forKey:@"botConnected"];
    
    [coder encodeInt:[NSNumber numberWithInt:self.topType] forKey:@"topType"];
    
    [coder encodeInt:[NSNumber numberWithInt:self.botType] forKey:@"botType"];
    
    [coder encodeInt:[NSNumber numberWithInt:self.firstType] forKey:@"firstType"];
    
}

-(id)copyWithZone:(NSZone *)zone {
    THOutputEditable * copy = [super copyWithZone:zone];
    
    [copy load];
    
    return copy;
}


-(void) setOutput:(id) value {
    THOutput * obj = (THOutput*) self.simulableObject;
    [obj setOutput:value];
}

-(void) connectTop:(TFDataType)type {
    if (!self.topConnected && !self.botConnected) {
        THOutput * obj = (THOutput*) self.simulableObject;
        [obj setPropertyType:type];
        self.firstType = type;
    }
    self.topConnected = YES;
    self.topType = type;
    [self chooseSprite];
}

-(void) connectBot:(TFDataType)type {
    if (!self.topConnected && !self.botConnected) {
        THOutput * obj = (THOutput*) self.simulableObject;
        [obj setPropertyType:type];
        self.firstType = type;
    }
    self.botConnected = YES;
    self.botType = type;
    [self chooseSprite];
}

-(void) deleteTop {
    self.topConnected = NO;
    THOutput * obj = (THOutput*) self.simulableObject;
    if (self.botConnected) {
        [obj setPropertyType:self.botType];
    }
    else {
        [obj setPropertyType:kDataTypeAny];
    }
    [self chooseSprite];
}

-(void) deleteBot {
    self.botConnected = NO;
    THOutput * obj = (THOutput*) self.simulableObject;
    if (self.botConnected) {
        [obj setPropertyType:self.topType];
    }
    else {
        [obj setPropertyType:kDataTypeAny];
    }
    [self chooseSprite];
}

-(void) chooseSprite {
    [self.sprite removeFromParentAndCleanup:YES];
    self.sprite = [CCSprite spriteWithFile:@"outputEmpty.png"];
    if (self.topConnected && self.botConnected) {
        switch (self.firstType) {
            case kDataTypeAny:
                self.sprite = [CCSprite spriteWithFile:@"outputStarFilled.png"];
                break;
            case kDataTypeBoolean:
                self.sprite = [CCSprite spriteWithFile:@"outputCircleFilled.png"];
                break;
            case kDataTypeFloat:
            case kDataTypeInteger:
                self.sprite = [CCSprite spriteWithFile:@"outputSquareFilled.png"];
                break;
            case kDataTypeString:
                self.sprite = [CCSprite spriteWithFile:@"outputTriangleFilled.png"];
                break;
            default:
                break;
        }
    }
    else if (self.topConnected) {
        switch (self.topType) {
            case kDataTypeAny:
                self.sprite = [CCSprite spriteWithFile:@"outputStarFilledUpper.png"];
                break;
            case kDataTypeBoolean:
                self.sprite = [CCSprite spriteWithFile:@"outputCircleFilledUpper.png"];
                break;
            case kDataTypeFloat:
            case kDataTypeInteger:
                self.sprite = [CCSprite spriteWithFile:@"outputSquareFilledUpper.png"];
                break;
            case kDataTypeString:
                self.sprite = [CCSprite spriteWithFile:@"outputTriangleFilledUpper.png"];
                break;
            default:
                break;
        }
    }
    else if (self.botConnected) {
        switch (self.botType) {
            case kDataTypeAny:
                self.sprite = [CCSprite spriteWithFile:@"outputStarFilledLower.png"];
                break;
            case kDataTypeBoolean:
                self.sprite = [CCSprite spriteWithFile:@"outputCircleFilledLower.png"];
                break;
            case kDataTypeFloat:
            case kDataTypeInteger:
                self.sprite = [CCSprite spriteWithFile:@"outputSquareFilledLower.png"];
                break;
            case kDataTypeString:
                self.sprite = [CCSprite spriteWithFile:@"outputTriangleFilledLower.png"];
                break;
            default:
                break;
        }
    }
    [self addChild:self.sprite];
}

-(void) removeFromWorld{
    [super removeFromWorld];
    [self.attachedToGesture deattachOutput:self];
}

-(void) prepareToDie{
    [super prepareToDie];
}

-(id) value {
    THOutput * obj = (THOutput*) self.simulableObject;
    return obj.value;
}

-(NSString*) description{
    return @"Output";
}

@end
