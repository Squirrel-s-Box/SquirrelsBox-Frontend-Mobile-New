part of 'box_container.dart';


class BoxPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final lapizLowCollor = Paint();
    lapizLowCollor.color = AppColors.midOrange;
    lapizLowCollor.strokeWidth = 5;
    lapizLowCollor.style = PaintingStyle.fill;

    final lapizHighCollor = Paint();
    lapizHighCollor.color = AppColors.cartoon;
    lapizHighCollor.strokeWidth = 5;
    lapizHighCollor.style = PaintingStyle.fill;

    final pathSuperior = Path();
    final pathDerecho = Path();
    final pathInferior = Path();
    final pathIzquierdo = Path();

    //pliegue inferior
    pathInferior.moveTo(size.width , size.height);
    pathInferior.lineTo(size.width * 0.8 , size.height * 0.6);
    pathInferior.lineTo(size.width * 0.2 , size.height * 0.6);
    pathInferior.lineTo(0 , size.height);
    canvas.drawPath(pathInferior, lapizLowCollor);



    //pliegue derecho
    pathDerecho.moveTo(size.width , size.height * 0);
    pathDerecho.lineTo(size.width * 0.8 , size.height * 0.2);
    pathDerecho.lineTo(size.width * 0.8 , size.height * 0.8);
    pathDerecho.lineTo(size.width , size.height);
    canvas.drawPath(pathDerecho, lapizHighCollor);



    //pliegue izquierdo
    pathIzquierdo.moveTo(0 , 0);
    pathIzquierdo.lineTo(size.width * 0.2 , size.height * 0.4);
    pathIzquierdo.lineTo(size.width * 0.2 , size.height * 0.4);
    pathIzquierdo.lineTo(size.width * 0.2 , size.height * 0.8);
    pathIzquierdo.lineTo(0, size.height);
    canvas.drawPath(pathIzquierdo, lapizHighCollor);

    //pliegue superior
    pathSuperior.moveTo(0, 0);
    pathSuperior.lineTo(size.width * 0.2 , size.height * 0.4);
    pathSuperior.lineTo(size.width * 0.8 , size.height * 0.4);
    pathSuperior.lineTo(size.width , 0);
    canvas.drawPath(pathSuperior, lapizLowCollor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}