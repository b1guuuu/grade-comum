import 'package:flutter/material.dart';

class CamposAluno extends StatefulWidget {
  final TextEditingController nomeController;
  final TextEditingController matriculaController;
  final TextEditingController senhaController;
  final TextEditingController confirmaSenhaController;

  const CamposAluno(
      {super.key,
      required this.nomeController,
      required this.matriculaController,
      required this.senhaController,
      required this.confirmaSenhaController});

  @override
  State<CamposAluno> createState() {
    return CamposAlunoState();
  }
}

class CamposAlunoState extends State<CamposAluno> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
              hintText: 'Nome',
              border: OutlineInputBorder(),
              label: Text('Nome')),
          controller: widget.nomeController,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: 'Matrícula',
              border: OutlineInputBorder(),
              label: Text('Matrícula')),
          controller: widget.matriculaController,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: 'Senha',
              border: OutlineInputBorder(),
              label: Text('Senha')),
          controller: widget.senhaController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          decoration: const InputDecoration(
              hintText: 'Confirmar senha',
              border: OutlineInputBorder(),
              label: Text('Confirmar senha')),
          controller: widget.confirmaSenhaController,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
        ),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
