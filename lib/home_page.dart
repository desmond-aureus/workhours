import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:html' as html;

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:workhours/model/app.version.dart';

class WorkEntry {
  final DateTime date;
  final String project;
  final String code;
  final double hours;

  const WorkEntry({
    required this.date,
    required this.project,
    required this.code,
    required this.hours,
  });
}

List<WorkEntry> parseWorkHoursData(String rawData, DateTime startDate) {
  final lines = rawData.split(RegExp(r'\r?\n')).toList();

  int headerRowIdx = -1;
  for (int i = 0; i < lines.length; i++) {
    final cells = lines[i].split('\t');
    if (cells.isNotEmpty && cells[0].trim() == 'PROJECT') {
      headerRowIdx = i;
      break;
    }
  }

  if (headerRowIdx == -1) {
    throw Exception(
      'Could not find the PROJECT header row.\n'
      'Make sure your pasted data includes the row that starts with "PROJECT" and "Code".',
    );
  }

  final entries = <WorkEntry>[];

  for (int i = headerRowIdx + 1; i < lines.length; i++) {
    final line = lines[i];
    if (line.trim().isEmpty) continue;

    final cells = line.split('\t');
    if (cells.length < 3) continue;

    final projectName = cells[0].trim();
    final code = cells[1].trim();
    if (projectName.isEmpty || code.isEmpty) continue;

    for (int j = 2; j < cells.length; j++) {
      final hoursStr = cells[j].trim();
      if (hoursStr.isEmpty) continue;

      final hours = double.tryParse(hoursStr);
      if (hours == null || hours <= 0) continue;

      final date = startDate.add(Duration(days: j - 2));
      entries.add(
        WorkEntry(date: date, project: projectName, code: code, hours: hours),
      );
    }
  }

  entries.sort((a, b) {
    final d = a.date.compareTo(b.date);
    return d != 0 ? d : a.project.compareTo(b.project);
  });

  return entries;
}

String formatDate(DateTime date) =>
    '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _dataController = TextEditingController();
  DateTime _startDate = DateTime(2025, 12, 29);
  List<WorkEntry> _entries = [];
  bool _parsed = false;
  bool _parsing = false;
  String? _error;
  String _filterProject = 'All';

  List<String> get _projectNames {
    final names = _entries.map((e) => e.project).toSet().toList()..sort();
    return ['All', ...names];
  }

  List<WorkEntry> get _filteredEntries {
    if (_filterProject == 'All') return _entries;
    return _entries.where((e) => e.project == _filterProject).toList();
  }

  double get _totalHours =>
      _filteredEntries.fold(0.0, (sum, e) => sum + e.hours);

  Future<void> _pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _startDate = picked);
  }

  Future<void> _parseData() async {
    if (_parsing) return;

    setState(() {
      _parsing = true;
      _error = null;
      _entries = [];
      _parsed = false;
    });

    // Yield so the frame can paint the loading state before heavy parsing.
    await Future<void>.delayed(Duration.zero);

    try {
      final text = _dataController.text;
      if (text.trim().isEmpty) {
        setState(() => _error = 'Please paste your spreadsheet data first.');
        return;
      }

      final result = parseWorkHoursData(text, _startDate);
      if (result.isEmpty) {
        setState(
          () => _error =
              'No hours found. Check that the data has a PROJECT header row and non-zero values.',
        );
        return;
      }
      setState(() {
        _entries = result;
        _parsed = true;
        _filterProject = 'All';
      });
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _parsing = false);
    }
  }

  void _exportCsv() {
    final data = _filteredEntries;
    if (data.isEmpty) return;

    final rows = <List<dynamic>>[
      ['Date', 'Project', 'Code', 'Hours', 'Version'],
      ...data.map(
        (e) => [
          formatDate(e.date),
          e.project,
          e.code,
          e.hours,
          resolveVersionForProject(e.code, e.date),
        ],
      ),
    ];

    final csv = const ListToCsvConverter().convert(rows);
    // BOM prefix for Excel UTF-8 compatibility
    final bytes = utf8.encode('\uFEFF$csv');
    final blob = html.Blob([bytes], 'text/csv;charset=utf-8');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = 'workhours.csv';
    html.document.body!.children.add(anchor);
    anchor.click();
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E40AF),
        foregroundColor: Colors.white,
        title: const Text(
          'Work Hours Parser',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputCard(theme, cs),
            if (_parsed && _entries.isNotEmpty) ...[
              const SizedBox(height: 24),
              _buildStatsRow(),
              const SizedBox(height: 24),
              _buildResultsCard(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard(ThemeData theme, ColorScheme cs) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Import Data',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Copy from row 9 to row 20 last date.\nPaste your work hoursdata and set the start date.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 24),
          _Label('Start Date (first day in the data)'),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickStartDate,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_today, size: 18, color: cs.primary),
                  const SizedBox(width: 10),
                  Text(
                    formatDate(_startDate),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.arrow_drop_down, color: Colors.grey.shade500),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          _Label('Spreadsheet Data'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: TextField(
              controller: _dataController,
              maxLines: 14,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              decoration: InputDecoration(
                hintText:
                    'Copy all rows from your spreadsheet (Ctrl+A → Ctrl+C) and paste here.\n\n'
                    'Expected structure:\n'
                    '  Row 1 – Month headers (Dec, Jan, Feb ...)\n'
                    '  Row 2 – Day numbers (29, 30, 31, 1, 2 ...)\n'
                    '  Row 3 – "PROJECT | Code | M | Tu | W ..."\n'
                    '  Row 4+ – Project data rows',
                hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red.shade700,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red.shade700),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _parsing ? null : _parseData,
            icon: _parsing
                ? const Icon(Icons.hourglass_bottom)
                : const Icon(Icons.play_arrow_rounded),
            label: Text(_parsing ? 'Parsing…' : 'Parse Data'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2563EB),
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFF2563EB),
              disabledForegroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final allHours = _entries.fold(0.0, (s, e) => s + e.hours);
    final projects = _entries.map((e) => e.project).toSet().length;
    final dateRange =
        '${formatDate(_entries.first.date)} → ${formatDate(_entries.last.date)}';

    return Row(
      children: [
        _StatCard(
          label: 'Total Entries',
          value: _entries.length.toString(),
          icon: Icons.list_alt_rounded,
          color: const Color(0xFF2563EB),
        ),
        const SizedBox(width: 16),
        _StatCard(
          label: 'Projects',
          value: projects.toString(),
          icon: Icons.work_rounded,
          color: const Color(0xFF7C3AED),
        ),
        const SizedBox(width: 16),
        _StatCard(
          label: 'Total Hours',
          value: allHours.toStringAsFixed(1),
          icon: Icons.access_time_rounded,
          color: const Color(0xFF059669),
        ),
        const SizedBox(width: 16),
        _StatCard(
          label: 'Date Range',
          value: dateRange,
          icon: Icons.date_range_rounded,
          color: const Color(0xFFD97706),
        ),
      ],
    );
  }

  Widget _buildResultsCard(ThemeData theme) {
    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Parsed Results',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const Spacer(),
              Text(
                'Filter by project:',
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _filterProject,
                    borderRadius: BorderRadius.circular(8),
                    items: _projectNames
                        .map((p) => DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) => setState(() => _filterProject = v!),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: _filteredEntries.isNotEmpty ? _exportCsv : null,
                icon: const Icon(Icons.download_rounded, size: 18),
                label: Text(
                  'Export CSV  (${_filteredEntries.length} rows · ${_totalHours.toStringAsFixed(1)} hrs)',
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF059669),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: WidgetStateProperty.all(
                  const Color(0xFFF1F5F9),
                ),
                dataRowMinHeight: 44,
                dataRowMaxHeight: 44,
                headingRowHeight: 48,
                border: TableBorder.all(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                columns: const [
                  DataColumn(
                    label: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Project',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Code',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    numeric: true,
                    label: Text(
                      'Hours',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Version',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
                rows: _filteredEntries
                    .map(
                      (e) => DataRow(
                        cells: [
                          DataCell(
                            Text(
                              formatDate(e.date),
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 13,
                              ),
                            ),
                          ),
                          DataCell(Text(e.project)),
                          DataCell(
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEFF6FF),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                e.code,
                                style: const TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            Text(
                              e.hours % 1 == 0
                                  ? e.hours.toInt().toString()
                                  : e.hours.toString(),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          DataCell(
                            _VersionCell(
                              resolveVersionForProject(e.code, e.date),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VersionCell extends StatelessWidget {
  final String version;

  const _VersionCell(this.version);

  @override
  Widget build(BuildContext context) {
    final isDefault = version == kDefaultAppVersion;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isDefault ? const Color(0xFFF3F4F6) : const Color(0xFFF0FDF4),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isDefault ? Colors.grey.shade300 : const Color(0xFF86EFAC),
        ),
      ),
      child: Text(
        version,
        style: TextStyle(
          color: isDefault ? Colors.grey.shade600 : const Color(0xFF15803D),
          fontWeight: FontWeight.w600,
          fontSize: 12,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Color(0xFF374151),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E293B),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
