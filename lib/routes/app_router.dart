import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../admin/admin_content_crud.dart';
import '../admin/admin_dashboard.dart';
import '../admin/admin_engagement.dart';
import '../admin/admin_shell.dart';
import '../admin/admin_special.dart';
import '../admin/login_page.dart';
import '../pages/agenda_page.dart';
import '../pages/biography_page.dart';
import '../pages/chat_page.dart';
import '../pages/contact_info_page.dart';
import '../pages/contact_page.dart';
import '../pages/downloads_page.dart';
import '../pages/gallery_page.dart';
import '../pages/home_page.dart';
import '../pages/map_page.dart';
import '../pages/news_detail_page.dart';
import '../pages/news_page.dart';
import '../pages/perfil_page.dart';
import '../pages/plan_detail_page.dart';
import '../pages/plan_page.dart';
import '../pages/report_page.dart';
import '../pages/social_page.dart';
import '../pages/transparency_page.dart';
import '../pages/videos_page.dart';
import '../pages/volunteer_page.dart';
import '../routes/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) {
    final isAdminRoute = state.matchedLocation.startsWith('/admin');
    final logged = Supabase.instance.client.auth.currentUser != null;
    final isLogin = state.matchedLocation == '/admin/login';
    if (isAdminRoute && !logged && !isLogin) return '/admin/login';
    if (logged && isLogin) return '/admin';
    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/plano',
              builder: (context, state) => const PlanPage(),
              routes: [
                GoRoute(
                  path: ':slug',
                  builder: (context, state) =>
                      PlanDetailPage(slug: state.pathParameters['slug']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/agenda',
              builder: (context, state) => const AgendaPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/noticias',
              builder: (context, state) => const NewsPage(),
              routes: [
                GoRoute(
                  path: ':slug',
                  builder: (context, state) =>
                      NewsDetailPage(slug: state.pathParameters['slug']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/perfil',
              builder: (context, state) => const PerfilPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/biografia',
      builder: (context, state) => const BiographyPage(),
    ),
    GoRoute(
      path: '/transparencia',
      builder: (context, state) => const TransparencyPage(),
    ),
    GoRoute(
      path: '/mapa',
      builder: (context, state) => MapPage(
        lat: double.tryParse(state.uri.queryParameters['lat'] ?? ''),
        lng: double.tryParse(state.uri.queryParameters['lng'] ?? ''),
      ),
    ),
    GoRoute(
      path: '/galeria',
      builder: (context, state) => const GalleryPage(),
    ),
    GoRoute(
      path: '/videos',
      builder: (context, state) => const VideosPage(),
    ),
    GoRoute(
      path: '/fale',
      builder: (context, state) => const ContactPage(),
    ),
    GoRoute(
      path: '/participe',
      builder: (context, state) => const VolunteerPage(),
    ),
    GoRoute(
      path: '/demanda',
      builder: (context, state) => const ReportPage(),
    ),
    GoRoute(
      path: '/redes',
      builder: (context, state) => const SocialPage(),
    ),
    GoRoute(
      path: '/downloads',
      builder: (context, state) => const DownloadsPage(),
    ),
    GoRoute(
      path: '/contato',
      builder: (context, state) => const ContactInfoPage(),
    ),
    GoRoute(
      path: '/chat',
      builder: (context, state) => const ChatPage(),
    ),
    GoRoute(
      path: '/admin/login',
      builder: (context, state) => const AdminLoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => AdminShell(child: child),
      routes: [
        GoRoute(
          path: '/admin',
          builder: (context, state) => const AdminHome(),
        ),
        GoRoute(
          path: '/admin/noticias',
          builder: (context, state) => const AdminNewsList(),
        ),
        GoRoute(
          path: '/admin/plano',
          builder: (context, state) => const AdminPlanList(),
        ),
        GoRoute(
          path: '/admin/agenda',
          builder: (context, state) => const AdminEventsList(),
        ),
        GoRoute(
          path: '/admin/cidades',
          builder: (context, state) => const AdminCitiesList(),
        ),
        GoRoute(
          path: '/admin/galeria',
          builder: (context, state) => const AdminGalleryList(),
        ),
        GoRoute(
          path: '/admin/videos',
          builder: (context, state) => const AdminVideosList(),
        ),
        GoRoute(
          path: '/admin/voluntarios',
          builder: (context, state) => const AdminVolunteersList(),
        ),
        GoRoute(
          path: '/admin/mensagens',
          builder: (context, state) => const AdminMessagesList(),
        ),
        GoRoute(
          path: '/admin/demandas',
          builder: (context, state) => const AdminReportsList(),
        ),
        GoRoute(
          path: '/admin/comentarios',
          builder: (context, state) => const AdminCommentsList(),
        ),
        GoRoute(
          path: '/admin/downloads',
          builder: (context, state) => const AdminDownloadsList(),
        ),
        GoRoute(
          path: '/admin/redes',
          builder: (context, state) => const AdminSocialList(),
        ),
        GoRoute(
          path: '/admin/conteudo',
          builder: (context, state) => const AdminContentPage(),
        ),
        GoRoute(
          path: '/admin/biografia',
          builder: (context, state) => const AdminBiographyList(),
        ),
        GoRoute(
          path: '/admin/usuarios',
          builder: (context, state) => const AdminUsersPage(),
        ),
        GoRoute(
          path: '/admin/notificacoes',
          builder: (context, state) => const AdminNotificationsPage(),
        ),
        GoRoute(
          path: '/admin/conta',
          builder: (context, state) => const AdminAccountPage(),
        ),
        GoRoute(
          path: '/admin/configuracoes',
          builder: (context, state) => const AdminSettingsPage(),
        ),
      ],
    ),
  ],
);