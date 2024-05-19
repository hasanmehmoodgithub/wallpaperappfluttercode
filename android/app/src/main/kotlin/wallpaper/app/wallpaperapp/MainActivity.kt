package wallpaper.app.wallpaperapp

import io.flutter.embedding.android.FlutterActivity

import android.os.Build

import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "getAndroidVersion"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getAndroidVersion") {
                result.success(Build.VERSION.RELEASE)
            } else {
                result.notImplemented()
            }
        }
    }
}