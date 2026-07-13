import 'report_draft.dart';

/// Single shared instance for the lifetime of one report flow.
/// A real production app would scope this via Riverpod; kept as a
/// lightweight singleton here to match the assignment's scope.
final ReportDraft reportDraft = ReportDraft();
