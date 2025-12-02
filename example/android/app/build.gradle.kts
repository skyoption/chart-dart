plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
}

import java.util.Properties

val localPropertiesFile = rootProject.file("local.properties")
val localProperties = Properties()
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use { localProperties.load(it) }
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

val keystorePropertiesFile = rootProject.file("keystore.properties")
val keystoreProperties = Properties()

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(keystorePropertiesFile.inputStream())
}

android {
    namespace = "com.example.chart"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main").java.srcDirs("src/main/kotlin")
    }


    defaultConfig {
        applicationId = "com.example.chart"
        minSdk = 26
        multiDexEnabled = true
        targetSdk = flutter.targetSdkVersion
        versionCode = flutterVersionCode
        versionName = flutterVersionName
        
        // Support for 16 KB page sizes (Android 15 compatibility)
        // Exclude ARMv7 due to ObjectBox alignment issues - 64-bit architectures are sufficient
        ndk {
            abiFilters += listOf("arm64-v8a", "x86_64")
        }
        
        // Configure 16KB ELF alignment for NDK r27
        externalNativeBuild {
            cmake {
                arguments += "-DANDROID_SUPPORT_FLEXIBLE_PAGE_SIZES=ON"
            }
        }
    }

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        getByName("debug") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("debug")
            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }

        getByName("release") {
            isMinifyEnabled = true
            isShrinkResources = true
            signingConfig = signingConfigs.getByName("release")
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }

    buildFeatures {
        dataBinding = true
        viewBinding = true
    }

    lint {
        abortOnError = false
        checkReleaseBuilds = false
        disable.addAll(listOf("InvalidPackage", "Instantiatable"))
    }

    packagingOptions {
        pickFirsts += listOf("**/libc++_shared.so", "**/libjsc.so")
        
        // Ensure uncompressed native libraries for 16KB alignment
        jniLibs {
            useLegacyPackaging = false
        }
        
        // Exclude problematic ObjectBox libraries for 32-bit architectures
        // This is a temporary workaround until ObjectBox releases 16KB-aligned versions
        excludes += listOf(
            "lib/armeabi-v7a/libobjectbox-jni.so",
            "lib/x86/libobjectbox-jni.so"
        )
    }

    configurations.all {
        resolutionStrategy {
            force("androidx.core:core:1.13.1")
            force("androidx.core:core-ktx:1.13.1")
            force("androidx.activity:activity:1.8.2")
            force("androidx.activity:activity-ktx:1.8.2")
            force("androidx.fragment:fragment:1.6.2")
            force("androidx.fragment:fragment-ktx:1.6.2")
        }
    }
}


configurations {
    getByName("debugImplementation") {
        exclude(group = "io.objectbox", module = "objectbox-android")
    }
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.0.21") 
    debugImplementation("io.objectbox:objectbox-android-objectbrowser:5.0.1")
}

flutter {
    source = "../.."
}