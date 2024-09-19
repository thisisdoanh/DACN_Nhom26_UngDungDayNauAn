package com.cook.food.tutorial

import android.os.Build
import android.os.Bundle
import android.os.PersistableBundle
import android.window.SplashScreenView
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen.setOnExitAnimationListener { splashScreenView: SplashScreenView -> splashScreenView.remove() }
        }
    }
}
