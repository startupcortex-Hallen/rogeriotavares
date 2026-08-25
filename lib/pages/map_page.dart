import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster_plus/flutter_map_marker_cluster_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../models/models.dart';
import '../providers/app_providers.dart';
import '../services/share_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/rt_widgets.dart';

/// MAPA DA BAHIA — OpenStreetMap com pins de cidades, eventos, obras e demandas.
class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key, this.lat, this.lng});

  /// Coordenadas recebidas de um evento (foco no marcador).
  final double? lat;
  final double? lng;

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  String _filter = 'Tudo';
  static const _filters = ['Tudo', 'Eventos', 'Obras', 'Demandas', 'Cidades'];

  @override
  Widget build(BuildContext context) {

    final cities = ref.watch(citiesProvider).valueOrNull ?? [];
    final reports = ref.watch(approvedReportsProvider).valueOrNull ?? [];
    final events = ref.watch(upcomingEventsProvider).valueOrNull ?? [];

    final markers = <Marker>[];

    if (_filter == 'Tudo' || _filter == 'Cidades') {
      for (final c in cities.whereType<City>()) {
        if (c.latitude == 0 || c.longitude == 0) continue;
        markers.add(Marker(
          point: LatLng(c.latitude, c.longitude),
          width: 44,
          height: 44,
          child: GestureDetector(
            onTap: () => _showCitySheet(context, c),
            child: const _CustomPin(
              icon: Icons.location_city_rounded,
              color: Color(0xFF1565C0),
            ),
          ),
        ));
      }
    }

    if (_filter == 'Tudo' || _filter == 'Eventos') {
      for (final e in events.whereType<EventItem>()) {
        final lat = e.latitude ?? e.cityLatitude;
        final lng = e.longitude ?? e.cityLongitude;
        if (lat == null || lng == null) continue;
        markers.add(Marker(
          point: LatLng(lat, lng),
          width: 44,
          height: 44,
          child: GestureDetector(
            onTap: () => _showEventIndicator(context, e),
            child: const _CustomPin(
              icon: Icons.event_rounded,
              color: Color(0xFFFFD600),
            ),
          ),
        ));
      }
    }

    if (_filter == 'Tudo' || _filter == 'Demandas') {
      for (final r in reports.whereType<ReportItem>()) {
        if (r.latitude == null || r.longitude == null) continue;
        markers.add(Marker(
          point: LatLng(r.latitude!, r.longitude!),
          width: 44,
          height: 44,
          child: GestureDetector(
            onTap: () => _showReportSheet(context, r),
            child: const _CustomPin(
              icon: Icons.warning_amber_rounded,
              color: Color(0xFF606C38),
            ),
          ),
        ));
      }
    }

    // Centra na Bahia ou no evento solicitado
    final focus = (widget.lat != null && widget.lng != null)
        ? LatLng(widget.lat!, widget.lng!)
        : null;
    final center = focus ?? const LatLng(-12.9777, -38.5016);
    final zoom = focus != null ? 12.0 : 5.8;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa da Bahia'),
        actions: [
          IconButton(
            onPressed: () => showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Enviar uma demanda'),
                content: const Text(
                    'Encontrou um problema na sua região? Envie uma demanda com foto e localização para a campanha.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Agora não'),
                  ),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      context.go('/demanda');
                    },
                    child: const Text('Enviar demanda'),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.add_location_alt_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filtros
          SizedBox(
            height: 52,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.sm),
              children: [
                for (final f in _filters)
                  Padding(
                    padding: const EdgeInsets.only(right: RtSpace.sm),
                    child: CategoryPill(
                      label: f,
                      active: _filter == f,
                      onTap: () => setState(() => _filter = f),
                    ),
                  ),
              ],
            ),
          ),
          // Mapa
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(RtSpace.lg),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: center,
                  initialZoom: zoom,
                  minZoom: 4,
                  maxZoom: 16,
                  interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'br.com.rogeriotavares.rogerio_tavares_45788',
                    maxZoom: 19,
                  ),
                  if (markers.isNotEmpty)
                    MarkerClusterLayerWidget(
                      options: MarkerClusterLayerOptions(
                        maxClusterRadius: 48,
                        size: const Size(44, 44),
                        alignment: Alignment.center,
                        markers: markers,
                        builder: (context, markers) => ClusterCircle(markers: markers),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Legenda
          Container(
            padding: const EdgeInsets.symmetric(horizontal: RtSpace.lg, vertical: RtSpace.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const _LegendItem(icon: Icons.location_city_rounded, color: Color(0xFF1565C0), label: 'Cidades'),
                const _LegendItem(icon: Icons.event_rounded, color: Color(0xFFFFD600), label: 'Eventos'),
                const _LegendItem(icon: Icons.warning_amber_rounded, color: Color(0xFF606C38), label: 'Demandas'),
                IconButton(
                  onPressed: () => ShareService.share('Mapa da Bahia — Rogério Tavares 45788', '/mapa'),
                  icon: const Icon(Icons.share_rounded, size: 20),
                  tooltip: 'Compartilhar mapa',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCitySheet(BuildContext context, City city) {
    final p = rt(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(RtSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: RtSpace.sm,
          children: [
            Row(
              children: [
                Icon(Icons.location_city_rounded, color: p.primary),
                const SizedBox(width: RtSpace.sm),
                Expanded(
                  child: Text(city.name,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
                ),
                NumberBadge(),
              ],
            ),
            Text('${city.state} • ${city.region}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
              label: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEventIndicator(BuildContext context, EventItem e) {
    final p = rt(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(RtSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: RtSpace.sm,
          children: [
            Row(
              children: [
                Icon(Icons.event_rounded, color: p.accent),
                const SizedBox(width: RtSpace.sm),
                Expanded(
                  child: Text(e.title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            Text('${e.cityName ?? ''} • ${e.locationName}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
            Row(
              spacing: RtSpace.sm,
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      context.go('/agenda');
                    },
                    icon: const Icon(Icons.event_rounded),
                    label: const Text('Ver na agenda'),
                  ),
                ),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                    label: const Text('Fechar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showReportSheet(BuildContext context, ReportItem r) {
    final p = rt(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: p.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(RtRadius.xl)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(RtSpace.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: RtSpace.sm,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_amber_rounded, color: Color(0xFF606C38)),
                const SizedBox(width: RtSpace.sm),
                Expanded(
                  child: Text('Demanda em ${r.city.isEmpty ? 'sua região' : r.city}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            Text(r.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: p.secondaryText)),
            FilledButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close_rounded),
              label: const Text('Fechar'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pin personalizado das cidades/eventos/demandas.
class _CustomPin extends StatelessWidget {
  const _CustomPin({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [RtShadow.sm()],
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(icon, color: Colors.white, size: 18),
    );
  }
}

/// Círculo de cluster personalizado.
class ClusterCircle extends StatelessWidget {
  const ClusterCircle({super.key, required this.markers});

  final List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    final text = markers.length.toString();
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF1565C0),
        borderRadius: BorderRadius.circular(RtRadius.full),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800),
      ),
    ).animate().scale(duration: 200.ms);
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.icon, required this.color, required this.label});

  final IconData icon;
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final p = rt(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(color: p.secondaryText)),
      ],
    );
  }
}