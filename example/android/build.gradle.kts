allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Fix for verifyReleaseResources
    afterEvaluate {
        // Apply settings if Android plugin is applied
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            extensions.findByName("android")?.let {
                (it as com.android.build.gradle.BaseExtension).apply {
                    compileSdkVersion(36)
                    buildToolsVersion("34.0.0")
                }
            }
        }

        // Set namespace if it's null and 'android' extension exists
        extensions.findByName("android")?.let {
            val androidExtension = it as com.android.build.gradle.BaseExtension
            if (androidExtension.namespace == null) {
                androidExtension.namespace = project.group.toString()
            }
        }
    }

    buildDir = File(rootProject.buildDir, name)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
