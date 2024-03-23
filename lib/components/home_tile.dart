import 'package:atinei_appl/screens/targetsuplier_screen.dart';
import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final int index;

  final Map<String, dynamic> listItems;

  const HomeTile({required this.index, required this.listItems, super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        listItems['imagesUrl'][0],
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      title: Text(listItems['title']),
      subtitle: Text(
        listItems['description'],
        overflow: TextOverflow
            .ellipsis, // Adiciona "..." ao exceder o espaço disponível
        maxLines: 2,
      ),
      trailing: IconButton(
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TargetSupplierScreen(listItems: listItems),
            ),
          );
        },
      ),
    );
  }
}
