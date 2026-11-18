import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class AdService extends GetxService with WidgetsBindingObserver {
  static AdService get to => Get.find();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final isConfigReady = false.obs;

  // Remote Config Keys
  static const String _keyIsAdsEnabledAndroid = 'is_ads_enabled_android';
  static const String _keyIsAdsEnabledIOS = 'is_ads_enabled_ios';
  static const String _keyAndroidBannerId = 'android_banner_id';
  static const String _keyIOSBannerId = 'ios_banner_id';
  static const String _keyAndroidInterstitialId = 'android_interstitial_id';
  static const String _keyIOSInterstitialId = 'ios_interstitial_id';
  static const String _keyAndroidAppOpenId = 'android_app_open_id';
  static const String _keyIOSAppOpenId = 'ios_app_open_id';
  static const String _keyAndroidNativeId = 'android_native_id';
  static const String _keyIOSNativeId = 'ios_native_id';

  // Global flag to enable/disable ads from Remote Config based on platform
  bool get isAdsEnabled {
    if (!isConfigReady.value) return false;
    if (Platform.isAndroid) {
      return _remoteConfig.getBool(_keyIsAdsEnabledAndroid);
    } else {
      return _remoteConfig.getBool(_keyIsAdsEnabledIOS);
    }
  }

  AppOpenAd? _appOpenAd;
  InterstitialAd? _interstitialAd;
  bool _isShowingAd = false;
  DateTime? _appOpenAdLoadTime;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _initRemoteConfig();
  }

  Future<void> _initRemoteConfig() async {
    try {
      await _remoteConfig.setDefaults({
        _keyIsAdsEnabledAndroid: false,
        _keyIsAdsEnabledIOS: false,
        _keyAndroidBannerId: '',
        _keyIOSBannerId: '',
        _keyAndroidInterstitialId: '',
        _keyIOSInterstitialId: '',
        _keyAndroidAppOpenId: '',
        _keyIOSAppOpenId: '',
        _keyAndroidNativeId: '',
        _keyIOSNativeId: '',
      });
      
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 15),
        minimumFetchInterval: Duration.zero,
      ));
      
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      debugPrint('[AD_SERVICE] Remote Config Fetch Error: $e');
    } finally {
      isConfigReady.value = true;
      if (isAdsEnabled) {
        loadAppOpenAd();
        loadInterstitialAd();
      }
    }
  }

  // Ad Unit IDs from Remote Config based on Platform
  String get bannerAdUnitId {
    return Platform.isAndroid 
        ? _remoteConfig.getString(_keyAndroidBannerId).trim() 
        : _remoteConfig.getString(_keyIOSBannerId).trim();
  }

  String get interstitialAdUnitId {
    return Platform.isAndroid 
        ? _remoteConfig.getString(_keyAndroidInterstitialId).trim() 
        : _remoteConfig.getString(_keyIOSInterstitialId).trim();
  }

  String get appOpenAdUnitId {
    return Platform.isAndroid 
        ? _remoteConfig.getString(_keyAndroidAppOpenId).trim() 
        : _remoteConfig.getString(_keyIOSAppOpenId).trim();
  }

  String get nativeAdUnitId {
    return Platform.isAndroid 
        ? _remoteConfig.getString(_keyAndroidNativeId).trim() 
        : _remoteConfig.getString(_keyIOSNativeId).trim();
  }

  /// Load App Open Ad
  void loadAppOpenAd() {
    debugPrint('[AD_SERVICE] isAdsEnabled: $isAdsEnabled, appOpenAdUnitId: "$appOpenAdUnitId"');
    if (!isAdsEnabled || appOpenAdUnitId.isEmpty) return;
    
    debugPrint('[AD_SERVICE] Loading App Open Ad with ID: $appOpenAdUnitId');
    AppOpenAd.load(
      adUnitId: appOpenAdUnitId,
      orientation: AppOpenAd.orientationPortrait,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('[AD_SERVICE] App Open Ad LOADED successfully!');
          _appOpenAdLoadTime = DateTime.now();
          _appOpenAd = ad;
        },
        onAdFailedToLoad: (error) {
          debugPrint('[AD_SERVICE] AppOpenAd failed to load: $error');
        },
      ),
    );
  }

  DateTime? _lastAppOpenAdTime;

  /// Show App Open Ad
  void showAppOpenAdIfAvailable() {
    if (!isAdsEnabled || _isShowingAd || _appOpenAd == null) return;

    // 2-Minute Time Limit (Frequency Cap)
    if (_lastAppOpenAdTime != null) {
      final difference = DateTime.now().difference(_lastAppOpenAdTime!);
      if (difference.inMinutes < 2) {
        debugPrint('[AD_SERVICE] App Open Ad skipped. (Cool-down: ${2 - difference.inMinutes} mins left)');
        return; // Skip showing ad if less than 2 minutes have passed
      }
    }

    if (DateTime.now().difference(_appOpenAdLoadTime!).inHours >= 4) {
      _appOpenAd!.dispose();
      _appOpenAd = null;
      loadAppOpenAd();
      return;
    }

    _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        _lastAppOpenAdTime = DateTime.now(); // Record the time the ad was shown
      },
      onAdDismissedFullScreenContent: (ad) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        _isShowingAd = false;
        ad.dispose();
        _appOpenAd = null;
        loadAppOpenAd();
      },
    );
    _appOpenAd!.show();
  }

  /// Load Interstitial Ad
  void loadInterstitialAd() {
    if (!isAdsEnabled || interstitialAdUnitId.isEmpty) return;

    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => _interstitialAd = ad,
        onAdFailedToLoad: (error) => _interstitialAd = null,
      ),
    );
  }

  int _interstitialClickCount = 0;

  /// Show Interstitial Ad
  void showInterstitialAd() {
    if (!isAdsEnabled) return;

    _interstitialClickCount++;
    if (_interstitialClickCount < 3) {
      return; // Skip showing ad on 1st and 2nd save
    }

    // Reset counter for next time
    _interstitialClickCount = 0;

    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        loadInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        loadInterstitialAd();
      },
    );
    _interstitialAd!.show();
  }

  bool wasInBackground = true; // Default true so cold start shows ad

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      wasInBackground = true;
    }
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    _appOpenAd?.dispose();
    _interstitialAd?.dispose();
    super.onClose();
  }
}
