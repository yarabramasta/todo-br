import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo/constants/index.dart';
import 'package:todo/index.dart';
import 'package:todo/pages/index.dart';
import 'package:todo/providers/index.dart';
import 'package:todo/widgets/index.dart';

class CustomAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      width: mediaWidth / 1.2,
      child: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: mediaWidth,
              margin: const EdgeInsets.only(bottom: 20.0),
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Menu'),
                  InkWell(
                    child: Icon(FeatherIcons.x),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 2.0,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
              ),
            ),
            DrawerItem(
              icon: FeatherIcons.grid,
              menuText: 'All Projects',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
            ),
            DrawerItem(
              icon: FeatherIcons.bookmark,
              menuText: 'Marked',
              onTap: () {},
            ),
            buildMarkedProjectDrawerItem(context),
            DrawerItem(
              icon: FeatherIcons.settings,
              menuText: 'Settings',
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/setting');
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMarkedProjectDrawerItem(BuildContext context) {
    double mediaWidth = MediaQuery.of(context).size.width;
    final projectProvider = Provider.of<ProjectProvider>(context, listen: true);
    final projects = projectProvider.projects.where(
      (project) => project.isMarked,
    );

    return Expanded(
      child: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final project = projectProvider.projects[index];
          final tasks = project.tasks;

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectPage(project: project),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.only(
                top: 10.0,
                left: 40.0,
                bottom: 10.0,
                right: 20.0,
              ),
              width: mediaWidth,
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      color: kColors[project.id % kColors.length],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      project.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Text(tasks.length.toString()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}