# DeviceShakeDemo

A small SwiftUI project demonstrating a custom `ViewModifier` that detects device shake events using `.onDeviceShake(isActive:action:)`.

## Feature

Detects physical device shakes and triggers a custom action in SwiftUI views without needing to subclass UIKit components.

```swift
.onDeviceShake(isActive: true) {
    // Handle shake
}
```

## Includes

- `DeviceShakeViewModifier.swift` – reusable modifier
- `ShakeView.swift` – demo UI with animated response
- `ShakeViewModel.swift` – simple view model for state handling

## Usage

Drop the `DeviceShakeViewModifier` into your SwiftUI project and call `.onDeviceShake(...)` on any view to handle shakes.

This modifier is part of [NnSwiftUIKit](https://github.com/nikolainobadi/NnSwiftUIKit), a collection of custom SwiftUI view modifiers and utilities.
