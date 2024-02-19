import 'package:appgestiontache/class/gestionTache.dart';
import 'package:appgestiontache/add_tache.dart';
import 'package:appgestiontache/detail_tache.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTacheList extends StatelessWidget {
  const MyTacheList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListTache(),
    );
  }
}

class ListTache extends StatefulWidget {
  const ListTache({super.key});

  @override
  State<StatefulWidget> createState() => _ListTacheState();
}

class _ListTacheState extends State<ListTache> {
  List<Tache> taches = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Liste de tâches"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: ListView.separated(
                itemCount: taches.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  return buildTacheItem(taches[index] );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _navigateToTacheAdd,
        icon: const Icon(Icons.add),
        label: const Text("Ajouter Tâche"),
        backgroundColor: Colors.indigo.shade800,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildTacheItem(Tache tache) {
    // final tacheItem = tache[index];

    return Container(
        color: Colors.indigoAccent,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: tache.title,
                    style: GoogleFonts.b612(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Date d\'échéance',
                      style: GoogleFonts.b612(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    Text(
                      tache.dateEcheant,
                      style: GoogleFonts.b612(
                        fontStyle: FontStyle.italic,
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: tache.isComplete ? 'COMPLET' : 'INCOMPLET',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _navigateToTacheDetail(tache),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.blue.shade900,
                    minimumSize: const Size(100, 40)
                  ),
                  child: const Text(
                    "Voir",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                ElevatedButton(
                    onPressed: () {
                      _navigateToTacheDetail(tache);
                    },
                    child: const Text("Editer",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),)
                )
              ]
            )
          ]
        )
    );
  }

  Future<void> _navigateToTacheAdd() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const TacheAdd()),
    );

    if (result != null) {
      setState(() {
        taches.add(result);
      });
    }
  }


  void _navigateToTacheDetail(Tache tache) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailTache(tache: tache)),
    );
  }

  // void _navigateToTacheedit(Map<String, dynamic> tacheItem) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => TacheEdit(tache: tacheItem)),
  //   );
  // }
}
