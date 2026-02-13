#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint sweph.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'sweph'
  s.version          = '3.2.0+2.10.3'
  s.summary          = 'Cross-platform bindings of Swiss Ephemeris APIs for Flutter.'
  s.description      = <<-DESC
Cross-platform bindings of Swiss Ephemeris APIs for Flutter.
                       DESC
  s.homepage         = 'https://github.com/vm75/sweph.dart'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'VM75' => 'vm75.dev@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../native/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # Prevent iOS from stripping sweph C symbols used by Dart FFI.
  # With ffiPlugin:true + use_frameworks!(:static), C symbols are compiled
  # into the Runner binary but stripped by: (1) linker dead-code elimination
  # and (2) post-link strip tool. These settings fix both.
  # -all_load: forces linker to include ALL object files from all static archives
  #   (used instead of -force_load which fails Xcode 15+ build-input validation
  #    because the .framework path doesn't exist at validation time)
  # STRIP_STYLE=non-global: preserves global symbol table entries for dlsym()
  # See: Flutter #62666, dart-lang/native #902, sweph.dart #18
  s.user_target_xcconfig = {
    'OTHER_LDFLAGS' => '-all_load',
    'STRIP_STYLE' => 'non-global'
  }
end
