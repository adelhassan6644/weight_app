import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_app/utill/validation.dart';
import '../../provider/weight_controller.dart';
import 'custom_text_form_field.dart';


class AddBottomSheet extends StatefulWidget {
  bool isEdit ;
  String? id ;

   AddBottomSheet({
     this.id,
     this.isEdit = false,
    Key? key,
  }) : super(key: key);

  @override
  _AddBottomSheetState createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController _addWeightController ;
  late TextEditingController _editWeightController ;

  @override
  void initState() {
    super.initState();
    _addWeightController = TextEditingController();
    _editWeightController = TextEditingController();
  }

  @override
  void dispose() {
    _addWeightController = TextEditingController();
    _editWeightController = TextEditingController();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: ListView(
              shrinkWrap: true,
              children: [
                CustomTextFormField(
                  controller:  widget.isEdit? _editWeightController:_addWeightController,
                  hint: widget.isEdit?
                  "Edit Weight": "Add Weight",
                  label: true,
                  fieldColor: Colors.grey.shade300,
                  icon: Icons.numbers_rounded,
                  valid: Validations.any,
                  type: TextInputType.number,
                ),
                const SizedBox(
                  height: 15,
                ),
                Consumer<WeightController>(
                    builder: (context, weightController, child) {
                    return InkWell(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          FocusScope.of(context).unfocus();
                          widget.isEdit?
                          await  weightController.editWeight(weight:double.parse( _editWeightController.text.trim()),cont: context,docRef:widget.id.toString()):
                          await  weightController.addWeight(
                              weight:double.parse( _addWeightController.text.trim()),cont: context);

                          Navigator.of(context).pop();
                           weightController.nonBottomSheetMode();
                          formKey.currentState!.save();
                        }
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 7,
                                  offset: const Offset(0, 3))
                            ],
                            shape: BoxShape.rectangle),
                        child:  Center(
                          child: Text(
                            widget.isEdit?
                            "Edit Weight": "Add Weight",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    );
                }),
              ],
            ),
          ),
        ));
  }



}
