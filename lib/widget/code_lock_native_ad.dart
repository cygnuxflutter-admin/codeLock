import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:code_lock/services/ad_service.dart';

class CodeLockNativeAd extends StatefulWidget {
  final String factoryId;
  const CodeLockNativeAd({Key? key, this.factoryId = 'listNativeAd'}) : super(key: key);

  @override
  State<CodeLockNativeAd> createState() => _CodeLockNativeAdState();
}

class _CodeLockNativeAdState extends State<CodeLockNativeAd> {
  NativeAd? _nativeAd;
  bool _isLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  void _loadAd() {
    if (!AdService.to.isAdsEnabled || AdService.to.nativeAdUnitId.isEmpty) {
      return;
    }

    _nativeAd = NativeAd(
      adUnitId: AdService.to.nativeAdUnitId,
      factoryId: widget.factoryId,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          if (mounted) {
            setState(() {
              _isLoaded = true;
            });
          }
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          debugPrint('NativeAd failed to load: $error');
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoaded && _nativeAd != null) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        height: 110, // Adjusted height for native layout
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: AdWidget(ad: _nativeAd!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
