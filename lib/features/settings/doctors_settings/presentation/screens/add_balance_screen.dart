import 'dart:io';
import 'dart:ui';

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
import 'package:ithera_app/features/add_files/manager/cubit/add_files_cubit.dart';
import 'package:ithera_app/features/auth/presentation/patient_auth/widgets/custom_normal_rich_text.dart';
import 'package:ithera_app/features/settings/doctors_settings/managers/cubit/setting_cubit.dart';
import 'package:ithera_app/features/settings/doctors_settings/presentation/widgets/custom_wallet_field_data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AddBalanceScreen extends StatelessWidget {
  const AddBalanceScreen({super.key});

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
      body: LoaderOverlay(
        useDefaultLoading: false,
        overlayColor: Colors.transparent,
        overlayWidgetBuilder: (_) {
          return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 2.5,
              sigmaY: 2.5,
            ),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          );
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              spacing: 24.h,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'أختار الطريقة المناسبة اليك',
                  style: AppTextStyles.font22Regular
                      .copyWith(color: AppColors.black),
                ),
                const CustomWalletFieldData(
                  walletNumber: '8-90121234-567-3456',
                  walletImg: AssetsData.orangeWallet,
                ),
                const CustomWalletFieldData(
                  walletNumber: '8-90121234-567-3456',
                  walletImg: AssetsData.vodafoneWallet,
                ),
                const CustomWalletFieldData(
                  walletNumber: '8-90121234-567-3456',
                  walletImg: AssetsData.instapayWallet,
                ),
                const CustomContainerDottedUploadImage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainerDottedUploadImage extends StatefulWidget {
  const CustomContainerDottedUploadImage({
    super.key,
  });

  @override
  State<CustomContainerDottedUploadImage> createState() =>
      _CustomContainerDottedUploadImageState();
}

class _CustomContainerDottedUploadImageState
    extends State<CustomContainerDottedUploadImage> {
  File? file;
  int selectedWalletId = -1;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    nameController.addListener(_onTextChanged);
    phoneController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    setState(() {
      _isFormValid = nameController.text.trim().isNotEmpty &&
          phoneController.text.trim().isNotEmpty &&
          file != null &&
          selectedWalletId != 0;
    });
  }

  @override
  void dispose() {
    nameController.removeListener(_onTextChanged);
    phoneController.removeListener(_onTextChanged);
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingCubit, SettingState>(
      listener: (context, state) {
        if (state is SubmetDataWalletLoaded) {
          context.read<AddFilesCubit>().addFile(
            rileId: 1,
            fileType: ['9'],
            files: [file!],
          ).then((_) {
            context.loaderOverlay.hide();

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
        return Column(
          spacing: 24.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: file != null
                  ? AlignmentDirectional.topStart
                  : AlignmentDirectional.bottomEnd,
              children: [
                InkWell(
                  onTap: () {
                    SettingCubit.get(context).pickCameraImage().then((_) {
                      setState(() {
                        file = SettingCubit.get(context).file;
                        _isFormValid = nameController.text.trim().isNotEmpty &&
                            phoneController.text.trim().isNotEmpty &&
                            file != null &&
                            selectedWalletId != 0;
                      });
                    });
                  },
                  child: DottedBorder(
                    options: const RectDottedBorderOptions(
                      color: AppColors.blueLight,
                      strokeWidth: 1,
                      dashPattern: [20, 15],
                    ),
                    child: Container(
                      height: 130.h,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: file != null
                          ? Image.file(
                              file!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload_sharp,
                                  size: 50.h,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(height: 10.h),
                                Text('ارفع صورة إيصال التحويل',
                                    style: AppTextStyles.font16Regular.copyWith(
                                      color: AppColors.black,
                                    )),
                              ],
                            ),
                    ),
                  ),
                ),
                file != null
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            file = null;
                          });
                        },
                        icon: CircleAvatar(
                          radius: 13.h,
                          backgroundColor: AppColors.error100,
                          child: Icon(
                            color: AppColors.white,
                            Icons.close,
                            size: 15.h,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
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
              firstText: 'نوع المحفظة',
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
                      file != null &&
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
            _buildLoginButton(state),
          ],
        );
      },
    );
  }

  Widget _buildLoginButton(SettingState state) {
    if (state is SubmetDataWalletLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      );
    }
    if (_isFormValid) {
      return CustomButtonLarge(
        text: 'إرسال الطلب',
        textColor: Colors.white,
        function: () async {
          context.loaderOverlay.show();

          context.read<SettingCubit>().submitDoctorWalletRequest(
                amount: int.parse(nameController.text),
                walletType: selectedWalletId,
                mobileNumber: phoneController.text,
                transferFromNumber: phoneController.text,
                type: 0,
              );
        },
        color: AppColors.primaryColor,
      );
    }

    return const CustomButtonLargeDimmed(
      text: 'إرسال الطلب',
    );
  }
}
