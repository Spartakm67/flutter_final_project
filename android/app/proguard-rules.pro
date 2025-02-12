# Збереження класів Android 13+
-keep class android.window.** { *; }

# Відключення мінімізації Firebase (якщо використовується)
-keep class com.google.firebase.** { *; }

# Збереження класів Flutter
-keep class io.flutter.** { *; }

# Уникнення помилок з reflection

# Збереження класів Android WebView API
-keep class android.webkit.** { *; }

# Збереження методів із анотацією @JavascriptInterface
-keepclassmembers class * {
    @android.webkit.JavascriptInterface *;
}

