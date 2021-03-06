const rootRoute = "/";

const dashboardPageDisplayName = "Tableau de bord";
const String dashboardPageRoute = "/dashboard";

const projectsPageDisplayName = "Projets";
const String projectsPageRoute = "/projects";

const tasksPageDisplayName = "Tâches";
const String tasksPageRoute = "/alltasks";

const activitiesPageDisplayName = "Activités";
const String activitiesPageRoute = "/activities";

const peoplePageDisplayName = "Personnes";
const String peoplePageRoute = "/Personnes";

const String projectDetailsPageRoute = "/details";

const String projectListPageRoute = "/all";

const String overviewPageRoute = "/overview";

const String projectTasksPageRoute = "/tasks";

const String objectivesPageRoute = "objectives";

const String objectivesListPageRoute = "/objectives/list";

const String indicatorPageRoute = "/indicator";

const String eventsPageRoute = "events";

const String eventsListPageRoute = "/events/list";

const String eventEvaluationsPageRoute = "/evaluations";

const String evaluationCalculationsPageRoute = "/calculations";

const String meetingsPageRoute = "/meetings";

const String documentsPageRoute = "/documents";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> topVarMenuItemRoutes = [
  MenuItem(dashboardPageDisplayName, dashboardPageRoute),
  MenuItem(projectsPageDisplayName, projectsPageRoute),
  MenuItem(tasksPageDisplayName, tasksPageRoute),
  MenuItem(activitiesPageDisplayName, activitiesPageRoute),
  MenuItem(peoplePageDisplayName, peoplePageRoute)
];
