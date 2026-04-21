#!/bin/sh

set -eu

REGISTRANT_PATH="${SRCROOT}/Runner/GeneratedPluginRegistrant.m"
export REGISTRANT_PATH

if [ ! -f "${REGISTRANT_PATH}" ]; then
  exit 0
fi

python3 - <<'PY'
from pathlib import Path
import os

path = Path(os.environ["REGISTRANT_PATH"])
content = path.read_text()

old = """#if __has_include(<app_links/AppLinksPlugin.h>)
#import <app_links/AppLinksPlugin.h>
#else
@import app_links;
#endif"""

new = """#if __has_include(\"../.symlinks/plugins/app_links/ios/Classes/AppLinksPlugin.h\")
#import \"../.symlinks/plugins/app_links/ios/Classes/AppLinksPlugin.h\"
#elif __has_include(<app_links/AppLinksPlugin.h>)
#import <app_links/AppLinksPlugin.h>
#else
@import app_links;
#endif"""

if old in content and new not in content:
    content = content.replace(old, new)

replacements = {
    """#if __has_include(<cloud_firestore/FLTFirebaseFirestorePlugin.h>)
#import <cloud_firestore/FLTFirebaseFirestorePlugin.h>
#else
@import cloud_firestore;
#endif""": """#if __has_include("../.symlinks/plugins/cloud_firestore/ios/cloud_firestore/Sources/cloud_firestore/include/cloud_firestore/Public/FLTFirebaseFirestorePlugin.h")
#import "../.symlinks/plugins/cloud_firestore/ios/cloud_firestore/Sources/cloud_firestore/include/cloud_firestore/Public/FLTFirebaseFirestorePlugin.h"
#elif __has_include(<cloud_firestore/FLTFirebaseFirestorePlugin.h>)
#import <cloud_firestore/FLTFirebaseFirestorePlugin.h>
#else
@import cloud_firestore;
#endif""",
    """#if __has_include(<firebase_auth/FLTFirebaseAuthPlugin.h>)
#import <firebase_auth/FLTFirebaseAuthPlugin.h>
#else
@import firebase_auth;
#endif""": """#if __has_include("../.symlinks/plugins/firebase_auth/ios/firebase_auth/Sources/firebase_auth/include/Public/FLTFirebaseAuthPlugin.h")
#import "../.symlinks/plugins/firebase_auth/ios/firebase_auth/Sources/firebase_auth/include/Public/FLTFirebaseAuthPlugin.h"
#elif __has_include(<firebase_auth/FLTFirebaseAuthPlugin.h>)
#import <firebase_auth/FLTFirebaseAuthPlugin.h>
#else
@import firebase_auth;
#endif""",
    """#if __has_include(<firebase_core/FLTFirebaseCorePlugin.h>)
#import <firebase_core/FLTFirebaseCorePlugin.h>
#else
@import firebase_core;
#endif
""": "",
    """#if __has_include(<google_sign_in_ios/FLTGoogleSignInPlugin.h>)
#import <google_sign_in_ios/FLTGoogleSignInPlugin.h>
#else
@import google_sign_in_ios;
#endif""": """#if __has_include("../.symlinks/plugins/google_sign_in_ios/darwin/google_sign_in_ios/Sources/google_sign_in_ios/include/google_sign_in_ios/FLTGoogleSignInPlugin.h")
#import "../.symlinks/plugins/google_sign_in_ios/darwin/google_sign_in_ios/Sources/google_sign_in_ios/include/google_sign_in_ios/FLTGoogleSignInPlugin.h"
#elif __has_include(<google_sign_in_ios/FLTGoogleSignInPlugin.h>)
#import <google_sign_in_ios/FLTGoogleSignInPlugin.h>
#else
@import google_sign_in_ios;
#endif""",
    """#if __has_include(<flutter_facebook_auth/FlutterFacebookAuthPlugin.h>)
#import <flutter_facebook_auth/FlutterFacebookAuthPlugin.h>
#else
@import flutter_facebook_auth;
#endif""": """#if __has_include("../.symlinks/plugins/flutter_facebook_auth/ios/Classes/FlutterFacebookAuthPlugin.h")
#import "../.symlinks/plugins/flutter_facebook_auth/ios/Classes/FlutterFacebookAuthPlugin.h"
#elif __has_include(<flutter_facebook_auth/FlutterFacebookAuthPlugin.h>)
#import <flutter_facebook_auth/FlutterFacebookAuthPlugin.h>
#else
@import flutter_facebook_auth;
#endif""",
    """#if __has_include(<shared_preferences_foundation/SharedPreferencesPlugin.h>)
#import <shared_preferences_foundation/SharedPreferencesPlugin.h>
#else
@import shared_preferences_foundation;
#endif
""": "",
    """  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
""": "",
    """  [FLTFirebaseCorePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseCorePlugin"]];
""": "",
}

for source, target in replacements.items():
    if source in content and target not in content:
        content = content.replace(source, target)

path.write_text(content)
PY
