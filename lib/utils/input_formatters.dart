import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

MaskTextInputFormatter phoneFormatter() => MaskTextInputFormatter(
  mask: '(##) #####-####',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter cpfFormatter() => MaskTextInputFormatter(
  mask: '###.###.###-##',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter cepFormatter() => MaskTextInputFormatter(
  mask: '#####-###',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter dateFormatter() => MaskTextInputFormatter(
  mask: '##/##/####',
  filter: {"#": RegExp(r'[0-9]')},
);

MaskTextInputFormatter timeFormatter() => MaskTextInputFormatter(
  mask: '##:##',
  filter: {"#": RegExp(r'[0-9]')},
);