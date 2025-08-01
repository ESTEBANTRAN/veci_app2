    plugins {
        id("com.android.application")
        // START: FlutterFire Configuration
        id("com.google.gms.google-services")
        // END: FlutterFire Configuration
        id("kotlin-android")
        // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
        id("dev.flutter.flutter-gradle-plugin")
    }

    android {
        namespace = "com.example.veci_app"
        compileSdk = flutter.compileSdkVersion
        ndkVersion = "27.0.12077973"

        compileOptions {
            sourceCompatibility = org.gradle.api.JavaVersion.VERSION_1_8 // Corrected line
            targetCompatibility = org.gradle.api.JavaVersion.VERSION_1_8 // Corrected line
        }

        kotlinOptions {
            jvmTarget = org.gradle.api.JavaVersion.VERSION_1_8.toString() // Corrected line
        }

        defaultConfig {
            // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
            applicationId = "com.example.veci_app"
            // You can update the following values to match your application needs.
            // For more information, see: https://flutter.dev/to/review-gradle-config.
            minSdk = 23
            targetSdk = flutter.targetSdkVersion
            versionCode = flutter.versionCode
            versionName = flutter.versionName
        }

        buildTypes {
            release {
                // TODO: Add your own signing config for the release build.
                // Signing with the debug keys for now, so `flutter run --release` works.
                signingConfig = signingConfigs.getByName("debug")
            }
        }
    }

    flutter {
        source = "../.."
    }