import 'package:flutter/material.dart';
import 'package:task_manager/utils/constants.dart';

Widget formField({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  ValueChanged? onSubmit,
  required String hint,
  required IconData prefix,
  IconData? suffix,
  FormFieldValidator? valid,
  ValueChanged? onchange,
  GestureTapCallback? onTap,
  VoidCallback? suffixPressed,
  bool readOnly = false,
  final inputBorder,
  final Icon? icon,
}) =>
    TextFormField(
      maxLines: isPassword ? 1 : null,
      readOnly: readOnly ? true : false,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onchange,
      onTap: onTap,
      onTapOutside: (Event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      validator: valid,
      decoration: InputDecoration(
        prefixIcon: icon,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        hoverColor: kPrimaryColor,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0xFFF6F6F6), width: 0)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Color(0xFFF6F6F6),
          ),
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
    );
Widget headContainer(Size size, double height) {
  return Stack(
    children: [
      Container(
        width: size.width,
        height: size.height / height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.blue, Colors.blue[900]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              tileMode: TileMode.clamp),
        ),
      ),
      CustomPaint(
        painter: WavePainter(),
      )
    ],
  );
}
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(51.8105, -49.8172);
    path.cubicTo(37.9939, -41.7233, 10.6875, -22.2542, 1.56718, -15.6997);
    path.cubicTo(0.595277, -15.0077, -0.143367, -14.1136, -0.633201, -13.0173);
    path.cubicTo(-1.13081, -11.9287, -1.30964, -10.7858, -1.18523, -9.58841);
    path.cubicTo(0.416452, 6.49069, 10.6175, 69.2365, 73.8531, 123.593);
    path.cubicTo(147.064, 186.494, 184.743, 156.249, 225.119, 149.274);
    path.cubicTo(265.496, 142.3, 288.612, 150.503, 311.082, 178.369);
    path.cubicTo(332.215, 204.587, 359.35, 205.8, 384.612, 195.762);
    path.cubicTo(385.384, 195.474, 385.926, 195.086, 386.486, 194.588);
    path.cubicTo(387.038, 194.098, 387.504, 193.523, 387.862, 192.87);
    path.cubicTo(388.227, 192.224, 388.484, 191.532, 388.616, 190.794);
    path.cubicTo(388.756, 190.063, 388.756, 189.332, 388.647, 188.586);
    path.lineTo(385.506, 166.675);

    path.cubicTo(385.389, 165.796, 385.102, 164.98, 384.659, 164.21);
    path.cubicTo(384.215, 163.456, 383.64, 162.803, 382.94, 162.259);
    path.cubicTo(382.24, 161.73, 381.463, 161.341, 380.608, 161.108);
    path.cubicTo(382.24, 161.73, 381.463, 161.341, 380.608, 161.108);
    path.cubicTo(379.752, 160.875, 378.897, 160.813, 378.018, 160.929);
    path.cubicTo(370.531, 161.886, 357.064, 161.093, 340.558, 148.893);
    path.cubicTo(314.931, 129.984, 296.325, 90.2917, 258.218, 89.4908);
    path.cubicTo(220.112, 88.69, 196.53, 99.4897, 153.144, 85.541);
    path.cubicTo(107.994, 71.0247, 71.2484, -20.116, 61.5217, -46.3106);
    path.cubicTo(61.3506, -46.7771, 61.1329, -47.2126, 60.8608, -47.6246);
    path.cubicTo(60.5964, -48.8445, 60.2932, -48.4255, 59.9433, -48.7754);
    path.cubicTo(59.5934, -49.1253, 59.2124, -49.4285, 58.8004, -49.6851);
    path.cubicTo(58.3805, -49.9494, 57.9451, -50.1671, 57.4786, -50.3382);
    path.cubicTo(57.0198, -50.5015, 56.5378, -50.6103, 56.0479, -50.6803);
    path.cubicTo(55.5659, -50.7425, 55.076, -50.7503, 54.5784, -50.7036);
    path.cubicTo(54.0964, -50.657, 53.6143, -50.5637, 53.1478, -50.4082);
    path.cubicTo(52.6735, -50.2604, 52.2303, -50.066, 51.8105, -49.8172);
    path.cubicTo(50.6735, -49.2604, 52.2303, -49.066, 48.8105, -47.8172);
    path.cubicTo(50.6735, -48.2604, 50.2303, -47.066, 46.8105, -47.8172);
    path.cubicTo(50.6735, -47.2604, 48.2303, -45.066, 44.8105, -45.8172);

    path.close();
    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Colors.white.withOpacity(0.1);
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
Widget customButton({
  double width = double.infinity,
  Color background = kPrimaryColor,
  required VoidCallback function,
  required String text,
  required final TextStyle style,
  bool isUppercase = true,
  double radius = 0.0,
}) =>
    SizedBox(
      height: 45,
      child: MaterialButton(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        onPressed: function,
        child: Text(text, style: style),
      ),
    );
