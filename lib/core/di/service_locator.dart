import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ecommerce/features/profile/data/datasources/profile_remote_datasource.dart';
import 'package:ecommerce/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:ecommerce/features/profile/domain/repositories/profile_repository.dart';
import 'package:ecommerce/features/profile/domain/usecases/get_profile.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/cart/data/datasources/cart_local_datasource.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_to_cart.dart';
import '../../features/cart/domain/usecases/get_cart_items.dart';
import '../../features/cart/domain/usecases/remove_from_cart.dart';
import '../../features/cart/domain/usecases/update_cart_quantity.dart';
import '../../features/products/domain/usecases/get_product_by_id.dart';
import '/core/network/api_client.dart';
import '/core/network/network_info.dart';
import '/core/utils/preferences_helper.dart';
import '/features/auth/data/datasources/auth_local_datasource.dart';
import '/features/auth/data/datasources/auth_remote_datasource.dart';
import '/features/auth/data/repositories/auth_repository_impl.dart';
import '/features/auth/domain/repositories/auth_repository.dart';
import '/features/auth/domain/usecases/login_usecase.dart';
import '/features/products/data/datasources/product_local_datasource.dart';
import '/features/products/data/datasources/product_remote_datasource.dart';
import '/features/products/data/repositories/product_repository_impl.dart';
import '/features/products/domain/repositories/product_repository.dart';
import '/features/products/domain/usecases/get_products.dart';

/// Service Locator instance

final sl = GetIt.instance;

Future<void> initDependencies() async {
  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl()),
  );

  sl.registerLazySingleton<PrefHelper>(() => PrefHelper.instance);
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(dio: sl(), networkInfo: sl(), prefHelper: sl()),
  );

  // Data sources handle the actual data fetching (API, Database, Cache)

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetProducts(sl()));
  sl.registerLazySingleton(() => GetProductById(sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(prefHelper: sl()),
  );

  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      authLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton(() => LoginUseCase(authRepository: sl()));

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(localDataSource: sl(), productRepository: sl()),
  );

  sl.registerLazySingleton(() => AddToCart(sl()));
  sl.registerLazySingleton(() => GetCartItems(sl()));

  /// UpdateCartQuantity - Use case to update cart item quantity
  /// Depends on: CartRepository
  sl.registerLazySingleton(() => UpdateCartQuantity(sl()));

  /// RemoveFromCart - Use case to remove item from cart
  /// Depends on: CartRepository
  sl.registerLazySingleton(() => RemoveFromCart(sl()));

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(apiClient: sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  sl.registerLazySingleton(() => GetProfile(sl()));
}

/// Reset all dependencies (useful for testing)
/// Call this in setUp() of your tests
Future<void> resetDependencies() async {
  await sl.reset();
}
