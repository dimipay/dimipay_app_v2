import 'package:dimipay_app_v2/app/pages/register_card/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterCardPage extends GetView<RegisterCardPageController> {
  const RegisterCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PaymentPage')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Form(
                    key: controller.formKey,
                    child: FocusScope(
                      node: controller.formFocusScopeNode,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            enableInteractiveSelection: false,
                            controller: controller.nameFieldController,
                            decoration: const InputDecoration(
                              labelText: '카드 이름',
                              hintText: '카드 이름을 입력해주세요',
                            ),
                            maxLength: 20,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            enableInteractiveSelection: false,
                            controller: controller.cardNumberFieldController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: '카드 번호',
                              hintText: '0000-0000-0000-0000',
                            ),
                            maxLength: 19,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Flexible(
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  controller: controller.expiredDateFieldController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: '유효기간',
                                    hintText: 'MM/YY',
                                  ),
                                  maxLength: 5,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Flexible(
                                child: TextFormField(
                                  enableInteractiveSelection: false,
                                  controller: controller.ownerPersonalNumFieldController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: '생년월일 / 사업자번호',
                                    hintText: '6 / 10자리',
                                  ),
                                  maxLength: 10,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            enableInteractiveSelection: false,
                            controller: controller.passwordFieldController,
                            keyboardType: TextInputType.number,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: '카드 비밀번호',
                              hintText: '앞 2자리',
                            ),
                            maxLength: 2,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            enableInteractiveSelection: false,
                            controller: controller.ownerNameFieldController,
                            decoration: const InputDecoration(
                              labelText: '카드 소유자 이름',
                              hintText: '카드에 적혀있는 영문으로 입력해주세요',
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            TextButton(onPressed: controller.addPaymentMethod, child: const Text('추가하기')),
          ],
        ),
      ),
    );
  }
}