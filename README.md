# 🛍️ E-Commerce Flutter Application

A production-ready e-commerce mobile application built with **Flutter** following **Clean Architecture** principles, **SOLID** design patterns, and modern state management using **Riverpod**. Where i prefer feature layer pattern and i completely create the architecture and create the module using **SSL_CLI**.

## 📋 Table of Contents

- [Architecture Overview](#-architecture-overview)
- [Key Features](#-key-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Design Patterns](#-design-patterns)
- [State Management](#-state-management)
- [Dependency Injection](#-dependency-injection)
- [Getting Started](#-getting-started)
- [Build & Run](#-build--run)
- [Code Quality](#-code-quality)

---

## 🏗️ Architecture Overview

This project implements **Clean Architecture** with clear separation of concerns across three layers:

### **1. Presentation Layer**
- **UI Components**: Pages, Widgets, Components
- **State Management**: Riverpod providers with code generation
- **Navigation**: Centralized navigation management
- **Responsive UI**: Flutter ScreenUtil for adaptive layouts

### **2. Domain Layer**
- **Entities**: Pure business objects
- **Use Cases**: Single-responsibility business logic
- **Repository Interfaces**: Abstract contracts for data operations
- **Failure Handling**: Type-safe error handling with `Either<Failure, Success>`

### **3. Data Layer**
- **Repository Implementations**: Concrete data operations
- **Data Sources**: Remote (API) and Local (Cache/SharedPreferences)
- **Models**: Data transfer objects with JSON serialization
- **Network Client**: Dio-based HTTP client with interceptors

---

## ✨ Key Features

### **Implemented Features**
- ✅ **Authentication System** - Login with token management
- ✅ **Product Catalog** - Browse products with pagination
- ✅ **Product Search** - Real-time search functionality
- ✅ **Category Filtering** - Filter products by categories
- ✅ **Shopping Cart** - Add, update, remove cart items (local storage)
- ✅ **User Profile** - View and manage user information
- ✅ **Network Monitoring** - Real-time connectivity detection
- ✅ **Multi-language Support** - i18n with English and Bengali
- ✅ **Flavor Configuration** - DEV, STAGE, LIVE environments
- ✅ **Responsive Design** - Adaptive UI for all screen sizes

### **Architecture Highlights**
- 🎯 **Clean Architecture** - Separation of concerns with clear boundaries
- 🔄 **Reactive State Management** - Riverpod with code generation
- 🧪 **Testable Code** - Dependency injection for easy testing
- 🚀 **Scalable Structure** - Feature-based modular organization
- 🔐 **Secure Storage** - Token management with SharedPreferences
- 🌐 **Network Resilience** - Offline support with caching
- 📱 **Modern UI** - Reusable global components

---

## 🛠️ Tech Stack

### **Core**
- **Flutter SDK**: ^3.9.2
- **Dart**: ^3.9.2

### **State Management**
- **flutter_riverpod**: ^3.0.1
- **riverpod_annotation**: ^3.0.1
- **riverpod_generator**: ^3.0.1

### **Networking**
- **dio**: ^5.9.0 - HTTP client
- **connectivity_plus**: ^7.0.0 - Network monitoring

### **Local Storage**
- **shared_preferences**: ^2.5.3 - Persistent key-value storage

### **Functional Programming**
- **dartz**: ^0.10.1 - Either, Option, and functional utilities
- **equatable**: ^2.0.7 - Value equality

### **Dependency Injection**
- **get_it**: ^8.2.0 - Service locator pattern

### **UI & Styling**
- **flutter_screenutil**: ^5.9.3 - Responsive design
- **google_fonts**: ^6.2.1 - Custom fonts
- **flutter_svg**: ^2.2.1 - SVG support

### **Localization**
- **intl**: ^0.20.2
- **flutter_localizations**: SDK

### **Development Tools**
- **build_runner**: ^2.4.8 - Code generation
- **custom_lint**: ^0.8.0 - Custom linting rules
- **riverpod_lint**: ^3.0.1 - Riverpod-specific linting

---

## 📁 Project Structure

```
android/
├── app/
│   ├── build.gradle.kts            # flavor and signing config setup 

lib/
├── core/                           # Core utilities and shared resources
│   ├── constants/                  # App-wide constants
│   │   ├── api_urls.dart          # API endpoint management
│   │   └── app_constants.dart     # General constants
│   ├── di/                        # Dependency Injection
│   │   └── service_locator.dart   # GetIt service locator setup
│   ├── error/                     # Error handling
│   │   ├── exceptions.dart        # Custom exceptions
│   │   └── failures.dart          # Failure types (Server, Network, Cache, etc.)
│   ├── models/                    # Shared models
│   │   └── paginated_response.dart
│   ├── network/                   # Network layer
│   │   ├── api_client.dart        # Dio HTTP client wrapper
│   │   └── network_info.dart      # Connectivity checker
│   ├── presentation/              # Shared UI components
│   │   ├── mixins/                # Reusable UI mixins
│   │   └── widgets/               # Global reusable widgets
│   │       ├── global_appbar.dart
│   │       ├── global_button.dart
│   │       ├── global_dropdown.dart
│   │       ├── global_image_loader.dart
│   │       ├── global_loader.dart
│   │       ├── global_network_dialog.dart
│   │       ├── global_network_listener.dart
│   │       ├── global_quantity_btn.dart
│   │       ├── global_text.dart
│   │       └── global_text_form_field.dart
│   ├── routes/                    # Navigation
│   │   └── navigation.dart        # Centralized navigation
│   ├── theme/                     # App theming
│   │   └── theme_manager.dart     # Theme configuration
│   ├── usecases/                  # Base use case
│   │   └── usecase.dart           # UseCase interface
│   └── utils/                     # Utility functions
│       ├── app_version.dart       # Version management
│       ├── extension.dart         # Dart extensions
│       ├── preferences_helper.dart # SharedPreferences wrapper
│       └── styles/                # Style utilities
│
├── features/                      # Feature modules (Clean Architecture)
│   ├── auth/                      # Authentication feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── auth_local_datasource.dart    # Local auth storage
│   │   │   │   └── auth_remote_datasource.dart   # API calls
│   │   │   ├── models/
│   │   │   │   ├── login_model.dart              # Request model
│   │   │   │   └── login_response.dart           # Response model
│   │   │   └── repositories/
│   │   │       └── auth_repository_impl.dart     # Repository implementation
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── login_entity.dart             # Business entity
│   │   │   ├── repositories/
│   │   │   │   └── auth_repository.dart          # Repository interface
│   │   │   └── usecases/
│   │   │       └── login_usecase.dart            # Login business logic
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── login_page.dart               # Login UI
│   │       ├── providers/
│   │       │   └── auth_provider.dart            # Riverpod state management
│   │       └── widgets/                          # Feature-specific widgets
│   │
│   ├── products/                  # Product catalog feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   ├── product_local_datasource.dart # Cache layer
│   │   │   │   └── product_remote_datasource.dart # API layer
│   │   │   ├── models/
│   │   │   │   ├── product_model.dart
│   │   │   │   └── paginated_products.dart
│   │   │   └── repositories/
│   │   │       └── product_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── product_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── product_repository.dart
│   │   │   └── usecases/
│   │   │       ├── get_products.dart             # Fetch products with pagination
│   │   │       └── get_product_by_id.dart        # Fetch single product
│   │   └── presentation/
│   │       ├── pages/
│   │       │   ├── product_list_page.dart
│   │       │   └── product_detail_page.dart
│   │       ├── providers/
│   │       │   └── product_provider.dart         # Product state management
│   │       └── widgets/
│   │           └── product_card.dart
│   │
│   ├── cart/                      # Shopping cart feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── cart_local_datasource.dart    # Local cart storage
│   │   │   ├── models/
│   │   │   │   └── cart_item_model.dart
│   │   │   └── repositories/
│   │   │       └── cart_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── cart_item_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── cart_repository.dart
│   │   │   └── usecases/
│   │   │       ├── add_to_cart.dart
│   │   │       ├── get_cart_items.dart
│   │   │       ├── update_cart_quantity.dart
│   │   │       └── remove_from_cart.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── cart_page.dart
│   │       ├── providers/
│   │       │   └── cart_provider.dart
│   │       └── widgets/
│   │           └── cart_item_widget.dart
│   │
│   ├── profile/                   # User profile feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   │   └── profile_remote_datasource.dart
│   │   │   ├── models/
│   │   │   │   └── profile_model.dart
│   │   │   └── repositories/
│   │   │       └── profile_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── profile_entity.dart
│   │   │   ├── repositories/
│   │   │   │   └── profile_repository.dart
│   │   │   └── usecases/
│   │   │       └── get_profile.dart
│   │   └── presentation/
│   │       ├── pages/
│   │       │   └── profile_page.dart
│   │       ├── providers/
│   │       │   └── profile_provider.dart
│   │       └── widgets/
│   │
│   └── dashboard/                 # Main dashboard
│       └── presentation/
│           ├── pages/
│           │   └── dashboard_page.dart
│           ├── providers/
│           │   └── dashboard_provider.dart
│           └── widgets/
│
├── l10n/                          # Localization files
│   ├── app_en.arb                 # English translations
│   ├── app_bn.arb                 # Bengali translations
│   └── app_localizations.dart     # Generated localization class
│
└── main.dart                      # App entry point

assets/
├── images/                        # PNG/JPEG images
├── svg/                          # SVG icons
└── fonts/                        # Custom fonts

test/                             # Unit & Widget tests
└── widget_test.dart
```

---

## 🎨 Design Patterns

### **1. Repository Pattern**
Abstracts data sources and provides a clean API for data access.

```dart
// Domain layer - Abstract contract
abstract class ProductRepository {
  Future<Either<Failure, PaginatedProducts>> getProducts({
    required int limit,
    required int skip,
    String? searchQuery,
    String? category,
  });
}

// Data layer - Concrete implementation
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, PaginatedProducts>> getProducts(...) async {
    if (await networkInfo.isConnected) {
      // Fetch from API
      final products = await remoteDataSource.getProducts(...);
      await localDataSource.cacheProducts(products);
      return Right(products);
    } else {
      // Fetch from cache
      final cachedProducts = await localDataSource.getCachedProducts();
      return Right(cachedProducts);
    }
  }
}
```

### **2. Use Case Pattern**
Encapsulates business logic in single-responsibility classes.

```dart
class LoginUseCase implements UseCase<LoginResponse, LoginParams> {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await authRepository.login(params.loginEntity);
  }
}
```

### **3. Dependency Injection (Service Locator)**
Centralized dependency management using GetIt.

```dart
final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Network
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<ApiClient>(() => ApiClient(dio: sl()));
  
  // Data Sources
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiClient: sl()),
  );
  
  // Repositories
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  
  // Use Cases
  sl.registerLazySingleton(() => GetProducts(sl()));
}
```

### **4. Either Pattern (Functional Error Handling)**
Type-safe error handling using `dartz` package.

```dart
// Success case
return Right(products);

// Failure case
return Left(ServerFailure(message: 'Failed to fetch products'));

// Usage in UI
result.fold(
  (failure) => showError(failure.message),
  (products) => displayProducts(products),
);
```

---

## 🔄 State Management

### **Riverpod with Code Generation**

This project uses **Riverpod 3.0** with code generation for type-safe, boilerplate-free state management.

#### **Example: Product Provider**

```dart
@riverpod
class ProductNotifier extends _$ProductNotifier {
  int _currentSkip = 0;

  @override
  FutureOr<ProductState> build() {
    return _fetchFirstPage();
  }

  Future<ProductState> _fetchFirstPage() async {
    final getProductsUseCase = sl<GetProducts>();
    _currentSkip = 0;

    final result = await getProductsUseCase(
      GetProductsParams(limit: 30, skip: 0),
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (paginatedProducts) {
        _currentSkip = paginatedProducts.skip;
        return ProductState(
          products: paginatedProducts.products,
          hasMore: paginatedProducts.hasMore,
          isLoadingMore: false,
        );
      },
    );
  }

}
```

#### **Usage in UI**

```dart
class ProductListPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productState = ref.watch(productNotifierProvider);

    return productState.when(
      data: (state) => ListView.builder(
        itemCount: state.products.length,
        itemBuilder: (context, index) => ProductCard(
          product: state.products[index],
        ),
      ),
      loading: () => CircularProgressIndicator(),
      error: (error, stack) => ErrorWidget(error),
    );
  }
}
```

---

## 💉 Dependency Injection

### **Service Locator Pattern with GetIt**

All dependencies are registered in `service_locator.dart` and accessed via the `sl` instance.

#### **Benefits**
- ✅ **Testability**: Easy to mock dependencies in tests
- ✅ **Decoupling**: Components don't create their own dependencies
- ✅ **Single Source of Truth**: Centralized dependency configuration
- ✅ **Lazy Loading**: Dependencies created only when needed

#### **Registration Types**
```dart
// Singleton - Created once and reused
sl.registerSingleton<SharedPreferences>(sharedPreferences);

// Lazy Singleton - Created on first access
sl.registerLazySingleton<ApiClient>(() => ApiClient(dio: sl()));

// Factory - New instance every time
sl.registerFactory<LoginUseCase>(() => LoginUseCase(repository: sl()));
```

---

## 🚀 Getting Started

### **Prerequisites**
- Flutter SDK: ^3.9.2
- Dart SDK: ^3.9.2
- IDE: VS Code / Android Studio / Windsurf

### **Installation**

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/ecommerce.git
cd ecommerce
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Generate code (Riverpod providers)**
```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🏃 Build & Run

### **Development Build**
```bash
flutter run --dart-define=flavorType=DEV 
```

### **Production Build**
```bash
flutter run --dart-define=flavorType=LIVE   
```

### **Build APK with Flavor**
Using the custom SSL CLI tool:
Create bydefault code obfuscation
```bash
ssl_cli build apk --DEV
ssl_cli build apk --LIVE   
```

### **Run Tests**
```bash
flutter test
```

---

## 🔍 Code Quality

### **Linting**
- **flutter_lints**: Standard Flutter linting rules
- **custom_lint**: Custom project-specific rules
- **riverpod_lint**: Riverpod-specific best practices

### **Code Generation**
```bash
# Watch mode - auto-regenerate on file changes
dart run build_runner watch --delete-conflicting-outputs

# One-time generation
dart run build_runner build --delete-conflicting-outputs
```

### **Analysis**
```bash
flutter analyze
```

---

## 📝 Coding Conventions

### **Global Components**
This project follows a consistent pattern for reusable UI components:

- **Text**: Use `GlobalText` widget
- **TextFormField**: Use `GlobalTextFormField` widget
- **Dropdown**: Use `GlobalDropdown` widget
- **Image**: Use `GlobalImageLoader` widget
- **SVG**: Use `GlobalSvgLoader` widget (not implemented yet, use flutter_svg)
- **Button**: Use `GlobalButton` widget
- **AppBar**: Use `GlobalAppBar` widget

### **Asset Management**
- **Images (PNG/JPEG)**: Place in `assets/images/`
- **SVG Icons**: Place in `assets/svg/`
- **Fonts**: Place in `assets/fonts/`

### **Responsive Design**
- Use `flutter_screenutil` for responsive sizing
- Global widgets already handle `.sp` for text sizing
- Don't add `.sp` when using `GlobalText`

---

## 🎯 Key Architectural Decisions

### **Why Clean Architecture?**
- **Testability**: Each layer can be tested independently
- **Maintainability**: Clear separation of concerns
- **Scalability**: Easy to add new features without affecting existing code
- **Flexibility**: Easy to swap implementations (e.g., change API client)

### **Why Riverpod?**
- **Type Safety**: Compile-time error checking
- **No BuildContext**: Access state from anywhere
- **Testability**: Easy to mock providers
- **Performance**: Automatic optimization and caching
- **Code Generation**: Reduces boilerplate

### **Why GetIt?**
- **Simple**: Easy to understand and use
- **Flexible**: Supports multiple registration types
- **Testable**: Easy to reset and mock dependencies
- **No Magic**: Explicit dependency registration

