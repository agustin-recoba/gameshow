class Matrix<E> {
  final int rows;
  final int columns;
  late final List<E> _data;

  Matrix(this.rows, this.columns, E Function(int, int) generator) {
    _data = List.generate(
        rows * columns, (index) => generator(index ~/ columns, index % columns),
        growable: false);
  }

  E getElem(int row, int column) => _data[row * columns + column];

  E setElem(int row, int column, E elem) =>
      _data[row * columns + column] = elem;

  List<E> operator [](int row) =>
      _data.sublist(row * columns, (row + 1) * columns);

  void operator []=(int row, List<E> values) {
    assert(values.length == columns);
    _data.replaceRange(row * columns, (row + 1) * columns, values);
  }

  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < columns; column++) {
        buffer.write(_data[row * columns + column]);
        buffer.write(' ');
      }
      buffer.writeln();
    }
    return buffer.toString();
  }
}
