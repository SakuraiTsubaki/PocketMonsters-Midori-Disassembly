from __future__ import annotations

import csv
import json
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


class ReleaseReportTests(unittest.TestCase):
    def test_release_evidence_is_synchronized(self):
        project = json.loads((ROOT / "project.json").read_text(encoding="utf-8"))
        report = json.loads(
            (ROOT / "analysis" / "midori-release-header-report.json").read_text(
                encoding="utf-8"
            )
        )
        with (ROOT / "research" / "releases.csv").open(
            newline="", encoding="utf-8"
        ) as stream:
            rows = list(csv.DictReader(stream))

        project_by_id = {item["id"]: item for item in project["releases"]}
        report_by_id = {item["id"]: item for item in report["releases"]}
        csv_by_id = {item["id"]: item for item in rows}
        self.assertEqual(set(project_by_id), set(report_by_id))
        self.assertEqual(set(project_by_id), set(csv_by_id))
        self.assertEqual(len(project_by_id), 2)

        for release_id, item in project_by_id.items():
            self.assertEqual(item["status"], "candidate")
            self.assertEqual(item["sha256"], report_by_id[release_id]["sha256"])
            self.assertEqual(item["sha256"], csv_by_id[release_id]["sha256"])
            self.assertTrue(all(report_by_id[release_id]["validation"].values()))


if __name__ == "__main__":
    unittest.main()

