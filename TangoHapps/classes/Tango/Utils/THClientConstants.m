/*
THClientConstants.m
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

#import "THClientConstants.h"



NSString* const dataTypeStrings[kNumDataTypes] = {@"boolean",@"integer", @"float",@"string", @"*"};

NSInteger const kLilypadPwmPins[kLilypadNumPwmPins] = {3,5,6,9,10,11};


//CGRect const kiPhoneFrames[kNumiPhoneTypes] = {{26,99,270,404},{26,99,270,481}}; // nazmus commented
//CGRect const kiPhoneFrames[kNumiPhoneTypes] = {{26,99,180,268},{26,99,180,300}}; // nazmus added, then commented
CGRect const kiPhoneFrames[kNumiPhoneTypes] = {{26,90,262,394},{26,99,262,470}}; // nazmus 24 sep 14 added - iphone4 is used by default
float const kiphoneFrameXMargin = 23;
float const kiphoneFrameYMargin = 120;

//notifications
NSString * const kNotificationLedOn = @"notificationLedOn";
NSString * const kNotificationLedOff = @"notificationLedOff";

NSString * const kNotificationBuzzerOn = @"notificationBuzzerOn";
NSString * const kNotificationBuzzerOff = @"notificationBuzzerOff";

NSString * const kNotificationBuzzerFrequencyChanged = @"notificationBuzzerFrequencyChanged";
NSString * const kNotificationLedIntensityChanged = @"notificationLedIntensityChanged";

NSString * const kNotificationSwitchOn = @"switchedOn";
NSString * const kNotificationSwitchOff = @"switchedOff";
NSString * const kNotificationSwitchChanged = @"switchChanged";

NSString * const kNotificationLilypadObjectAdded = @"notificationLilypadObjectAdded";
NSString * const kNotificationLilypadObjectRemoved = @"notificationLilypadObjectRemoved";

NSString * const kNotificationLilypadAdded = @"notificationLilypadAdded";
NSString * const kNotificationLilypadRemoved = @"notificationLilypadRemoved";

NSString * const kNotificationPinAttached = @"notificationPinAttached";
NSString * const kNotificationPinDeattached = @"notificationPinDeattached";
NSString * const kNotificationPinValueChanged = @"notificationPinValueChanged";


//events
NSString * const kEventTurnedOn = @"turnedOn";
NSString * const kEventTurnedOff = @"turnedOff";
NSString * const kEventOnChanged = @"onChanged";
NSString * const kEventSwitchedOn = @"switchOn";
NSString * const kEventSwitchedOff = @"switchOff";
NSString * const kEventIntensityChanged = @"intensityChanged";
NSString * const kEventFrequencyChanged = @"frequencyChanged";
NSString * const kEventValueChanged = @"valueChanged";
NSString * const kEventDeviationChanged = @"deviationChanged";
NSString * const kEventMeanChanged = @"meanChanged";
NSString * const kEventOperationFinished = @"operationFinished";
NSString * const kEventComparisonFinished = @"comparisonFinished";
NSString * const kEventPeakDetected = @"peakDetected";
NSString * const kEventFiltered = @"filtered";

NSString * const kEventStanding = @"standing";
NSString * const kEventWalking = @"walking";
NSString * const kEventRunning = @"running";
NSString * const kEventUnconscious = @"unconscious";
NSString * const kEventActivityChanged = @"activityChanged";

NSString * const kEventLyingDownOnStomach = @"onStomach";
NSString * const kEventLyingDownOnBack = @"onBack";

NSString * const kEventExecutionFinished = @"executionFinished";
NSString * const kEventRecordingFinished = @"recordingFinished";

NSString * const kEventMapperValueChanged = @"mapperValueChanged";
NSString * const kEventDxChanged = @"dxChanged";
NSString * const kEventDyChanged = @"dyChanged";
NSString * const kEventLightChanged = @"lightChanged";
NSString * const kEventStartedPressing = @"startedPressing";//this is for the hardware button
NSString * const kEventStoppedPressing = @"stoppedPressing";
NSString * const kEventButtonDown = @"buttonDown";//this is for the iOS button
NSString * const kEventButtonUp = @"buttonUp";
NSString * const kEventProximityChanged = @"proximityChanged";

NSString * const kEventConditionIsTrue = @"conditionTrue";
NSString * const kEventConditionIsFalse = @"conditionFalse";
NSString * const kEventConditionChanged = @"conditionChanged";
NSString * const kEventXChanged = @"xChanged";
NSString * const kEventYChanged = @"yChanged";
NSString * const kEventZChanged = @"zChanged";
//NSString * const kEventAccelerometerChanged = @"accelerometerChanged";
NSString * const kEventNewValue = @"newValue";

NSString * const kEventCalling = @"calling";

NSString * const kEventTapped = @"tapped";
NSString * const kEventDoubleTapped = @"doubleTapped";
NSString * const kEventScaleChanged = @"scaled";
NSString * const kEventLongPressed = @"longPressed";

NSString * const kEventHeadingChanged = @"eventHeadingChanged";

NSString * const kEventColorChanged = @"eventColorChanged";

NSString * const kEventTriggered = @"triggered";

NSString * const KEventiBeaconRegionEntered = @"iBeaconRegionEntered";
NSString * const KEventiBeaconRegionExited = @"iBeaconRegionExited";
NSString * const KEventiBeaconRangingStatusChanged = @"iBeaconRangingStatusChanged";
NSString * const kEventPressureChanged = @"pressureChanged";

NSString * const kEventNameStopped = @"stopped";

NSString * const kEventWindowFull = @"windowFull";
//methods


NSString * const kMethodSetIntensity = @"setIntensity";
NSString * const kMethodVaryIntensity = @"varyIntensity";
NSString * const kMethodTurnOn = @"turnOn";
NSString * const kMethodTurnOff = @"turnOff";
NSString * const kMethodSetValue1 = @"setValue1";
NSString * const kMethodSetValue2 = @"setValue2";
NSString * const kMethodAddValue1 = @"addValue1";
NSString * const kMethodAddValue2 = @"addValue2";

NSString * const kMethodSetRed = @"setRed";
NSString * const kMethodSetGreen = @"setGreen";
NSString * const kMethodSetBlue = @"setBlue";

NSString * const kMethodSetText = @"setText";


NSString * const kGameKitSessionId = @"tangoSession";

NSString* const kPinTexts[kNumPinTypes] = {@"D", @"A", @"-", @"+"};
NSString * const kElementPinTexts[kNumElementPinTypes] = {@"D", @"A", @"+", @"-", @"SCL", @"SDA"};
NSString* const kPinModeTexts[kNumPinModes] = {@"D In", @"D Out",@"A In",@"PWM", @"Buzzer", @"Compass", @"Undefined"};


NSString * const kPaletteItemsDirectory = @"paletteItems";
NSString * const kProjectsDirectory = @"projects";
NSString * const kPresetsDirectory = @"presets";

NSString * const kProjectImagesDirectory = @"projectImages";
NSString * const kProjectProxiesFileName = @"projectProxies";
NSString * const kCustomComponentsFileName = @"customComponents";

float const kMaxAnalogValue = 1023;

float const kGraphViewGraphOffsetY = 5.0f;
CGSize const kGraphViewAxisLabelSize = {36.0f, 16.0f};
float const kGraphViewAxisLineWidth = 1.0f;


NSString * const kConnectionServiceType = @"th-service";
NSString * const kTextITConnectionServiceType = @"textit-service";


const float kShakingEffectAngleInRadians = 2.0f;
const float kShakingEffectRotationTime = 0.10f;
const float kProjectCellScaleEffectDuration = 0.5;

const NSInteger kProjectNameMaxCharacters = 25;

CGSize const kDefaultLabelSize = {100,50};
CGSize const kDefaultButtonSize = {100,50};//30
CGSize const kDefaultSwitchSize = {55,40};//51,31
CGSize const kDefaultSliderSize = {150,40};//30
CGSize const kDefaultTouchpadSize = {260,200};
CGSize const KDefaultMusicPlayerSize = {260,205};
CGSize const kDefaultImageViewSize = {200,200};
CGSize const kDefaultContactBookSize = {260,140};
CGSize const kDefaultGraphSize = {260,130};

NSString * const kDefaultBoldFontName = @"Helvetica-Bold";
NSString * const kDefaultFontName = @"Helvetica";
float const kDefaultFontSize = 16;

