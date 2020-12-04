const trees = require('./trees');

test('#parse_row', () => {
  expect(trees.parse_row('..##.')).toStrictEqual(
    [false, false, true, true, false]
  );
});

test('Row#tree_at', () => {
  let row = new trees.Row([false, false, true, true, false]);

  expect(row.tree_at(0)).toBe(false);
  expect(row.tree_at(1)).toBe(false);
  expect(row.tree_at(2)).toBe(true);
  expect(row.tree_at(3)).toBe(true);
  expect(row.tree_at(4)).toBe(false);

  expect(row.tree_at(5)).toBe(false);
  expect(row.tree_at(6)).toBe(false);
  expect(row.tree_at(7)).toBe(true);
  expect(row.tree_at(8)).toBe(true);
  expect(row.tree_at(9)).toBe(false);
});

test('Forest#trees_on_route', () => {
  let forest = new trees.Forest([
    new trees.Row([false, false, true, true, false]),
    new trees.Row([false, true, false, true, true]),
    new trees.Row([true, false, true, false, false]),
  ]);

  expect(forest.trees_on_route(3, 1)).toBe(1);
  expect(forest.trees_on_route(3, 3)).toBe(0);
});

test('Forest#trees_on_route', () => {
  let forest = new trees.Forest([
    new trees.Row(trees.parse_row('..##.......')),
    new trees.Row(trees.parse_row('#...#...#..')),
    new trees.Row(trees.parse_row('.#....#..#.')),
    new trees.Row(trees.parse_row('..#.#...#.#')),
    new trees.Row(trees.parse_row('.#...##..#.')),
    new trees.Row(trees.parse_row('..#.##.....')),
    new trees.Row(trees.parse_row('.#.#.#....#')),
    new trees.Row(trees.parse_row('.#........#')),
    new trees.Row(trees.parse_row('#.##...#...')),
    new trees.Row(trees.parse_row('#...##....#')),
    new trees.Row(trees.parse_row('.#..#...#.#')),
  ]);

  expect(forest.trees_on_route(1, 1)).toBe(2);
  expect(forest.trees_on_route(3, 1)).toBe(7);
  expect(forest.trees_on_route(5, 1)).toBe(3);
  expect(forest.trees_on_route(7, 1)).toBe(4);
  expect(forest.trees_on_route(1, 2)).toBe(2);
});
