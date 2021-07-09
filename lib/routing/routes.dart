const rootRoute = "/";

const dashboardPageDisplayName = "Tableau de bord";
const String dashboardPageRoute = "/dashboard";

const projectsPageDisplayName = "Projets";
const String projectsPageRoute = "/projects";

const tasksPageDisplayName = "Tâches";
const String tasksPageRoute = "/tasks";

const activitiesPageDisplayName = "Activités";
const String activitiesPageRoute = "/activities";

const String projectDetailsPageRoute = "/details";

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