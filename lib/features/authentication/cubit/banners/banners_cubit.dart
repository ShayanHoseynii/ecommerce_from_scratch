import 'package:bloc/bloc.dart';
import 'package:cwt_starter_template/data/repositories/banners/banners_repository.dart';
import 'package:cwt_starter_template/features/authentication/cubit/banners/banners_state.dart';

class BannerCubit extends Cubit<BannerState> {
  final BannersRepository _bannerRepository;

  BannerCubit(this._bannerRepository) : super(BannerInitial());

  /// Fetches banners from the data source.
  Future<void> fetchBanners() async {
    try {
      emit(BannerLoading());

      // Fetch banners from the repository
      final banners = await _bannerRepository.getBanners();

      emit(BannerLoaded(banners));
    } catch (e) {
      emit(BannerFailure(e.toString()));
    }
  }
}