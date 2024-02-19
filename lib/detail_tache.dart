import 'package:appgestiontache/class/gestionTache.dart';
import 'package:flutter/material.dart';

class DetailTache extends StatelessWidget {
  final Tache tache;

  const DetailTache({Key? key, required this.tache}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Calcul du pourcentage d'achèvement des sous-tâches
    double completionPercentage = tache.sousTachefait.isEmpty
        ? 0.0
        : (tache.sousTachefait.where((fait) => fait).length / tache.sousTachefait.length) * 100;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de la Tâche"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade500,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                tache.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Statut: ${tache.isComplete ? 'COMPLET' : 'INCOMPLET'}",
              style: TextStyle(
                fontSize: 18,
                color: tache.isComplete ? Colors.green : Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            if (tache.subTasks.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Table(
                    border: TableBorder.all(),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.blue.shade300),
                        children: [
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Sous-Tâche",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Actif",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      for (int i = 0; i < tache.subTasks.length; i++)
                        TableRow(
                          children: [
                            TableCell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  tache.subTasks[i],
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tache.sousTachefait[i]
                                        ? 'Terminée'
                                        : 'En cours',
                                    style: TextStyle(
                                      color: tache.sousTachefait[i] ? Colors.green : Colors.orange,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 16),
            Text(
              "Date d'échéance: ${tache.dateEcheant}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircularProgressIndicator(
                    value: completionPercentage / 100,
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "${completionPercentage.toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
