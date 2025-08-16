import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ithera_app/core/assets/assets.dart';
import 'package:ithera_app/core/theme/app_colors.dart';
import 'package:ithera_app/core/theme/app_text_styles.dart';
import 'package:ithera_app/core/widgets/custom_button_large.dart';
import 'package:ithera_app/core/widgets/custom_drop_down_menu.dart';
import 'package:ithera_app/core/widgets/custom_form_field.dart';
import 'package:ithera_app/core/widgets/cutom_button_large_dimmide.dart';
import 'package:ithera_app/core/widgets/pop_up_dialog.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/settings/doctors_settings/managers/cubit/setting_cubit.dart';

class RefundBalanceScreen extends StatefulWidget {
  const RefundBalanceScreen({super.key});

  @override
  State<RefundBalanceScreen> createState() => _RefundBalanceScreenState();
}

class _RefundBalanceScreenState extends State<RefundBalanceScreen> {
  int? selectedWalletId;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onTextChanged);
    phoneController.addListener(_onTextChanged);
    reasonController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isFormValid = nameController.text.trim().isNotEmpty &&
          phoneController.text.trim().isNotEmpty &&
          selectedWalletId != -1;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(_onTextChanged);
    phoneController.removeListener(_onTextChanged);
    reasonController.removeListener(_onTextChanged);
    nameController.dispose();
    phoneController.dispose();
    reasonController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.primaryColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            spacing: 24.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'طلب سحب من رصيدك الحالي',
                style: AppTextStyles.font22Regular
                    .copyWith(color: AppColors.black),
              ),
              const CustomNormalRichText(
                ischoosen: false,
                firstText: 'المبلغ',
              ),
              CustomFormField(
                  controller: nameController,
                  // validate: conditionOfValidationName,

                  hintText: 'المبلغ الذي تم اضافته',
                  textInputType: TextInputType.number),
              const CustomNormalRichText(
                ischoosen: false,
                firstText: 'السبب',
              ),
              CustomFormField(
                  controller: reasonController,
                  // validate: conditionOfValidationName,

                  hintText: 'سبب السحب',
                  textInputType: TextInputType.number),
              const CustomNormalRichText(
                ischoosen: false,
                firstText: 'نوع المحفظة المراد ارجاع المبلغ عليها',
              ),
              CustomDropDownMenu(
                //  isLoading: state.citiesStatus == LookupStatus.loading,
                items: const [
                  'اورنج كاش',
                  'فودافون كاش',
                  'انستا باي',
                ],
                onChange: (newValue) {
                  setState(() {
                    selectedWalletId = newValue == 'اورنج كاش'
                        ? 1
                        : newValue == 'فودافون كاش'
                            ? 0
                            : 2;

                    _isFormValid = nameController.text.trim().isNotEmpty &&
                        phoneController.text.trim().isNotEmpty &&
                        reasonController.text.trim().isNotEmpty &&
                        selectedWalletId != -1;
                  });
                },
              ),
              const CustomNormalRichText(
                ischoosen: false,
                firstText: 'الرقم',
              ),
              CustomFormField(
                  controller: phoneController,
                  //  validate: conditionOfValidationPhone,
                  hintText: '01000000000',
                  textInputType: TextInputType.phone),
              _buildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    if (_isFormValid) {
      return BlocConsumer<SettingCubit, SettingState>(
        listener: (context, state) {
          if (state is SubmetDataWalletLoaded) {
            showDialog(
                context: context,
                builder: (BuildContext context) => PopUpDialogWithoutButtons(
                      title: 'تم إرسال طلبك بنجاح',
                      img: AssetsData.successSent,
                      subTitle:
                          'جارٍ مراجعته الآن، وسيتم تزويد محفظتك بالرصيد قريبًا.',
                      context: context,
                    )).then((_) {
              Navigator.pop(
                  context); // Pop current screen after dialog is closed
            });
          } else if (state is SubmetDataWalletError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: AppColors.error100,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is SubmetDataWalletLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
          return CustomButtonLarge(
            text: 'إرسال الطلب',
            textColor: Colors.white,
            function: () async {
              context.read<SettingCubit>().submitDoctorWalletRequest(
                    amount: int.parse(nameController.text),
                    walletType: selectedWalletId ?? -1,
                    mobileNumber: phoneController.text,
                    transferFromNumber: phoneController.text,
                    type: 1,
                    withdrawalReason: reasonController.text,
                  );
            },
            color: AppColors.primaryColor,
          );
        },
      );
    }

    return const CustomButtonLargeDimmed(
      text: 'إرسال الطلب',
    );
  }
}
