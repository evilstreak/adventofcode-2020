const parse_row = (row) => {
  return row.split('').map((position) => (position === '#'));
};

const Row = class {
  constructor(tree_positions) {
    this.tree_positions = tree_positions;
    this.length = tree_positions.length
  }

  tree_at(position) {
    return this.tree_positions[position % this.length];
  }
};

const Forest = class {
  constructor(rows) {
    this.rows = rows;
  }

  trees_on_route(right, down) {
    return this.rows.filter(
      (row, index) => index % down == 0
    ).filter(
      (row, index) => row.tree_at(index * right)
    ).length;
  }
};

exports.parse_row = parse_row;
exports.Row = Row;
exports.Forest = Forest;
