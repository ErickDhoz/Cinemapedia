import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';


class ActorMapper {
  static Actor castToEntitys(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != null
      ?'http://image.tmdb.org/t/p/w500${cast.profilePath}'
      :'https://uxwing.com/wp-content/themes/uxwing/download/peoples-avatars/no-profile-picture-icon.png',
      character: cast.character
      );
}
