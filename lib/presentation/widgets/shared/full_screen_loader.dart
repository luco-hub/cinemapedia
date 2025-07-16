import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  

  Stream<String> getLoadMesages(){

    final messages = <String>[
    'Por favor Espere',
    'Cargando Populares',
    'Cargando Peliculas',
    'Ya casi..',
    'Un poco Mas!'

  ];
    return Stream.periodic(
      const Duration( milliseconds: 1200), (step){
        return messages[step];
      }
    ).take(messages.length);
  }


  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
            const Text('Cargando...'),
            const SizedBox(height: 12,),
            const CircularProgressIndicator(strokeWidth: 2,),
            const SizedBox(height: 12,),
            StreamBuilder(
              stream: getLoadMesages(), 
              builder: (context, snapshot) {
                if( !snapshot.hasData) return const Text('Espere por favor!!');

                return Text( snapshot.data!);
              },)

        ],
      ),
    );
  }
}