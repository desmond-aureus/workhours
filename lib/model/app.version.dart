class AppVersion {
  final String version;
  final DateTime releaseDate;

  AppVersion({required this.version, required this.releaseDate});
}

class ProjectInfo {
  final String code;
  final List<AppVersion> versions;

  ProjectInfo({required this.code, required this.versions});
}

final List<ProjectInfo> kProjects = [
  ProjectInfo(
    code: 'APA',
    versions: [
      AppVersion(version: '7.1.0', releaseDate: DateTime(2026, 4, 10)),
      AppVersion(version: '7.0.5', releaseDate: DateTime(2026, 3, 10)),
      AppVersion(version: '7.0.4', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '7.0.3', releaseDate: DateTime(2026, 1, 27)),
      AppVersion(version: '7.0.2', releaseDate: DateTime(2026, 1, 21)),
      AppVersion(version: '7.0.1', releaseDate: DateTime(2026, 1, 16)),
      AppVersion(version: '7.0.0', releaseDate: DateTime(2026, 1, 12)),
    ],
  ),
];

/// Shown when the project is unknown or the row date is before any release.
const String kDefaultAppVersion = '0.0.0';

/// Built once: O(1) lookup by [ProjectInfo.code]. If duplicate codes exist, the
/// last entry in [kProjects] wins.
final Map<String, ProjectInfo> _projectsByCode = {
  for (final p in kProjects) p.code: p,
};

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Calendar compare: [a] and [b] are treated as dates only (year/month/day).
/// Returns true iff [a] is on or before [b].
bool _isOnOrBeforeCalendar(DateTime a, DateTime b) {
  final ay = a.year, am = a.month, ad = a.day;
  final by = b.year, bm = b.month, bd = b.day;
  if (ay != by) return ay < by;
  if (am != bm) return am < bm;
  return ad <= bd;
}

/// Maps a work row to an app version using [kProjects].
///
/// [projectCode] must match [ProjectInfo.code] (e.g. spreadsheet "PROJECT" column).
/// Picks the latest [AppVersion] whose [releaseDate] is on or before [date]
/// (i.e. the version that was current once that release shipped). If [date] is
/// strictly before every release, or the project is not listed, returns [kDefaultAppVersion].
///
/// [versions] in each project should be ordered newest-first.
String resolveVersionForProject(String projectCode, DateTime date) {
  final project = _projectsByCode[projectCode];
  if (project == null) return kDefaultAppVersion;

  final d = _dateOnly(date);
  for (final v in project.versions) {
    if (_isOnOrBeforeCalendar(v.releaseDate, d)) {
      return v.version;
    }
  }
  return kDefaultAppVersion;
}
