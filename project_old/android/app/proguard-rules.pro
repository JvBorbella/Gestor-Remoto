# Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class androidx.core.app.NotificationCompat { *; }

# Flutter
-keep class io.flutter.plugins.firebase.messaging.** { *; }
-keep class io.flutter.plugins.firebase.** { *; }

# Evita remoção de classes relacionadas a JSON
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class com.fasterxml.jackson.** { *; }

# Preserva todas as classes do WorkManager usadas pelo Flutter
-keep class com.transistorsoft.flutter.backgroundfetch.** { *; }
-keep class io.flutter.embedding.** { *; }

# Mantém as classes usadas pelo Flutter no modo release
-keepattributes *Annotation*

# Mantém métodos anotados com a anotação usada no Flutter
-keep class * {
    @androidx.annotation.Keep *;
}
