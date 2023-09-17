import 'package:flutter/material.dart';
import 'package:livex/utilis/colors_utilis.dart';

Image logoWidget(String imagename){
  return Image.asset(
    imagename,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,);
}
Text txtsimple(String txt,TextEditingController cos){
  return Text(

    cos.text=txt,


    style: TextStyle(
    fontSize: 16.0,// Align text to the left

      // Change the font size to 24.0
  ),

  );


}

TextField reusableTextField(String text, IconData icon,bool ispasswordtype,TextEditingController controller ){
  return TextField(controller: controller,
  obscureText: ispasswordtype,
  autocorrect: ispasswordtype,
  cursorColor: Colors.white,
  style: TextStyle(color: Colors.white.withOpacity(0.9)),
  decoration: InputDecoration(prefixIcon:Icon(icon, color: Colors.white70,) ,
  labelText: text,
  labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
  filled: true,
  floatingLabelBehavior: FloatingLabelBehavior.never,
  fillColor: Colors.white.withOpacity(0.3),
  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0),borderSide: const BorderSide(width: 0,style: BorderStyle.none)),
  ),
    keyboardType: ispasswordtype ? TextInputType.visiblePassword:TextInputType.emailAddress,
  );
}
Container signInSignUpButton(
BuildContext context,bool islogin,Function ontap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin:const EdgeInsets.fromLTRB(0, 10, 0, 20) ,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){ontap();},
      child: Text(
        islogin?'Se connecter ':"S'inscrire",
        style: const TextStyle(
          color: Colors.black87,fontWeight: FontWeight.bold,fontSize: 16),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
  if(states.contains(MaterialState.pressed)){
    return Colors.black87;
  }
  return Colors.white;
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)))),
      ),
    );

}