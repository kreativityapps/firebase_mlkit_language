#import "FirebaseMlkitLanguagePlugin.h"

@import FirebaseMLCommon;

@implementation DownloadModel

+ (void)handleEvent:(NSString *)text result:(FlutterResult)result {
  FIRTranslateLanguage modelName = FIRTranslateLanguageForLanguageCode(text);

  FIRTranslateRemoteModel *modelToDownload = [FIRTranslateRemoteModel translateRemoteModelWithLanguage:modelName];

  if ([[FIRModelManager modelManager] isModelDownloaded:modelToDownload]) {
    result(@"Already Downloaded");
  } else {
   // todo nsprogressをうまく使いたい
     FIRModelDownloadConditions *conditions =
     [[FIRModelDownloadConditions alloc] initWithAllowsCellularAccess:YES
                                              allowsBackgroundDownloading:YES];
    [[FIRModelManager modelManager] downloadModel:modelToDownload conditions:conditions];
    result(@"Downloaded");
  }
}
@end