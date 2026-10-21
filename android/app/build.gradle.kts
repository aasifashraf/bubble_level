import java.io.FileInputStream
import java.util.Properties

// The upload key, from android/key.properties (never committed; see
// play_store_guide.md).
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

// A Play upload (app bundle) must never be signed with the debug key.
if (!keystorePropertiesFile.exists() &&
    gradle.startParameter.taskNames.any { it.contains("bundle", ignoreCase = true) }
) {
    throw GradleException(
        "android/key.properties is missing: an app bundle for Google Play must be signed " +
            "with the upload key. See play_store_guide.md, \"Point the build at the key\".",
    )
}

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "dev.aasifashraf.bubble_level"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "dev.aasifashraf.bubblelevel"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // Two builds of the same app (flutter build ... --flavor play|foss):
    // Google Play's, with its review card, and the free software one for
    // F-Droid, IzzyOnDroid and GitHub, with no Google libraries.
    flavorDimensions += "store"
    productFlavors {
        create("play") { dimension = "store" }
        create("foss") { dimension = "store" }
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
            // The upload key when android/key.properties exists. Without it,
            // the debug key, so test APKs still build (bundles are refused
            // above).
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

dependencies {
    // Location (Gps.kt) through Android's own LocationManager.
    implementation("androidx.core:core:1.16.0")
    "playImplementation"("com.google.android.play:review:2.0.2")
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
