## 🧱 Brickman demo 🧱

This is a quick demo project to demonstrate Flutter's code generating capabilities. For this we are using the **mason** package (article from the author of the package explaining how this works: [https://verygood.ventures/blog/code-generation-with-mason](https://verygood.ventures/blog/code-generation-with-mason) ). What this demo has is a working app scaffold, splash brick (with custom shader background) and authorisation brick. Bricks edit the necessary yaml files with post gen hooks. For expediency the backend supporting the authorisation brick is Supabase running on Fly.io. What it does not have and would have liked to include (due to time constraints) is: transitioning from mason code generation to regular code generation via post gen hooks and [Remote Flutter Widgets](https://github.com/flutter/packages/tree/main/packages/rfw)

### How to use ###

Install either from pub.dev:

`dart pub global activate mason_cli`

or install from homebrew:

`brew tap felangel/mason`

`brew install mason`

Then create your project folder and init mason with:

`mason init`

Get the bricks:

`mason add app_scaffold --git-url https://github.com/baer-tech/brickman --git-path v1/bricks/app_scaffold`

`mason add splash --git-url https://github.com/baer-tech/brickman --git-path v1/bricks/splash`

`mason add authorisation --git-url https://github.com/baer-tech/brickman --git-path v1/bricks/authorisation`


Enter your project folder and make the app_scaffold brick:

`mason make app_scaffold`

And optionally:

`mason make splash -o ./features`

`mason make authorisation -o ./features`

Afterwards uncomment specific routes as needed in **router.dart** and potentially the destination in `.go()` method in **app.dart** depending if only splash or authorisation bricks have been added (or both).

