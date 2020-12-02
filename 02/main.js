const fs = require('fs');
const passwords = require('./passwords');

var input = fs.readFileSync('./02/input.txt', 'utf8');
var password_entries = input.trim().split('\n').map(
  entry => passwords.parse_list_entry(entry)
);

console.log(
  "valid entries:",
  password_entries.filter(entry => passwords.is_valid_for_wrong_policy(...entry)).length,
);

console.log(
  "valid entries:",
  password_entries.filter(entry => passwords.is_valid_for_right_policy(...entry)).length,
);
