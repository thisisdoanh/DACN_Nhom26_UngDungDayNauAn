package com.cook.food.tutorial

import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.window.SplashScreenView
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterFragmentActivity;

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        WindowCompat.setDecorFitsSystemWindows(window, false)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { splashScreenView: SplashScreenView -> splashScreenView.remove() }
        }
        super.onCreate(savedInstanceState)
    }
}
