//
//  MKSPPDFUModel.m
//  MKScannerPro_Example
//
//  Created by aa on 2021/12/8.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKSPPDFUModel.h"

#import "MKMacroDefines.h"

#import "MKSPCentralManager.h"

@import iOSDFULibrary;

static NSString *const dfuUpdateDomain = @"com.moko.dfuUpdateDomain";

@interface MKSPPDFUModel()<LoggerDelegate,
DFUServiceDelegate,
DFUProgressDelegate,
mk_sp_centralManagerScanDelegate>

@property (nonatomic, copy)void (^progressBlock)(CGFloat progress);

@property (nonatomic, copy)void (^updateSucBlock)(void);

@property (nonatomic, copy)void (^updateFailedBlock)(NSError *error);

@property (nonatomic, strong)DFUServiceController *dfuController;

@property (nonatomic, copy)NSString *filePath;

@property (nonatomic, copy)NSString *macAddress;

@property (nonatomic, strong)dispatch_source_t scanTimer;

@property (nonatomic, assign)NSInteger timerCount;

@property (nonatomic, assign)BOOL timeout;

@end

@implementation MKSPPDFUModel

- (void)dealloc{
    NSLog(@"MKSPPDFUModel销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.scanTimer) {
        dispatch_cancel(self.scanTimer);
    }
}

#pragma mark - DFUServiceDelegate

- (void)updateWithFileName:(NSString *)fileName
               macAddress:(NSString *)macAddress
            progressBlock:(void (^)(CGFloat progress))progressBlock
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!ValidStr(fileName)) {
        [self operationFailedBlock:failedBlock msg:@"The url is invalid!"];
        return;
    }
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    self.filePath = [document stringByAppendingPathComponent:fileName];
    
    if (!ValidStr(macAddress)) {
        [self operationFailedBlock:failedBlock msg:@"The macAddress is invalid!"];
        return;
    }
    
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@"-" withString:@""];
    macAddress = [macAddress stringByReplacingOccurrencesOfString:@":" withString:@""];
    self.macAddress = [macAddress lowercaseString];
    self.progressBlock = nil;
    self.progressBlock = progressBlock;
    self.updateSucBlock = nil;
    self.updateSucBlock = sucBlock;
    self.updateFailedBlock = nil;
    self.updateFailedBlock = failedBlock;
    
    [MKSPCentralManager shared].delegate = self;
    [self scanTimerRun];
}

#pragma mark -
- (void)dfuStateDidChangeTo:(enum DFUState)state{
    //升级完成
    if (state==DFUStateCompleted) {
        moko_dispatch_main_safe(^{
            if (self.updateSucBlock) {
                self.updateSucBlock();
            }
        });
    }
    if (state == DFUStateUploading) {
        [MKSPCentralManager sharedDealloc];
    }
}

- (void)dfuError:(enum DFUError)error didOccurWithMessage:(NSString *)message{
    [self operationFailedBlock:self.updateFailedBlock msg:message];
}

#pragma mark - DFUProgressDelegate
- (void)dfuProgressDidChangeFor:(NSInteger)part outOf:(NSInteger)totalParts to:(NSInteger)progress currentSpeedBytesPerSecond:(double)currentSpeedBytesPerSecond avgSpeedBytesPerSecond:(double)avgSpeedBytesPerSecond{
    float currentProgress = (float) progress /totalParts;
    moko_dispatch_main_safe(^{
        if (self.progressBlock) {
            self.progressBlock(currentProgress);
        }
    });
}

#pragma mark - LoggerDelegate
- (void)logWith:(enum LogLevel)level message:(NSString *)message{
    NSLog(@"%logWith ld: %@", (long) level, message);
}

#pragma mark - mk_sp_centralManagerScanDelegate
/// Scan to new device.
/// @param deviceModel device
- (void)mk_sp_receiveDevice:(NSDictionary *)deviceModel {
    if (!ValidDict(deviceModel) || self.timeout) {
        return;
    }
    NSString *mac = [deviceModel[@"macAddress"] stringByReplacingOccurrencesOfString:@":" withString:@""];
    mac = [mac lowercaseString];
    if (![mac isEqualToString:self.macAddress]) {
        return;
    }
    //目标设备，开启升级
    NSData *zipData = [NSData dataWithContentsOfFile:self.filePath];
    if (!ValidData(zipData)) {
        [self operationFailedBlock:self.updateFailedBlock msg:@"Dfu upgrade failure!"];
        return;
    }
    DFUFirmware *selectedFirmware = [[DFUFirmware alloc] initWithZipFile:zipData];// or
    //Use the DFUServiceInitializer to initialize the DFU process.
    if (!selectedFirmware) {
        [self operationFailedBlock:self.updateFailedBlock msg:@"Dfu upgrade failure!"];
        return;
    }
    if (self.scanTimer) {
        dispatch_cancel(self.scanTimer);
    }
    self.timeout = NO;
    DFUServiceInitiator *initiator = [[DFUServiceInitiator alloc] initWithQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) progressQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0) loggerQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    initiator = [initiator withFirmware:selectedFirmware];
    initiator.logger = self; // - to get log info
    initiator.delegate = self; // - to be informed about current state and errors
    initiator.progressDelegate = self; // - to show progress bar
    
    self.dfuController = [initiator startWithTarget:deviceModel[@"peripheral"]];
}

#pragma mark - private method

- (void)scanTimerRun{
    [[MKSPCentralManager shared] startScan];
    self.scanTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_global_queue(0, 0));
    //开始时间
    dispatch_source_set_timer(self.scanTimer, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0);
    @weakify(self);
    dispatch_source_set_event_handler(self.scanTimer, ^{
        @strongify(self);
        self.timerCount ++;
        if (self.timerCount == 180) {
            [[MKSPCentralManager shared] stopScan];
            if (self.scanTimer) {
                dispatch_cancel(self.scanTimer);
            }
            self.timeout = YES;
            [self operationFailedBlock:self.updateFailedBlock msg:@"DFU Failed"];
        }
    });
    dispatch_resume(self.scanTimer);
}

- (void)operationFailedBlock:(void (^)(NSError *error))failedBlock msg:(NSString *)msg {
    moko_dispatch_main_safe(^{
        if (failedBlock) {
            NSError *error = [[NSError alloc] initWithDomain:dfuUpdateDomain
                                                        code:-999
                                                    userInfo:@{@"errorInfo":SafeStr(msg)}];
            failedBlock(error);
        }
    });
}

@end
