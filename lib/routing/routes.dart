const rootRoute = "/";

const dashboardPageDisplayName = "Tableau de bord";
const String dashboardPageRoute = "/dashboard";

const projectsPageDisplayName = "Projets";
const String projectsPageRoute = "/projects";

const tasksPageDisplayName = "Tâches";
const String tasksPageRoute = "/alltasks";

const activitiesPageDisplayName = "Activités";
const String activitiesPageRoute = "/activities";

const String projectDetailsPageRoute = "/details";


const String projectListPageRoute = "/all";

const String overviewPageRoute = "/overview";

const String projectTasksPageRoute = "/tasks";

const String objectivesPageRoute = "/objectives";

const String indicatorPageRoute = "/indicator";

const String eventsPageRoute = "events";

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