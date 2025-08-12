#import "RNPasswordless.h"
#import "RNPasswordless-Swift.h"

@implementation RNPasswordless
RCT_EXPORT_MODULE()

RNPasswordless *nativePasswordless =
[[RNPasswordless alloc] init];

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeRNPasswordlessSpecJSI>(params);
}

- (void)configure:(JS::NativeRNPasswordless::IPasswordlessOptions &)options { 
  return [nativePasswordless configure:options];
}

- (void)register:(nonnull NSString *)token nickname:(nonnull NSString *)nickname resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject { 
  return [nativePasswordless register:token nickname:nickname resolve:resolve reject:reject];
}

- (void)signIn:(nonnull NSString *)alias resolve:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject { 
  return [nativePasswordless signIn:alias resolve:resolve reject:reject];
}

- (void)signInWithAutofill:(nonnull RCTPromiseResolveBlock)resolve reject:(nonnull RCTPromiseRejectBlock)reject { 
  return [nativePasswordless signInWithAutofill:resolve reject:reject];
}

@end
