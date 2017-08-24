# infiniteProducts

infiniteProducts acts like a playground for the technical challenges we face in our development cycles.

This is just a simple random product listing app trying to address those challenges in an efficient way. There is no deadlines, no restrictions, no rules.

What is already done and what could be achieved more is available below.

## Architecture
- [X] MVP with a view model touch. The app is using traditional model-view-presenter approach but uses dummy, logic-less view model objects to encapsulate UI logic (fire & forget) and communicate through the view via presenter.
- [ ] MVVM
- [ ] VIPER
## UI Approaches
- [X] Collection view with self resizing cells. Regardless from the device size, column count is always the same.
  - Aspect ratio based constraints for images to prevent device based UI bugs.
  - Labels are capable of working with very short and very long texts to replicate multiple language based apps.
- [X] Silent background fetch to give `infinite` scroll feeling.
  - Data source is silently populated by presenter logic and this change is reflected to the UI without any blocking or snapping effect.
- [ ] Detail pages for items
- [ ] Fancy transitions
- [ ] User friendly loading indicators
## General Approaches
- POP & OOP combination to make the code base much more testable and abstracted.
  - `ViewLifeCycleObservable` removes the repetitive code required for view-presenter communication.
  - `BaseViewController` implements this protocol and removes boiler plate code.
- DI for further testability and immutability.
- Clean representation of API with Siesta.
  - Preventing redundant & duplicate requests using in memory cache provided by Siesta.
  - More reactive approach for API calls.
  - Much much less boilerplate code. :pray:
- Image caching with Siesta.
## Testing Approaches
- Integration and unit tests for business logic.
- Protocol oriented approach to make testing extremely easy.
- Injectable, dummy, mock objects to make sure there is nothing untested.
- Stubbed network layer for low level and API independent mocking.
## Dependency Management
- [X] Cocoapods
- [ ] Carthage
## External Libraries
- [X] Unbox
- [X] Siesta
- [ ] RxSwift
- [ ] Swinject
- [ ] Quick
