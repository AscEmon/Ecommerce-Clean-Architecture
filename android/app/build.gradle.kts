plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Base64
import java.util.Properties
import java.io.FileInputStream

// Load key.properties for signing configuration
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// Dart environment variables setup
val dartEnvironmentVariables = mutableMapOf<String, String>()

if (project.hasProperty("dart-defines")) {
    val dartDefines = project.property("dart-defines") as String
    dartDefines.split(",").forEach { entry ->
        val pair = String(Base64.getDecoder().decode(entry)).split("=")
        if (pair.size == 2) {
            dartEnvironmentVariables[pair[0]] = pair[1]
            if (pair[0] == "flavorType") {
                project.extra["APP_FLAVOR"] = pair[1]
            }
        }
    }
}

fun getAppFlavor(): String {
    return if (project.extra.has("APP_FLAVOR")) {
        "${project.extra["APP_FLAVOR"]}_"
    } else {
        ""
    }
}


android {
    namespace = "com.example.ecommerce"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ecommerce"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String?
            keyPassword = keystoreProperties["keyPassword"] as String?
            storeFile = keystoreProperties["storeFile"]?.let { file(it) }
            storePassword = keystoreProperties["storePassword"] as String?
        }
    }


    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            // Use release signing config if key.properties exists, otherwise use debug
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
}

// Copy and rename APK based on flavor after build
gradle.buildFinished {
    val flavor = getAppFlavor()
    if (flavor.isNotEmpty()) {
        val flutterApkDir = File("${project.buildDir}/outputs/flutter-apk")
        val apkOutputDir = File("${project.buildDir}/outputs/apk")
        
        listOf(flutterApkDir, apkOutputDir).forEach { dir ->
            if (dir.exists()) {
                dir.walk().forEach { file ->
                    if (file.isFile && file.extension == "apk" && !file.name.contains("_${flavor}")) {
                        val appName = android.namespace?.substringAfterLast(".") ?: "app"
                        val versionName = android.defaultConfig.versionName ?: "1.0.0"
                        val versionCode = android.defaultConfig.versionCode ?: 1
                        val newName = "${appName}_${flavor}${versionName}(${versionCode}).apk"
                        val newFile = File(file.parent, newName)
                        file.copyTo(newFile, overwrite = true)
                    }
                }
            }
        }
    }
}
}

flutter {
    source = "../.."
}