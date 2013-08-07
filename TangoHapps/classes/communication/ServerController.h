
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "TransferAgent.h"

@class THServerController;
@class THClientProject;

@protocol THServerControllerDelegate <NSObject>
- (void)server:(THServerController*)controller peerConnected:(NSString*)peerName;
- (void)server:(THServerController*)controller peerDisconnected:(NSString*)peerName;
- (void)server:(THServerController*)controller isReadyForSceneTransfer:(BOOL)ready;
- (void)server:(THServerController*)controller isRunning:(BOOL)running;
- (void)server:(THServerController*)controller isTransferring:(BOOL)transferring;
@end

@interface ServerController : NSObject
<THTransferAgentDelegate, GKSessionDelegate> {
    GKSession *session;
    NSTimer * _transferTimer;
}

@property (weak) id<THServerControllerDelegate> delegate;
@property (readonly) BOOL serverIsRunning;

@property (nonatomic,strong) NSMutableDictionary * peers;
@property (nonatomic,strong) NSMutableDictionary * agents;

-(void)startServer;
-(void)stopServer;

-(void) pushProjectToAllClients:(THCustomProject*)project;
/*
-(void) startPushingLilypadStateToAllClients;
-(void) stopPushingLilypadState;*/

@end
