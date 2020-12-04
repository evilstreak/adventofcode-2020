const fs = require('fs');
const trees = require('./trees');

let input = fs.readFileSync('./03/input.txt', 'utf8');
let forest = new trees.Forest(
  input.trim().split('\n').map(
    entry => new trees.Row(trees.parse_row(entry))
  )
);

console.log(
  "trees encountered:",
  forest.trees_on_route(3, 1),
);

console.log(
  "product of trees on all slopes:",
  forest.trees_on_route(1, 1) *
  forest.trees_on_route(3, 1) *
  forest.trees_on_route(5, 1) *
  forest.trees_on_route(7, 1) *
  forest.trees_on_route(1, 2),
);
