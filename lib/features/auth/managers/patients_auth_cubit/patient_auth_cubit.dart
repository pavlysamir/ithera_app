import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'patient_auth_state.dart';

class PatientAuthCubit extends Cubit<PatientAuthState> {
  PatientAuthCubit() : super(PatientAuthInitial());

  // void chooseItem(String item) => emit(PatientAuthState(item: item)); // choose item
}
