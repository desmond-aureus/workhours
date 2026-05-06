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

/// [ProjectInfo.versions] order does not matter; [resolveVersionForProject]
/// sorts by date internally.
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
      AppVersion(version: '1.1.2', releaseDate: DateTime(2026, 4, 22)),
      AppVersion(version: '1.1.1', releaseDate: DateTime(2026, 4, 8)),
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

/// Release catalog for [code], or null if [code] is not in [kProjects].
ProjectInfo? catalogForProjectCode(String code) => _projectsByCode[code];

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

/// Compares calendar dates only: negative if [a] < [b], zero if same day, positive if [a] > [b].
int _calendarCompare(DateTime a, DateTime b) {
  final ay = a.year, am = a.month, ad = a.day;
  final by = b.year, bm = b.month, bd = b.day;
  if (ay != by) return ay.compareTo(by);
  if (am != bm) return am.compareTo(bm);
  return ad.compareTo(bd);
}

/// Maps a work row to an app version using [kProjects].
///
/// [projectCode] must match [ProjectInfo.code] (e.g. spreadsheet Code column).
///
/// Uses **next release** semantics: the first listed release whose date is
/// **strictly after** the work date (the version you are building toward).
/// If the work date is **on or after** the last release in the catalog, the
/// **last** version is returned (latest shipped).
///
/// If the project is not listed or has no releases, returns [kDefaultAppVersion].
String resolveVersionForProject(String projectCode, DateTime date) {
  final project = _projectsByCode[projectCode];
  if (project == null) return kDefaultAppVersion;
  if (project.versions.isEmpty) return kDefaultAppVersion;

  final d = _dateOnly(date);
  final sorted = List<AppVersion>.from(project.versions)
    ..sort(
      (a, b) => _calendarCompare(
        _dateOnly(a.releaseDate),
        _dateOnly(b.releaseDate),
      ),
    );

  for (final v in sorted) {
    final r = _dateOnly(v.releaseDate);
    if (_calendarCompare(r, d) > 0) {
      return v.version;
    }
  }
  return sorted.last.version;
}
