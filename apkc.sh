#!/bin/bash

WR="\033[0;33m"
NO="\033[0m"
ER="\033[0;31m"
SC="\033[0;32m"

# cara pakai
usage() {
  echo -e "${WR}Usage:${NO}"
  echo "  $0 --name <project-name> --package <package-name> [--activity <activity-name>]"
  echo ""
  echo "Example:"
  echo "  $0 --name Malas --package id.imphnen.malas --activity MalasActivity"
  exit 1
}

# buat direktori
create_directories() {
  local base_dir=$1
  local package_path=$(echo $2 | tr "." "/")

  mkdir -p "$base_dir/app/src/main/java/$package_path"
  mkdir -p "$base_dir/app/src/main/res/layout"
  mkdir -p "$base_dir/app/src/main/res/values"
  mkdir -p "$base_dir/app/src/main/res/drawable"
  mkdir -p "$base_dir/app/src/main/res/mipmap"
  mkdir -p "$base_dir/app/src/main/res/mipmap-anydpi-v26"
  mkdir -p "$base_dir/app/src/main/res/values-night"
  mkdir -p "$base_dir/app/src/main/res/xml"
  mkdir -p "$base_dir/app/src/androidTest/java/$package_path"
  mkdir -p "$base_dir/app/src/test/java/$package_path"
  mkdir -p "$base_dir/gradle/wrapper"

  echo -e "${NO}Project directory ${SC}created\n"
}

create_gradle_wrapper_libs() {
  local base_dir=$1
  local path="$base_dir/gradle/libs.versions.toml"
  cat > $path << EOF
[versions]
agp = "8.12.3"
junit = "4.13.2"
junitVersion = "1.1.5"
espressoCore = "3.5.1"
appcompat = "1.6.1"
material = "1.10.0"
activity = "1.8.0"
constraintlayout = "2.1.4"

[libraries]
junit = { group = "junit", name = "junit", version.ref = "junit" }
ext-junit = { group = "androidx.test.ext", name = "junit", version.ref = "junitVersion" }
espresso-core = { group = "androidx.test.espresso", name = "espresso-core", version.ref = "espressoCore" }
appcompat = { group = "androidx.appcompat", name = "appcompat", version.ref = "appcompat" }
material = { group = "com.google.android.material", name = "material", version.ref = "material" }
activity = { group = "androidx.activity", name = "activity", version.ref = "activity" }
constraintlayout = { group = "androidx.constraintlayout", name = "constraintlayout", version.ref = "constraintlayout" }

[plugins]
android-application = { id = "com.android.application", version.ref = "agp" }
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_gradle_wrapper_props() {
  local base_dir=$1
  local path="$base_dir/gradle/wrapper/gradle-wrapper.properties"
  cat > $path << EOF
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.13-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_gitignore() {
  local base_dir=$1
  local path="$base_dir/.gitignore"
  cat > $path << EOF
*.iml
.gradle
/local.properties
/.idea/caches
/.idea/libraries
/.idea/modules.xml
/.idea/workspace.xml
/.idea/navEditor.xml
/.idea/assetWizardSettings.xml
.DS_Store
/build
/captures
.externalNativeBuild
.cxx
local.properties
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_build_gradle() {
  local base_dir=$1
  local path="$base_dir/build.gradle"
  cat > $path << EOF
// Top-level build file where you can add configuration options common to all sub-projects/modules.
plugins {
  alias(libs.plugins.android.application) apply false
}
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_gradle_properties() {
  local base_dir=$1
  local path="$base_dir/gradle.properties"
  cat > $path << EOF
# Project-wide Gradle settings.
# IDE (e.g. Android Studio) users:
# Gradle settings configured through the IDE *will override*
# any settings specified in this file.
# For more details on how to configure your build environment visit
# http://www.gradle.org/docs/current/userguide/build_environment.html
# Specifies the JVM arguments used for the daemon process.
# The setting is particularly useful for tweaking memory settings.
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
# When configured, Gradle will run in incubating parallel mode.
# This option should only be used with decoupled projects. For more details, visit
# https://developer.android.com/r/tools/gradle-multi-project-decoupled-projects
# org.gradle.parallel=true
# AndroidX package structure to make it clearer which packages are bundled with the
# Android operating system, and which are packaged with your app's APK
# https://developer.android.com/topic/libraries/support-library/androidx-rn
android.useAndroidX=true
# Enables namespacing of each library's R class so that its R class includes only the
# resources declared in the library itself and none from the library's dependencies,
# thereby reducing the size of the R class for that library
android.nonTransitiveRClass=true
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_gradlew() {
  local base_dir=$1
  local path="$base_dir/gradlew"
  cat > $path << "EOF"
#!/usr/bin/env sh
#
# Copyright 2015 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

##############################################################################
##
##  Gradle start up script for UN*X
##
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
# Need this for relative symlinks.
while [ -h "$PRG" ] ; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '.*-> \(.*\)$'`
    if expr "$link" : '/.*' > /dev/null; then
        PRG="$link"
    else
        PRG=`dirname "$PRG"`"/$link"
    fi
done
SAVED="`pwd`"
cd "`dirname \"$PRG\"`/" >/dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" >/dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS='"-Xmx64m" "-Xms64m"'

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
msys=false
darwin=false
nonstop=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    msys=true
    ;;
  NONSTOP* )
    nonstop=true
    ;;
esac

CLASSPATH=$APP_HOME/gradle/wrapper/gradle-wrapper.jar


# Determine the Java command to use to start the JVM.
if [ -n "$JAVA_HOME" ] ; then
    if [ -x "$JAVA_HOME/jre/sh/java" ] ; then
        # IBM's JDK on AIX uses strange locations for the executables
        JAVACMD="$JAVA_HOME/jre/sh/java"
    else
        JAVACMD="$JAVA_HOME/bin/java"
    fi
    if [ ! -x "$JAVACMD" ] ; then
        die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
    fi
else
    JAVACMD="java"
    which java >/dev/null 2>&1 || die "ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.

Please set the JAVA_HOME variable in your environment to match the
location of your Java installation."
fi

# Increase the maximum file descriptors if we can.
if [ "$cygwin" = "false" -a "$darwin" = "false" -a "$nonstop" = "false" ] ; then
    MAX_FD_LIMIT=`ulimit -H -n`
    if [ $? -eq 0 ] ; then
        if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
            MAX_FD="$MAX_FD_LIMIT"
        fi
        ulimit -n $MAX_FD
        if [ $? -ne 0 ] ; then
            warn "Could not set maximum file descriptor limit: $MAX_FD"
        fi
    else
        warn "Could not query maximum file descriptor limit: $MAX_FD_LIMIT"
    fi
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin; then
    GRADLE_OPTS="$GRADLE_OPTS \"-Xdock:name=$APP_NAME\" \"-Xdock:icon=$APP_HOME/media/gradle.icns\""
fi

# For Cygwin or MSYS, switch paths to Windows format before running java
if [ "$cygwin" = "true" -o "$msys" = "true" ] ; then
    APP_HOME=`cygpath --path --mixed "$APP_HOME"`
    CLASSPATH=`cygpath --path --mixed "$CLASSPATH"`

    JAVACMD=`cygpath --unix "$JAVACMD"`

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=`find -L / -maxdepth 1 -mindepth 1 -type d 2>/dev/null`
    SEP=""
    for dir in $ROOTDIRSRAW ; do
        ROOTDIRS="$ROOTDIRS$SEP$dir"
        SEP="|"
    done
    OURCYGPATTERN="(^($ROOTDIRS))"
    # Add a user-defined pattern to the cygpath arguments
    if [ "$GRADLE_CYGPATTERN" != "" ] ; then
        OURCYGPATTERN="$OURCYGPATTERN|($GRADLE_CYGPATTERN)"
    fi
    # Now convert the arguments - kludge to limit ourselves to /bin/sh
    i=0
    for arg in "$@" ; do
        CHECK=`echo "$arg"|egrep -c "$OURCYGPATTERN" -`
        CHECK2=`echo "$arg"|egrep -c "^-"`                                 ### Determine if an option

        if [ $CHECK -ne 0 ] && [ $CHECK2 -eq 0 ] ; then                    ### Added a condition
            eval `echo args$i`=`cygpath --path --ignore --mixed "$arg"`
        else
            eval `echo args$i`="\"$arg\""
        fi
        i=`expr $i + 1`
    done
    case $i in
        0) set -- ;;
        1) set -- "$args0" ;;
        2) set -- "$args0" "$args1" ;;
        3) set -- "$args0" "$args1" "$args2" ;;
        4) set -- "$args0" "$args1" "$args2" "$args3" ;;
        5) set -- "$args0" "$args1" "$args2" "$args3" "$args4" ;;
        6) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" ;;
        7) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" ;;
        8) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" ;;
        9) set -- "$args0" "$args1" "$args2" "$args3" "$args4" "$args5" "$args6" "$args7" "$args8" ;;
    esac
fi

# Escape application args
save () {
    for i do printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/" ; done
    echo " "
}
APP_ARGS=`save "$@"`

# Collect all arguments for the java command, following the shell quoting and substitution rules
eval set -- $DEFAULT_JVM_OPTS $JAVA_OPTS $GRADLE_OPTS "\"-Dorg.gradle.appname=$APP_BASE_NAME\"" -classpath "\"$CLASSPATH\"" org.gradle.wrapper.GradleWrapperMain "$APP_ARGS"

exec "$JAVACMD" "$@"
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_gradlew_bat() {
  local base_dir=$1
  local path="$base_dir/gradlew.bat"
  cat > $path << EOF
@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Gradle startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Xmx64m" "-Xms64m"

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\gradle\wrapper\gradle-wrapper.jar


@rem Execute Gradle
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% "-Dorg.gradle.appname=%APP_BASE_NAME%" -classpath "%CLASSPATH%" org.gradle.wrapper.GradleWrapperMain %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable GRADLE_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%GRADLE_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_local_properties() {
  local base_dir=$1
  local sdk_home=$2
  local path="$base_dir/local.properties"
  cat > $path << EOF
## This file is automatically generated by Android Studio.
# Do not modify this file -- YOUR CHANGES WILL BE ERASED!
#
# This file should *NOT* be checked into Version Control Systems,
# as it contains information specific to your local configuration.
#
# Location of the SDK. This is only used by Gradle.
# For customization when using a Version Control System, please read the
# header note.
sdk.dir=$sdk_home
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_settings_gradle() {
  local base_dir=$1
  local project_name=$2
  local path="$base_dir/settings.gradle"
  cat > $path << EOF
pluginManagement {
  repositories {
    google {
      content {
        includeGroupByRegex("com\\\.android.*")
        includeGroupByRegex("com\\\.google.*")
        includeGroupByRegex("androidx.*")
      }
    }
    mavenCentral()
    gradlePluginPortal()
  }
}
dependencyResolutionManagement {
  repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
  repositories {
    google()
    mavenCentral()
  }
}

rootProject.name = "$project_name"
include ":app"
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_readme_md() {
  local base_dir=$1
  local path="$base_dir/README.md"
  cat > $path << EOF
# Template
* by https://github.com/Kynonim
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_gitignore() {
  local base_dir=$1
  local path="$base_dir/app/.gitignore"
  cat > $path << EOF
/build
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_build_gradle() {
  local base_dir=$1
  local package_name=$2
  local path="$base_dir/app/build.gradle"
  cat > $path << EOF
plugins {
  alias(libs.plugins.android.application)
}

android {
  namespace "$package_name"
  compileSdk 36

  defaultConfig {
    applicationId "$package_name"
    minSdk 24
    targetSdk 36
    versionCode 1
    versionName "1.0"

    testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
  }

  buildTypes {
    release {
      minifyEnabled false
      proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
  }
  compileOptions {
    sourceCompatibility JavaVersion.VERSION_11
    targetCompatibility JavaVersion.VERSION_11
  }
}

dependencies {
  implementation libs.appcompat
  implementation libs.material
  implementation libs.activity
  implementation libs.constraintlayout
  testImplementation libs.junit
  androidTestImplementation libs.ext.junit
  androidTestImplementation libs.espresso.core
}
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_proguard_rules_pro() {
  local base_dir=$1
  local path="$base_dir/app/proguard-rules.pro"
  cat > $path << EOF
# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_android_test() {
  local base_dir=$1
  local package_path=$2
  local package_name=$3
  local path="$base_dir/app/src/androidTest/java/$package_path/ExampleInstrumentedTest.java"
  cat > $path << EOF
package $package_name;

import android.content.Context;
import androidx.test.platform.app.InstrumentationRegistry;
import androidx.test.ext.junit.runners.AndroidJUnit4;

import org.junit.Test;
import org.junit.runner.RunWith;
import static org.junit.Assert.*;

@RunWith(AndroidJUnit4.class)
public class ExampleInstrumentedTest {
  @Test
  public void useAppContext() {
    Context appContext = InstrumentationRegistry.getInstrumentation().getTargetContext();
    assertEquals("$package_name", appContext.getPackageName());
  }
}
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_test() {
  local base_dir=$1
  local package_path=$2
  local package_name=$3
  local path="$base_dir/app/src/test/java/$package_path/ExampleUnitTest.java" << EOF
package $package_name;

import org.junit.Test;
import static org.junit.Assert.*;

public class ExampleUnitTest {
  @Test
  public void addition_isCorrect() {
    assertEquals(4, 2 + 2);
  }
}
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_main_activity() {
  local base_dir=$1
  local package_path=$2
  local package_name=$3
  local activity_name=$4
  local path="$base_dir/app/src/main/java/$package_path/$activity_name.java"
  cat > $path << EOF
package $package_name;

import android.os.Bundle;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class $activity_name extends AppCompatActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    EdgeToEdge.enable(this);
    setContentView(R.layout.activity_main);
    ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
      Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
      v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
      return insets;
    });

    findViewById(R.id.btn_start).setOnClickListener(v -> {
      Toast.makeText(this, "Hallo Semuanya, Saya Riky Ripaldo", Toast.LENGTH_SHORT).show();
    });
  }
}
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_android_manifest() {
  local base_dir=$1
  local activity_name=$2
  local path="$base_dir/app/src/main/AndroidManifest.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
  xmlns:tools="http://schemas.android.com/tools">

  <application
    android:allowBackup="true"
    android:dataExtractionRules="@xml/data_extraction_rules"
    android:fullBackupContent="@xml/backup_rules"
    android:icon="@mipmap/ic_launcher"
    android:label="@string/app_name"
    android:roundIcon="@mipmap/ic_launcher_round"
    android:supportsRtl="true"
    android:theme="@style/Theme.Malas">
    <activity
      android:name=".$activity_name"
      android:exported="true">
      <intent-filter>
        <action android:name="android.intent.action.MAIN" />
        <category android:name="android.intent.category.LAUNCHER" />
      </intent-filter>
    </activity>
  </application>

</manifest>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_drawable_ic_bg() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/drawable/ic_launcher_background.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
<vector xmlns:android="http://schemas.android.com/apk/res/android"
  android:width="108dp"
  android:height="108dp"
  android:viewportWidth="108"
  android:viewportHeight="108">
  <path
    android:fillColor="#3DDC84"
    android:pathData="M0,0h108v108h-108z" />
  <path
    android:fillColor="#00000000"
    android:pathData="M9,0L9,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,0L19,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M29,0L29,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M39,0L39,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M49,0L49,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M59,0L59,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M69,0L69,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M79,0L79,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M89,0L89,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M99,0L99,108"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,9L108,9"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,19L108,19"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,29L108,29"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,39L108,39"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,49L108,49"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,59L108,59"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,69L108,69"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,79L108,79"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,89L108,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M0,99L108,99"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,29L89,29"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,39L89,39"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,49L89,49"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,59L89,59"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,69L89,69"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M19,79L89,79"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M29,19L29,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M39,19L39,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M49,19L49,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M59,19L59,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M69,19L69,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
  <path
    android:fillColor="#00000000"
    android:pathData="M79,19L79,89"
    android:strokeWidth="0.8"
    android:strokeColor="#33FFFFFF" />
</vector>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_drawable_ic_fg() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/drawable/ic_launcher_foreground.xml"
  cat > $path << EOF
<vector xmlns:android="http://schemas.android.com/apk/res/android"
  xmlns:aapt="http://schemas.android.com/aapt"
  android:width="108dp"
  android:height="108dp"
  android:viewportWidth="108"
  android:viewportHeight="108">
  <path android:pathData="M31,63.928c0,0 6.4,-11 12.1,-13.1c7.2,-2.6 26,-1.4 26,-1.4l38.1,38.1L107,108.928l-32,-1L31,63.928z">
    <aapt:attr name="android:fillColor">
      <gradient
        android:endX="85.84757"
        android:endY="92.4963"
        android:startX="42.9492"
        android:startY="49.59793"
        android:type="linear">
        <item
          android:color="#44000000"
          android:offset="0.0" />
        <item
          android:color="#00000000"
          android:offset="1.0" />
      </gradient>
    </aapt:attr>
  </path>
  <path
    android:fillColor="#FFFFFF"
    android:fillType="nonZero"
    android:pathData="M65.3,45.828l3.8,-6.6c0.2,-0.4 0.1,-0.9 -0.3,-1.1c-0.4,-0.2 -0.9,-0.1 -1.1,0.3l-3.9,6.7c-6.3,-2.8 -13.4,-2.8 -19.7,0l-3.9,-6.7c-0.2,-0.4 -0.7,-0.5 -1.1,-0.3C38.8,38.328 38.7,38.828 38.9,39.228l3.8,6.6C36.2,49.428 31.7,56.028 31,63.928h46C76.3,56.028 71.8,49.428 65.3,45.828zM43.4,57.328c-0.8,0 -1.5,-0.5 -1.8,-1.2c-0.3,-0.7 -0.1,-1.5 0.4,-2.1c0.5,-0.5 1.4,-0.7 2.1,-0.4c0.7,0.3 1.2,1 1.2,1.8C45.3,56.528 44.5,57.328 43.4,57.328L43.4,57.328zM64.6,57.328c-0.8,0 -1.5,-0.5 -1.8,-1.2s-0.1,-1.5 0.4,-2.1c0.5,-0.5 1.4,-0.7 2.1,-0.4c0.7,0.3 1.2,1 1.2,1.8C66.5,56.528 65.6,57.328 64.6,57.328L64.6,57.328z"
    android:strokeWidth="1"
    android:strokeColor="#00000000" />
</vector>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_layout() {
  local base_dir=$1
  local activity_name=$2
  local path="$base_dir/app/src/main/res/layout/activity_main.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
  xmlns:app="http://schemas.android.com/apk/res-auto"
  xmlns:tools="http://schemas.android.com/tools"
  android:id="@+id/main"
  android:layout_width="match_parent"
  android:layout_height="match_parent"
  tools:context=".$activity_name">

  <RelativeLayout
    android:layout_centerInParent="true"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content">

    <Button
      android:id="@+id/btn_start"
      android:text="@string/start"
      android:layout_width="wrap_content"
      android:layout_height="wrap_content"/>

  </RelativeLayout>

</RelativeLayout>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_mipmap_ic() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
  <background android:drawable="@drawable/ic_launcher_background" />
  <foreground android:drawable="@drawable/ic_launcher_foreground" />
  <monochrome android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_mipmap_ic_round() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
<adaptive-icon xmlns:android="http://schemas.android.com/apk/res/android">
    <background android:drawable="@drawable/ic_launcher_background" />
    <foreground android:drawable="@drawable/ic_launcher_foreground" />
    <monochrome android:drawable="@drawable/ic_launcher_foreground" />
</adaptive-icon>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_values_colors() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/values/colors.xml"
  cat > $path << EOF
<resources>
  <color name="purple_200">#FFBB86FC</color>
  <color name="purple_500">#FF6200EE</color>
  <color name="purple_700">#FF3700B3</color>
  <color name="teal_200">#FF03DAC5</color>
  <color name="teal_700">#FF018786</color>
  <color name="black">#FF000000</color>
  <color name="white">#FFFFFFFF</color>
</resources>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_values_strings() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/values/strings.xml"
  cat > $path << EOF
<resources>
  <string name="app_name">$base_dir</string>
  <string name="nama">Riky Ripaldo</string>
  <string name="univ_name">Universitas Stekom</string>
  <string name="start">Start</string>
</resources>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_values_themes() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/values/themes.xml"
  cat > $path << EOF
<resources>
  <style name="Theme.Apps" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
    <item name="colorPrimary">@color/purple_500</item>
    <item name="colorPrimaryVariant">@color/purple_700</item>
    <item name="colorOnPrimary">@color/white</item>
    <item name="colorSecondary">@color/teal_200</item>
    <item name="colorSecondaryVariant">@color/teal_700</item>
    <item name="colorOnSecondary">@color/black</item>
    <item name="android:statusBarColor">?attr/colorPrimaryVariant</item>
  </style>
  <style name="Base.Theme.Malas" parent="Theme.Material3.DayNight.NoActionBar">
    <!-- Customize your light theme here. -->
    <!-- <item name="colorPrimary">@color/my_light_primary</item> -->
  </style>
  <style name="Theme.Malas" parent="Base.Theme.Malas" />
</resources>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_values_night_themes() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/values-night/themes.xml"
  cat > $path << EOF
<resources xmlns:tools="http://schemas.android.com/tools">
  <!-- Base application theme. -->
  <style name="Base.Theme.Malas" parent="Theme.Material3.DayNight.NoActionBar">
    <!-- Customize your dark theme here. -->
    <!-- <item name="colorPrimary">@color/my_dark_primary</item> -->
  </style>
</resources>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_xml_bckp() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/xml/backup_rules.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
  <!--
    Sample backup rules file; uncomment and customize as necessary.
    See https://developer.android.com/guide/topics/data/autobackup
    for details.
    Note: This file is ignored for devices older than API 31
    See https://developer.android.com/about/versions/12/backup-restore
  -->
<full-backup-content>
  <!--
    <include domain="sharedpref" path="."/>
    <exclude domain="sharedpref" path="device.xml"/>
  -->
</full-backup-content>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

create_app_res_xml_data() {
  local base_dir=$1
  local path="$base_dir/app/src/main/res/xml/data_extraction_rules.xml"
  cat > $path << EOF
<?xml version="1.0" encoding="utf-8"?>
  <!--
    Sample data extraction rules file; uncomment and customize as necessary.
    See https://developer.android.com/about/versions/12/backup-restore#xml-changes
    for details.
  -->
<data-extraction-rules>
  <cloud-backup>
    <!-- TODO: Use <include> and <exclude> to control what is backed up.
    <include .../>
    <exclude .../>
    -->
  </cloud-backup>
  <!--
  <device-transfer>
    <include .../>
    <exclude .../>
  </device-transfer>
  -->
</data-extraction-rules>
EOF
  echo -e "${NO}[${WR}$path${NO}] ${SC}created"
}

# init
PROJECT_NAME=""
PACKAGE_NAME=""
ACTIVITY_NAME="MainActivity"

while [[ $# -gt 0 ]]; do
  case $1 in
    --name)
      PROJECT_NAME="$2"
      shift 2
      ;;
    --package)
      PACKAGE_NAME="$2"
      shift 2
      ;;
    --activity)
      ACTIVITY_NAME="$2"
      shift 2
      ;;
    *)
      usage
      ;;
  esac
done

# validasi argumen
if [[ -z "$PROJECT_NAME" ]] || [[ -z "$PACKAGE_NAME" ]]; then
  echo -e "${ER}Error: ${NO}Project name and package name are required!"
  usage
fi

PACKAGE_PATH=$(echo $PACKAGE_NAME | tr "." "/")
PROJECT_DIR="./$PROJECT_NAME"

# cek direktori
if [[ -d "$PROJECT_DIR" ]]; then
  echo -e "${ER}Error:${NO} $PROJECT_DIR directory already exists!"
  exit 1
fi

# create proyek
echo -e "${SC}Project:${NO} $PROJECT_NAME"
echo -e "${SC}Package:${NO} $PACKAGE_NAME"
echo -e "${SC}Activity:${NO} $ACTIVITY_NAME"
echo ""

create_directories "$PROJECT_DIR" "$PACKAGE_NAME"
create_app_gitignore "$PROJECT_DIR"
create_app_build_gradle "$PROJECT_DIR" "$PACKAGE_NAME"
create_app_proguard_rules_pro "$PROJECT_DIR"
create_app_android_test "$PROJECT_DIR" "$PACKAGE_PATH" "$PACKAGE_NAME"
create_app_test "$PROJECT_DIR" "$PACKAGE_PATH" "$PACKAGE_NAME"
create_app_main_activity "$PROJECT_DIR" "$PACKAGE_PATH" "$PACKAGE_NAME" "$ACTIVITY_NAME"
create_android_manifest "$PROJECT_DIR" "$ACTIVITY_NAME"
create_app_res_drawable_ic_bg "$PROJECT_DIR"
create_app_res_drawable_ic_fg "$PROJECT_DIR"
create_app_res_layout "$PROJECT_DIR" "$ACTIVITY_NAME"
create_app_res_mipmap_ic "$PROJECT_DIR"
create_app_res_mipmap_ic_round "$PROJECT_DIR"
create_app_res_values_colors "$PROJECT_DIR"
create_app_res_values_strings "$PROJECT_DIR"
create_app_res_values_themes "$PROJECT_DIR"
create_app_res_values_night_themes "$PROJECT_DIR"
create_app_res_xml_bckp "$PROJECT_DIR"
create_app_res_xml_data "$PROJECT_DIR"
create_gradle_wrapper_libs "$PROJECT_DIR"
create_gradle_wrapper_props "$PROJECT_DIR"
create_build_gradle "$PROJECT_DIR"
create_gradle_properties "$PROJECT_DIR"
create_gradlew "$PROJECT_DIR"
create_gradlew_bat "$PROJECT_DIR"
create_local_properties "$PROJECT_DIR" "$ANDROID_HOME"
create_settings_gradle "$PROJECT_DIR" "$PROJECT_NAME"
create_gitignore "$PROJECT_DIR"
create_readme_md "$PROJECT_DIR"

# success
echo ""
echo -e "${SC}$PROJECT_NAME ${NO}successfully created"
echo -e "${SC}Executable gradlew created"
chmod +x $PROJECT_NAME/gradlew
chmod +x $PROJECT_NAME/gradlew.bat
echo ""
echo -e "${WR}Next:${NO}"
echo -e "  1. ${SC}cd${NO} $PROJECT_NAME"
echo -e "  2. Open with Android Studio or build with: ${SC}./gradlew build"
echo ""
echo -e "${WR}Project structure:${NO}"
tree "$PROJECT_DIR" -L 3 2>/dev/null || ls "$PROJECT_DIR"