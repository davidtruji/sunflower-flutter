import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sunflower_flutter/domain/model/unsplash_search_result.dart';
import 'package:sunflower_flutter/domain/repository/unsplash_repository.dart';
import 'package:sunflower_flutter/view/bloc/gallery_state.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit(this._unsplashRepository) : super(GalleryState.empty());

  final UnsplashRepository _unsplashRepository;

  void setQuery({required String query}) {
    emit(state.copyWith(query: query));
  }

  void fetchGallery(int page) async {
    UnsplashSearchResult unsplashSearchResult =
        await _unsplashRepository.fetchGallery(state.query, page);

    emit(
        state.copyWith(page: page, unsplashSearchResult: unsplashSearchResult));
  }

  void launchURL(String username) {
    launchUrl(Uri.parse(
        "https://unsplash.com/$username?utm_source=sunflower&utm_medium=referral"));
  }

}
