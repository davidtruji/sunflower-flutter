import 'package:flutter/material.dart';
import 'package:sunflower_flutter/shape.dart';

class PlantDetail extends StatelessWidget {
  const PlantDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: NestedScrollView(
          // Setting floatHeaderSlivers to true is required in order to float
          // the outer slivers over the inner scrollable.
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                pinned: true,
                expandedHeight: 300.0,
                collapsedHeight: 100.0,
                leading: Padding(
                  padding: const EdgeInsets.all(8),
                  child: FloatingActionButton(
                    onPressed: () => Navigator.pop(context),
                    backgroundColor: Colors.white,
                    shape: const CircleBorder(),
                    child: const Icon(Icons.arrow_back),
                  ),
                ),
                forceElevated: innerBoxIsScrolled,
                flexibleSpace: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                      "assets/sunflower.jpg",
                      fit: BoxFit.cover,
                    )),
                    Scaffold(
                      backgroundColor: Colors.transparent,
                      floatingActionButtonLocation:
                          FloatingActionButtonLocation.endFloat,
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {},
                        shape: Shape.sunflowerShape,
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(children: [
              Text("Sunflower",
                  style: Theme.of(context).textTheme.displayMedium),
              plantIrrigation(context),
              Text(
                  "Los girasoles son plantas anuales (como lo indica su nombre específico latín: annuus) que pueden medir tres metros de alto. Los tallos son generalmente erectos e hispidos. La mayoría de las hojas son caulinares, alternas, pecioladas, con base cordiforme y bordes aserrados. La cara inferior es usualmente más o menos hispida, a veces glandulosa y la superior glabra. El involucro es hemiesférico o anchado y mide 15-40 mm y hasta más de 20 cm. Las brácteas involúcrales llamadas filiaros se encuentran en número de 20-30, y hasta más de 100, ovaladas a lanceoladas —brutalmente estrechadas en el ápice— nerviadas longitudinalmente, con el borde generalmente hispido o hirsuto, al igual que sus caras exteriores, raramente son glabras. Receptáculo con escamas centimétricas tridentadas, con el diente mediano más grande y la punta hirsuta. Las lígulas, en número de 15-30, y hasta 100, de color amarillo a anaranjado hasta rojas, miden 2,5-5 cm; los flósculos, de 150 hasta 1000, del mismo color con los estambres pardos-rojizos. Los frutos son aquenios ovalados, algo truncados en la base, de 3-15 mm de largo, glabros o casi, estriados por finísimos surcos verticales, de color oscuro, generalmente casi negras —aunque pueden ser también blanquecinas, rojizas, de color miel o bien moteados o con bandas longitudinales más claras—. El vilano consiste en dos escamas lanceoladas de 2-3,5 mm acompañadas, o no, de hasta cuatro escamitas obtusas de 0,5-1 mm, todas tempranamente caedizas,4​ (como lo indica su nombre específico latín: annuus). "),
            ]),
          ))),
    );
  }

  Widget plantIrrigation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text("Necesita ser regada",
              style: Theme.of(context).textTheme.labelMedium),
          const Text("Cada 3 días."),
        ],
      ),
    );
  }
}
