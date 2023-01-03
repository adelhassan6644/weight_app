import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utill/color_resources.dart';




class CustomTextFormField extends StatefulWidget {
  final String? hint;
  final bool? label;
  final TextInputType? type;
  final Function(String?)? onSave;
  final String? Function(String?)? valid;
  final AutovalidateMode? validationMode;
  final IconData? icon;
  final IconData ?eIcon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final String ?sIcon;
  final String ?tIcon;
  final  FocusNode ?focus;
  final bool? read;
  final bool? flag;
  final bool? line;
  final VoidCallback? edit;
  final bool? isEdit;
  final List<TextInputFormatter> ?formatter;
  final double ?hor;
  final int? maxLength;
  final Color? fieldColor;

   const CustomTextFormField({Key? key,  this.hint, this.onSave, this.onTap,
    this.icon, this.type,  this.valid,  this.controller, this.focus, this.sIcon, this.label,
     this.read, this.eIcon, this.edit, this.isEdit, this.line, this.flag, this.hor, this.validationMode,
     this.formatter, this.maxLength, this.tIcon, this.fieldColor,}) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  bool _isHidden = true;
  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    var outlineStyle =OutlineInputBorder(
      borderSide:  const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: BorderRadius.circular(12.0),
    );
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:widget.hor==null?0:widget.hor??0,vertical:2),
      child: Container(
        decoration: BoxDecoration(
          color:widget.fieldColor?? Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              blurRadius: 4,

              // offset: Offset(4, 10), // Shadow position
            ),  BoxShadow(
              color: Colors.black.withOpacity(0.09),
              blurRadius: 4,

              // offset: Offset(-4, -10), // Shadow position
            ),
          ],),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20,),
            TextFormField(
              // textAlign: TextAlign.left,
              onTap: widget.onTap,

              validator: widget.valid,
              controller: widget.controller,
              maxLength: widget.maxLength,

              focusNode: widget.focus,
              readOnly: widget.read==true?true:false,
              maxLines: widget.line==true?2:1,
              obscureText: widget.icon == Icons.lock_outline ? _isHidden : false,
              keyboardType:widget.type,
              inputFormatters:widget.formatter??[] ,
              onSaved: (widget.onSave),
              style: Theme.of(context).textTheme.headline2?.copyWith(color: Theme.of(context).textTheme.bodyText1?.color, fontSize: 15),
              decoration: InputDecoration(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child:widget.tIcon!=null? Padding(
                    padding: const EdgeInsets.only(right: 15,bottom: 15),
                    child: Image.asset(widget.tIcon!,height: 25,),
                  ):null,
                ),
                suffixIcon: widget.icon == Icons.lock_outline
                    ? IconButton(
                  splashColor: Colors.transparent,
                  onPressed: _visibility,
                  alignment: Alignment.center,
                  icon: _isHidden
                      ? const Icon(Icons.visibility_off,size: 25,color: ColorResources.DISABLE_COLOR,):
                  const Icon(Icons.visibility_rounded,size: 25,color:ColorResources.DISABLE_COLOR,),

                )
                    : Icon(widget.icon,color: Colors.grey,size: 20,),
                focusedBorder:outlineStyle,

                enabledBorder: outlineStyle,
                disabledBorder:outlineStyle,
                focusedErrorBorder: outlineStyle,
                errorBorder:outlineStyle ,

                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                border:outlineStyle,

                isDense: true,
                labelText: widget.hint,
                hintStyle: const TextStyle(color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.normal),

                fillColor:widget.fieldColor?? Colors.white ,
                labelStyle: Theme.of(context).textTheme.headline2?.copyWith(
                    color: ColorResources.COLOR_GREY,
                    fontSize: 15, fontWeight: FontWeight.bold),
                filled: true,

                prefixIconConstraints: const BoxConstraints(minWidth: 23, maxHeight: 20),

              ),
            ),
          ],
        ),
      ),
    );
  }
}
