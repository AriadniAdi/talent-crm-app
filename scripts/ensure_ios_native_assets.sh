#!/bin/sh

set -eu

if [ "${SRCROOT:-}" != "" ]; then
  PROJECT_ROOT="${SRCROOT}/.."
else
  PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
fi
NATIVE_ASSETS_DIR="${PROJECT_ROOT}/build/native_assets/ios"
FLUTTER_BUILD_DIR="${PROJECT_ROOT}/.dart_tool/flutter_build"
HOOKS_SHARED_DIR="${PROJECT_ROOT}/.dart_tool/hooks_runner/shared"
EXPECTED_DYLIBS="$(find "${HOOKS_SHARED_DIR}" -path '*/build/*/*.dylib' -print 2>/dev/null || true)"

if [ -z "${EXPECTED_DYLIBS}" ]; then
  exit 0
fi

if [ ! -d "${FLUTTER_BUILD_DIR}" ]; then
  exit 0
fi

needs_rebuild=0

for dylib in ${EXPECTED_DYLIBS}; do
  framework_name="$(basename "${dylib}" .dylib)"
  framework_binary="${NATIVE_ASSETS_DIR}/${framework_name}.framework/${framework_name}"

  if [ ! -f "${framework_binary}" ]; then
    needs_rebuild=1
    break
  fi
done

if [ "${needs_rebuild}" -eq 0 ]; then
  exit 0
fi

echo "Missing build/native_assets/ios. Invalidating stale Flutter native asset intermediates."

rm -f "${FLUTTER_BUILD_DIR}"/*/native_assets.json
rm -f "${FLUTTER_BUILD_DIR}"/*/install_code_assets.d

rm -rf "${NATIVE_ASSETS_DIR}"
mkdir -p "${NATIVE_ASSETS_DIR}"

printf '%s\n' "${EXPECTED_DYLIBS}" | while read -r dylib; do
  [ -n "${dylib}" ] || continue
  framework_name="$(basename "${dylib}" .dylib)"
  framework_dir="${NATIVE_ASSETS_DIR}/${framework_name}.framework"

  mkdir -p "${framework_dir}"
  cp "${dylib}" "${framework_dir}/${framework_name}"

  cat > "${framework_dir}/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>CFBundleExecutable</key>
  <string>${framework_name}</string>
  <key>CFBundleIdentifier</key>
  <string>dev.flutter.native_asset.${framework_name}</string>
  <key>CFBundleName</key>
  <string>${framework_name}</string>
  <key>CFBundlePackageType</key>
  <string>FMWK</string>
  <key>CFBundleShortVersionString</key>
  <string>1.0</string>
  <key>CFBundleVersion</key>
  <string>1</string>
</dict>
</plist>
EOF
done
