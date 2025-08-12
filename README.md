# passwordless-react-native

Passwordless.dev Android and iOS SDKs for React Native

## Installation


```sh
npm install passwordless-react-native
```


## Usage

These SDKs are ultimately just clients that wrap around platform authentication methods and HTTP clients/API requests in line with SOLID principles, so you can handle building your main app while Passwordless handles user authentication. You'll need a backend server that also implements Passwordless.dev. [Learn more by reading the Passwordless.dev docs](https://docs.passwordless.dev/guide/get-started.html).

### Android

1. [Configure well-known assetlinks](https://docs.passwordless.dev/guide/frontend/android.html#well-known-assetlinks-json)

### iOS

1. Ensure you're running a minimum supported target of iOS 16 in your Podfile:

```rb
# <YourProject>/ios/Podfile
min_ios_versions_supported = ['16.0', min_ios_version_supported]
index_of_max = min_ios_versions_supported.each_with_index.max_by { |number, _| number.to_f }[1]

platform :ios, min_ios_versions_supported[index_of_max]
```

2. In your Podfile, Set the git path of the Passwordless iOS SDK to the repository URL (https://github.com/bitwarden/passwordless-ios.git).

```rb
# <YourProject>/ios/Podfile
target 'YourProject' do
  config = use_native_modules!

  use_react_native!(
    :path => config[:reactNativePath],
    # An absolute path to your application root.
    :app_path => "#{Pod::Config.instance.installation_root}/.."
  )
  pod 'Passwordless', :git => "https://github.com/bitwarden/passwordless-ios.git"

  ...
  end
```

3. [Ensure your iOS app has a Swift-ObjC bridging header](https://developer.apple.com/documentation/swift/importing-swift-into-objective-c).

4. [Set up app associated domains with a `webcredentials` section](https://developer.apple.com/documentation/Xcode/supporting-associated-domains).

## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
