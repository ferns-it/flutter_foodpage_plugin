import 'package:flutter_treeview/src/models/node.dart';

List<Node> testNodes = [
  Node<String>(label: 'documents', data: 'docs', key: 'docs', children: [
    Node<double>(label: 'personal', data: 1.0, key: 'd3', children: [
      Node<bool>(label: 'Resume.docx', data: true, key: 'pd1'),
      Node<bool>(label: 'Cover Letter.docx', data: false, key: 'pd2'),
    ]),
    Node<double>(label: 'Inspection.docx', data: 2.0, key: 'd1'),
    Node<double>(label: 'Invoice.docx', data: 3.0, key: 'd2'),
  ]),
  Node<String>(
    label: 'MeetingReport.xls',
    data: 'mrxls',
    key: 'mrxls',
  ),
  Node<String>(
    label: 'MeetingReport.pdf',
    key: 'mrpdf',
  ),
  Node<String>(
    label: 'Demo.zip',
    data: 'demo',
    key: 'demo',
  ),
];
