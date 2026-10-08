import 'package:flutter/material.dart';

import '../../data/repositories/settings_repository.dart';
import '../../domain/tool_order.dart';
import '../core/controls.dart';
import '../core/help.dart';
import '../core/l10n.dart';
import '../core/theme.dart';
import 'tool_glyphs.dart';
import 'tool_tiles.dart';

/// One tool in the Arrange sheet.
typedef ArrangeItem = ({HomeTool tool, String title, bool available});

/// Lets the user put the home page's tools in their own order: drag a row
/// by its handle (or press and hold it), and star a tool to make it one of
/// the top tools. Each change is saved at once; "Popular order" goes back
/// to the default. [items] are in the default order.
Future<void> showArrangeSheet(
  BuildContext context, {
  required SettingsRepository settings,
  required List<ArrangeItem> items,
}) => showAppSheet<void>(
  context,
  (context) => ListenableBuilder(
    listenable: settings,
    builder: (context, _) => _ArrangeBody(settings: settings, items: items),
  ),
);

class _ArrangeBody extends StatelessWidget {
  const _ArrangeBody({required this.settings, required this.items});

  final SettingsRepository settings;
  final List<ArrangeItem> items;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    final byName = {for (final t in items) t.tool.name: t};
    final order = orderTools(byName.keys.toList(), settings.toolOrder);
    void save(List<String> names) => settings.setToolOrder(names);
    return Container(
      decoration: BoxDecoration(
        color: p.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44,
                  height: 5,
                  decoration: insetSurface(p, radius: BorderRadius.circular(3)),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                l.arrangeTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                  color: p.inkStrong,
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  l.arrangeHint,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, height: 1.4, color: p.label),
                ),
              ),
              const SizedBox(height: 12),
              Flexible(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  buildDefaultDragHandles: false,
                  // Room for the rows' soft shadows inside the list's edge.
                  padding: const EdgeInsets.fromLTRB(8, 6, 14, 14),
                  itemCount: order.length,
                  onReorderItem: (from, to) => save(moveTool(order, from, to)),
                  proxyDecorator: (child, _, _) => Transform.scale(
                    scale: 1.03,
                    child: Material(
                      type: MaterialType.transparency,
                      child: child,
                    ),
                  ),
                  itemBuilder: (context, i) {
                    final t = byName[order[i]]!;
                    return _Row(
                      key: ValueKey(t.tool),
                      item: t,
                      index: i,
                      top: i < topCount,
                      onStar: () => save(toggleTop(order, t.tool.name)),
                    );
                  },
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 14,
                  children: [
                    Expanded(
                      child: SoftButton(
                        label: l.arrangeReset,
                        icon: Icons.restart_alt_rounded,
                        onPressed: settings.toolOrder.isEmpty
                            ? null
                            : () => settings.setToolOrder(null),
                      ),
                    ),
                    Expanded(
                      child: SoftButton(
                        label: l.arrangeDone,
                        icon: Icons.check_rounded,
                        emphasis: true,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A tool's row: icon, name, a star for the top tools and a drag handle.
/// Pressing and holding anywhere on it drags it too.
class _Row extends StatelessWidget {
  const _Row({
    super.key,
    required this.item,
    required this.index,
    required this.top,
    required this.onStar,
  });

  final ArrangeItem item;
  final int index;
  final bool top;
  final VoidCallback onStar;

  @override
  Widget build(BuildContext context) {
    final l = context.l10n;
    final p = Palette.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ReorderableDelayedDragStartListener(
        index: index,
        child: Container(
          height: 58,
          padding: const EdgeInsets.only(left: 8, right: 4),
          decoration: softSurface(p, radius: BorderRadius.circular(20)),
          child: Row(
            spacing: 12,
            children: [
              ToolIcon(tool: item.tool, size: 40, available: item.available),
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: item.available ? p.inkStrong : p.label,
                  ),
                ),
              ),
              IconButton(
                tooltip: top ? l.arrangeUnstar : l.arrangeStar,
                onPressed: onStar,
                icon: Icon(
                  top ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: top ? p.ballDark : p.label,
                ),
              ),
              ReorderableDragStartListener(
                index: index,
                child: ExcludeSemantics(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Icon(Icons.drag_handle_rounded, color: p.label),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
