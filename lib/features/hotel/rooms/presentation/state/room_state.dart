import '../../domain/entities/room_entity.dart';


import 'package:equatable/equatable.dart';
import '../../domain/entities/room_entity.dart';

class RoomState extends Equatable {
  final bool isLoading;
  final List<RoomEntity> all;
  final List<RoomEntity> filtered;
  final String searchQuery;

  const RoomState({
    this.isLoading = false,
    this.all = const [],
    this.filtered = const [],
    this.searchQuery = '',
  });

  RoomState copyWith({
    bool? isLoading,
    List<RoomEntity>? all,
    List<RoomEntity>? filtered,
    String? searchQuery,
  }) {
    return RoomState(
      isLoading: isLoading ?? this.isLoading,
      all: all ?? this.all,
      filtered: filtered ?? this.filtered,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [isLoading, all, filtered, searchQuery];
}


// class RoomState {
//   final bool isLoading;
//   final List<RoomEntity> all;
//   final List<RoomEntity> filtered;
//   final String searchQuery;

//   const RoomState({
//     this.isLoading = false,
//     this.all = const [],
//     this.filtered = const [],
//     this.searchQuery = '',
//   });

//   RoomState copyWith({
//     bool? isLoading,
//     List<RoomEntity>? all,
//     List<RoomEntity>? filtered,
//     String? searchQuery,
//   }) {
//     return RoomState(
//       isLoading: isLoading ?? this.isLoading,
//       all: all ?? this.all,
//       filtered: filtered ?? this.filtered,
//       searchQuery: searchQuery ?? this.searchQuery,
//     );
//   }
// }
