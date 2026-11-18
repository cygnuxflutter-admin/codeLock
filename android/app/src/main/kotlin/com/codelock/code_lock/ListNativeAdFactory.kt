package com.codelock.code_lock

import android.content.Context
import android.view.LayoutInflater
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class ListNativeAdFactory(val context: Context) : NativeAdFactory {
    override fun createNativeAd(
        nativeAd: NativeAd,
        customOptions: MutableMap<String, Any>?
    ): NativeAdView {
        val nativeAdView = LayoutInflater.from(context)
            .inflate(R.layout.list_native_ad, null) as NativeAdView

        with(nativeAdView) {
            val headlineView = findViewById<TextView>(R.id.ad_headline)
            val bodyView = findViewById<TextView>(R.id.ad_body)
            val callToActionView = findViewById<Button>(R.id.ad_call_to_action)
            val iconView = findViewById<ImageView>(R.id.ad_icon)

            headlineView.text = nativeAd.headline
            this.headlineView = headlineView

            if (nativeAd.body == null) {
                bodyView.visibility = android.view.View.INVISIBLE
            } else {
                bodyView.visibility = android.view.View.VISIBLE
                bodyView.text = nativeAd.body
            }
            this.bodyView = bodyView

            if (nativeAd.callToAction == null) {
                callToActionView.visibility = android.view.View.INVISIBLE
            } else {
                callToActionView.visibility = android.view.View.VISIBLE
                callToActionView.text = nativeAd.callToAction
            }
            this.callToActionView = callToActionView

            if (nativeAd.icon == null) {
                iconView.visibility = android.view.View.GONE
            } else {
                iconView.setImageDrawable(nativeAd.icon?.drawable)
                iconView.visibility = android.view.View.VISIBLE
            }
            this.iconView = iconView

            setNativeAd(nativeAd)
        }

        return nativeAdView
    }
}
