import 'package:get_it/get_it.dart';


import '../../data/datasources/mpesa_data_sources.dart';
import '../../data/repositories/payment_repositories.dart';
import '../../domain/repositories/payment_repositories.dart';
import '../../domain/usecase/processs_payment_usecase.dart';
import '../../presentations/providers/payment_providers.dart';

final sl = GetIt.instance;

void init() {
  // Presentation layer
  sl.registerFactory(
        () => PaymentProvider(sl()),
  );

  // Domain layer - Use cases
  sl.registerLazySingleton(() => ProcessPaymentUseCase(sl()));

  // Domain layer - Repositories
  sl.registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(sl()),
  );

  // Data layer - Data sources
  sl.registerLazySingleton<MpesaDataSource>(
        () => MpesaDataSourceImpl(),
  );

  // Initialize M-PESA
  final mpesaDataSource = sl<MpesaDataSource>() as MpesaDataSourceImpl;
  mpesaDataSource.initialize();
}