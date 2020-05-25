# PopoverSwiftUI

Example SwiftUI app that forces popovers on all devices, including iPhones.

Forcing popovers can *only* be done in UIKit, by setting the presented view controller's `popoverPresentationController.delegate` and returning `UIModalPresentationStyle.none` from `adaptivePresentationStyle(for:)`. The trick, then, is presenting a UIKit popover from SwiftUI.