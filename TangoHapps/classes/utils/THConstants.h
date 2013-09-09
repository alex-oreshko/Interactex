
#import <Foundation/Foundation.h>

#define PTM_RATIO 32.0f

#define BACKGROUND_Z -1
#define PALETTE_ITEM_Z 1

#define OBJECT_Z 3
#define JOINT_Z 6
#define REMOVE_OBJ_IMG_Z 7
#define ADD_OBJ_IMG_Z 7
#define RED_DOT_Z 10
#define MOVE_TARGET_Z 15

#define PALETTE_RECTANGLE 0
#define PALETTE_CIRCLE 1

#define PALETTE_X_MARGIN 4
#define PALETTE_Y_MARGIN 4

#define PALETTE_LABEL_HEIGHT 14

#define SIDEBAR_WIDTH 250
#define SIDEBAR_PADDING 8
#define INIT_OBJECT_SIZE 40

#define OBJ_ACCELERATION 100000

#define THUMBNAIL_WIDTH 75
#define THUMBNAIL_HEIGHT 75
#define THUMBNAIL_MARGIN 10

#define MIN_DRAGGED_DISTANCE 150

#define TAB_ALPHA 1.0f

#define MIN_SHAPE_SIZE 5
#define MAX_SHAPE_SIZE 150

#define MIN_SCALE 1.0
#define MAX_SCALE 2.0

#define PALETTE_ITEMS_PADDING 8
#define PALETTE_ITEMS_SIZE 64
#define DRAGGED_IMAGE_SHIFT 40

#define FINGER_LENGTH 25

#define ROPE_NUM_PARTS 10

#define ROPE_HEIGHT 16
#define ROPE_WIDTH 8

#define MAX_PALETTE_IMAGE_SIZE 85
#define MIN_PALETTE_IMAGE_SIZE 44

#define SPRITE_OPACITY_EDITOR_ACTIVE 180
#define SPRITE_OPACITY_EDITOR_INACTIVE 100
#define SPRITE_OPACITY_SIMULATOR 255
#define BACKGROUND_OPACITY 60

#define VELOCITY_ITERATIONS 10
#define POSITION_ITERATIONS 10

#define SWITCH_TIME 2.0f
#define REMOVE_CUTTED_ROPE_TIME 1.5f

#define INITIAL_TRIGGER_AREA 100

enum zPositions{
    kLilypadZ = -25,
    kClotheZ = -20,
    kiPhoneZ = -15,
    kClotheObjectZ = -10,
    kValueZ = -9,
    kConditionZ = -8,
    kNormalObjectZ = -7,
    kSelectedObjectZ = -4,
    kSelectionSpriteZ = 2
};

//#define ARC4RANDOM_MAX      0x10000000
#define ARC4RANDOM_MAX 0xFFFFFFFFu

extern NSString * const kNotificationPropertyValueChanged;
extern NSString * const kNotificationSimulationStarted;
extern NSString * const kNotificationSimulationEnded;

extern NSString * const kNotificationPropertiesChanged;


extern float const kWifiCellHeightCollapsed;
extern float const kWifiCellHeightExtended;

extern CGPoint const kiPhoneImageDistanceViewTopLeftToCenter;

extern float const kLilypadPinRadius;

extern CGPoint const kLilypadDefaultPosition;

extern NSString * const kPaletteNameClothes;
extern NSString * const kPaletteNameSoftware;
extern NSString * const kPaletteNameHardware;
extern NSString * const kPaletteNameTriggers;


extern CGPoint const kPinPositions[kNumHardwareTypes][kMaxNumPinsPerElement];


extern float const kUiViewOpacityEditor;

typedef enum {
    kImageViewScaleModeFit,
    kImageViewScaleModeFill
} THImageViewScaleMode;


NSString * kNotifyBehaviorsText[kMaxNumNotifyBehaviors];

extern NSInteger const kCompassMin;
extern NSInteger const kAnalogInMin;

extern NSString * kSimulatorDefaultFont;
extern CGSize const kDefaultViewMinSize;
extern CGSize const kDefaultViewMaxSize;

extern ccColor3B const kMinusPinColor;
extern ccColor3B const kPlusPinColor;
extern ccColor3B const kOtherPinColor;

extern ccColor4B const kMinusPinHighlightColor;
extern ccColor4B const kPlusPinHighlightColor;
extern ccColor4B const kDefaultPinHighlightColor;

extern ccColor3B const kWireDefaultColor;
extern ccColor3B const kWireDefaultHighlightColor;

extern float const kWireNodeRadius;
extern ccColor3B const kWireNodeColor;

extern CGSize const kDefaultPinSize;
extern CGSize const kiPhoneButtonDefaultSize;

extern CGPoint const kDefaultiPhonePosition;

extern CGPoint const kSewedPositions[kNumHardwareTypes];


extern float const kLayerMinScale;
extern float const kLayerMaxScale;
