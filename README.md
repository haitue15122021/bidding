# Flutter SDK : We use Flutter sdk 2.0.6 for this project
- Flutter channel: stable



# Restaurant Management App 

### Getting started

* Get dependencies and generate necessary files.

```
npm run init
```

* We'll handle the generation of required files for 🚀 your onboarding!

### BLoC (Business Logic Components) architecture

This is similar to MVVM on Android, mainly based on streams and events to form a reactive architecture.
<img src="https://miro.medium.com/max/1044/1*MqYPYKdNBiID0mZ-zyE-mA.png"/>

### Networking

Networking client - [Dio](https://pub.dev/packages/dio)
Networking annotations / generator - [Retrofit](https://pub.dev/packages/retrofit) (this relies on Dio client)

### Dependency Injection

[Get_it](https://pub.dev/packages/get_it)
Setting up injection

```
GetIt getIt = GetIt.instance;

 final dio = Dio();
  dio.interceptors.add(LogInterceptor(responseBody: true));
  dio.interceptors.add(AuthInterceptor());

  getIt.registerSingleton(RestaurantApi(dio));
  
  // constructor injection
  getIt.registerFactory(
      () => RestaurantRepository(merchantApi: getIt.get<RestaurantApi>()));
```

To get injected objects

```
// constructor
class RestaurantRepository {
  RestaurantApi restaurantApi;

  RestaurantRepository({RestaurantApi restaurantApi}) {
    this.restaurantApi = restaurantApi;
  }
 }
 
 // get it directly
 class _RestaurantListScreenState extends State<RestaurantListScreen> {
  final restaurantBloc = getIt.get<RestaurantBloc>();
  }
```

### Project architecture (Clean Architecture Approach)

**note**: You might see some place are not using this, because this is newly introduced, only for new MR, old MR will
still direct inject `repositories` into `BLoC`. Only change when there is issue on those functions.

1. Why:
    * We want to separate what type of database that we use for storage (might want to change it later on)
    * To adhere SOLID principles since we are using OOP for this project.
    * Ensuring UI layers don't know what is going on at data layer at all.
    * Might want to separate each layers into different packages.
2. Presentation - Domain - Data.
3. Presentation layer consist of
    * Widgets
    * BLoC
        * Bloc only manages UI state based on business logic
4. Domain layer (Business logic layer)
    * Repositories (interfaces aka idea how the logic would behave)
    * Entities (or models which what UI needs)
    * Usecases (user stories)
        * Typically one function, but can be more if they are functionality related.
        * Remember, one class for one responsibility.
5. Data layer
    * Data Sources
        * remotes (API)
        * locals (Database)
    * Models
        * request
        * response
    * Repositories (Implementation from Domain layer)
6. More insight of layers
   ![image](https://miro.medium.com/max/772/0*sfCDEb571WD-7EfP.jpg)
7. The inner layer should **NOT** know what the outer layer has / do.
8. Reference:
    1. https://github.com/ResoCoder/flutter-tdd-clean-architecture-course
    2. https://github.com/ShadyBoukhary/flutter_clean_architecture (We don't use this plugin)
    3. https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html

## Injections

1. We are using `GetIt` for injections. It is fun because we can start the service locator and use it everywhere when
   needed because they are injected at top-level in main.dart.
2. Only use it upon initialization

```
getIt.registerSingleton<RestaurantBloc>(RestaurantBloc(
    restaurantUsecase: RestaurantUsecase(getIt<RestaurantRepository>()),
  ));
``` 

and use it on `route`

```
BlocProvider<RestaurantBloc>(
    create: (_) => getIt.get<RestaurantBloc>(),
),
```

for reusing the `BLoC`,

```
BlocProvider.value(
    value: getIt.get<RestaurantBloc>(),
)
```

for usage (in Widgets), **always** use

`context.boc<RestaurantBloc>().add(LoadRestaurantsEvent());`

instead of

`getIt.get<RestaurantBloc>().add(LoadRestaurantsEvent());`

For non widget usage, manually inject the object on initialization.

### Localization

Using this library to handle multi-languages. Follow this guide to understand and config languages files

#### Setup Step :

* VSC, AS, IJ users need to install the plugins from the market.
* vs-code: https://marketplace.visualstudio.com/items?itemName=localizely.flutter-intl
* intelliJ / android studio: https://plugins.jetbrains.com/plugin/13666-flutter-intl

* others/CLI:

```
flutter pub global activate intl_utils

flutter pub global run intl_utils:generate
```

### Initialize plugins (IntelliJ reference)

1. Open Flutter intl in `Action`
2. Click on `Initialize for project`

![image](screenshots/intl_prompt.png)

3. To add / remove Locale, choose `Add Locale` / `Remove Locale`
4. Then it will promp which locale

![image](./screenshots/intl_add_locale.png)

**Current available locale is en, ms_MY**

Link library : https://pub.dev/packages/intl_utils

More details
in [confluence](https://setelnow.atlassian.net/wiki/spaces/SL/pages/596640430/Flutter+Project+Structure#2.12.1.-Set-up-your-app)


### Json parsing / serialization

This project is implementing [json_serializable](https://pub.dev/packages/json_serializable). It use build_runner to
generate files. If you make a change to these files, you need to re-run the generator using build_runner:

```
flutter pub run build_runner build
```

generator using build_runner and remove conflict file :

```
npm run generate
```

### Naming Convention / styles / Pedantic package

This project using pedantic package to use dart linter. Please
see [Naming Convention Page](https://gitlab.com/setel/flutter-concierge/-/wikis/Naming-Convention-and-Coding-Convention-Flutter)
for more detail about naming convention and dart linter

## Indentation.

- Auto indentation handled with git hook using [Lefthook](https://github.com/Arkweid/lefthook).
- For mac users, run `npm run setup` and you should be done. More details below.
- This project use npm for [Lefthook](https://github.com/Arkweid/lefthook) installation, to ease others getting it up
  running fast - run `npm install`
- After installation, run `npx lefthook install` to finish up installation.
- More info [here](https://github.com/Arkweid/lefthook/blob/master/docs/node.md).

# Assets

- Image is handled by [flutter_gen](https://pub.dev/packages/flutter_gen) for auto-complete and not have to deal with
  typing mistakes.
- To setup flutter_gen, run `npm run flutterGen`
- Run `fluttergen`

## Adding new Assets

- Add asset(s) into `assets/<asset types>`
- Run `fluttergen` in console
- New image(s) will appear in `lib/gen/assets`

## Remove Asset(s)

- Delete assets from `assets/<asset types>`
- Run `fluttergen` in console
- `lib/gen/assets` will be updated with currently available assets.
