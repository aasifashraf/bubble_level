/// The home page's order of tools, by name. The first [topCount] are the
/// user's top tools.
const topCount = 3;

/// [defaults] in the user's [saved] order: the ones they placed first,
/// then any they haven't (a tool added since) in default order. Unknown or
/// repeated names in [saved] are ignored.
List<String> orderTools(List<String> defaults, List<String> saved) {
  final placed = <String>[];
  for (final name in saved) {
    if (defaults.contains(name) && !placed.contains(name)) placed.add(name);
  }
  return [...placed, ...defaults.where((d) => !placed.contains(d))];
}

/// [order] with the tool at [from] moved so it ends up at [to].
List<String> moveTool(List<String> order, int from, int to) {
  final out = [...order];
  final name = out.removeAt(from);
  out.insert(to.clamp(0, out.length), name);
  return out;
}

/// Makes [name] a top tool (last of the top ones), or, if it is one,
/// moves it to just below them.
List<String> toggleTop(List<String> order, String name) {
  final i = order.indexOf(name);
  if (i < 0) return order;
  return moveTool(order, i, i < topCount ? topCount : topCount - 1);
}
