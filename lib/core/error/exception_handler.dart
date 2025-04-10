import 'package:google_maps_mac_intergrator/core/blocs/generic_cubit/generic_cubit.dart';

class ExceptionHandler {
  static T? handleCubitException<T>(GenericCubit cubit, T Function() call) {
    try {
      return call();
    } catch (e) {
      cubit.onErrorState(e.toString());
    }
    return null;
  }
}
