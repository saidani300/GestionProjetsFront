const rootRoute = "/";

const dashboardPageDisplayName = "Tableau de bord";
const dashboardPageRoute = "/dashboard";

const projectsPageDisplayName = "Projets";
const projectsPageRoute = "/projects";

const tasksPageDisplayName = "Tâches";
const tasksPageRoute = "/tasks";

const activitiesPageDisplayName = "Activités";
const activitiesPageRoute = "/activities";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}


List<MenuItem> TopVarMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, dashboardPageRoute),
  MenuItem(projectsPageDisplayName, projectsPageRoute),
  MenuItem(tasksPageDisplayName, tasksPageRoute),
  MenuItem(activitiesPageDisplayName, activitiesPageRoute)

];