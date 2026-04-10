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

/// Each [ProjectInfo.versions] list is **newest release first** (required by
/// [resolveVersionForProject]).
final List<ProjectInfo> kProjects = [
  ProjectInfo(
    code: 'AAP',
    versions: [
      AppVersion(version: '6.3.7', releaseDate: DateTime(2026, 4, 22)),
      AppVersion(version: '6.3.6', releaseDate: DateTime(2026, 4, 8)),
      AppVersion(version: '6.3.5', releaseDate: DateTime(2026, 3, 25)),
      AppVersion(version: '6.3.4', releaseDate: DateTime(2026, 3, 11)),
      AppVersion(version: '6.3.3', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '6.3.2', releaseDate: DateTime(2026, 3, 2)),
      AppVersion(version: '6.3.1', releaseDate: DateTime(2026, 2, 25)),
      AppVersion(version: '6.3.0', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '6.2.0', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '6.1.0', releaseDate: DateTime(2026, 1, 19)),
    ],
  ),
  ProjectInfo(
    code: 'ACA',
    versions: [
      AppVersion(version: '5.1.0', releaseDate: DateTime(2026, 4, 10)),
      AppVersion(version: '5.0.5', releaseDate: DateTime(2026, 3, 30)),
      AppVersion(version: '5.0.4', releaseDate: DateTime(2026, 3, 4)),
      AppVersion(version: '5.0.3', releaseDate: DateTime(2026, 2, 10)),
      AppVersion(version: '5.0.2', releaseDate: DateTime(2026, 1, 31)),
      AppVersion(version: '5.0.1', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '5.0.0', releaseDate: DateTime(2026, 1, 9)),
    ],
  ),
  ProjectInfo(
    code: 'AEA',
    versions: [
      AppVersion(version: '3.0.4', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '3.0.3', releaseDate: DateTime(2026, 2, 2)),
      AppVersion(version: '3.0.2', releaseDate: DateTime(2026, 1, 27)),
      AppVersion(version: '3.0.1', releaseDate: DateTime(2026, 1, 15)),
      AppVersion(version: '3.0.0', releaseDate: DateTime(2026, 1, 6)),
    ],
  ),
  ProjectInfo(
    code: 'ALA',
    versions: [
      // 1.1.1 is after 1.1.2 by release date in source data
      AppVersion(version: '1.1.1', releaseDate: DateTime(2026, 4, 22)),
      AppVersion(version: '1.1.2', releaseDate: DateTime(2026, 4, 8)),
      AppVersion(version: '1.0.11', releaseDate: DateTime(2026, 3, 11)),
      AppVersion(version: '1.0.10', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '1.0.9', releaseDate: DateTime(2026, 3, 2)),
      AppVersion(version: '1.0.8', releaseDate: DateTime(2026, 2, 25)),
      AppVersion(version: '1.0.7', releaseDate: DateTime(2026, 2, 11)),
      AppVersion(version: '1.0.6', releaseDate: DateTime(2026, 2, 10)),
      AppVersion(version: '1.0.5', releaseDate: DateTime(2026, 1, 29)),
      AppVersion(version: '1.0.4', releaseDate: DateTime(2026, 1, 27)),
      AppVersion(version: '1.0.3', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '1.0.2', releaseDate: DateTime(2026, 1, 21)),
      AppVersion(version: '1.0.1', releaseDate: DateTime(2026, 1, 19)),
      AppVersion(version: '1.0.0', releaseDate: DateTime(2026, 1, 5)),
    ],
  ),
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
  ProjectInfo(
    code: 'ARA',
    versions: [
      AppVersion(version: '8.5.8', releaseDate: DateTime(2026, 4, 22)),
      AppVersion(version: '8.5.7', releaseDate: DateTime(2026, 4, 8)),
      AppVersion(version: '8.5.6', releaseDate: DateTime(2026, 3, 25)),
      AppVersion(version: '8.5.5', releaseDate: DateTime(2026, 3, 11)),
      AppVersion(version: '8.5.4', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '8.5.3', releaseDate: DateTime(2026, 3, 2)),
      AppVersion(version: '8.5.2', releaseDate: DateTime(2026, 2, 25)),
      AppVersion(version: '8.5.1', releaseDate: DateTime(2026, 2, 11)),
      AppVersion(version: '8.5.0', releaseDate: DateTime(2026, 2, 10)),
      AppVersion(version: '8.3.0', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '8.2.0', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '8.1.0', releaseDate: DateTime(2026, 1, 19)),
      // Listed with an earlier calendar date than 8.1.0 — order is by date
      AppVersion(version: '8.4.0', releaseDate: DateTime(2026, 1, 9)),
    ],
  ),
  ProjectInfo(
    code: 'ASA',
    versions: [
      AppVersion(version: '2.0.2', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '2.0.1', releaseDate: DateTime(2026, 1, 16)),
      AppVersion(version: '2.0.0', releaseDate: DateTime(2026, 1, 7)),
    ],
  ),
  ProjectInfo(
    code: 'ASUA',
    versions: [
      AppVersion(version: '4.2.6', releaseDate: DateTime(2026, 3, 25)),
      AppVersion(version: '4.2.5', releaseDate: DateTime(2026, 3, 11)),
      AppVersion(version: '4.2.4', releaseDate: DateTime(2026, 3, 5)),
      AppVersion(version: '4.2.3', releaseDate: DateTime(2026, 3, 2)),
      AppVersion(version: '4.2.2', releaseDate: DateTime(2026, 2, 25)),
      AppVersion(version: '4.2.1', releaseDate: DateTime(2026, 2, 10)),
      AppVersion(version: '4.2.0', releaseDate: DateTime(2026, 1, 22)),
      AppVersion(version: '4.1.0', releaseDate: DateTime(2026, 1, 13)),
      AppVersion(version: '3.2.7', releaseDate: DateTime(2026, 1, 13)),
    ],
  ),
  // No releases listed — always resolves to [kDefaultAppVersion]
  ProjectInfo(code: 'SD', versions: []),
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
