# rn-tester-library

Showcase a RN library with the new architecture and backward compatible with the old one.

The chosen library is a manager that can be used to check the current notification authorization status and to ask the system for permissions.

## Installation

```sh
npm install rn-tester-library
```

## Usage

```js
import { AuthorizationStatus, askPermissions, getCurrentStatus } from 'rn-tester-library';

// ...

const currentState: AuthorizationStatus = await getCurrentStatus();
if (currentState == 'Unknown') {
    let newState = askPermissions()
    // do something with the new state
}
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

## TODO:

* [ ] Add CI
* [ ] Fix flipper and folly. This issue is the same as reported [here](https://github.com/facebook/wdt/pull/134) and it has been fixed in [this way](https://github.com/facebook/wdt/commit/4f690c54716118d93e93fb2374d0e55b40ac664b). Not sure yet how to fix this in Xcode/template. Need further investigation. **Mitigation path:** disable Flipper from podfile.
* [ ] Fix yarn command in template to bootstrap/run on an available simulator.
