const parse_list_entry = (entry) => {
  const pattern = /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/;
  let [min, max, letter, password] = entry.match(pattern).slice(1);

  return [
    parseInt(min, 10),
    parseInt(max, 10),
    letter,
    password,
  ];
};

const is_valid_for_wrong_policy = (min, max, letter, password) => {
  let count = password.split(letter).length - 1;
  return min <= count && count <= max;
};

const is_valid_for_right_policy = (first_index, second_index, letter, password) => {
  let a = password[first_index - 1];
  let b = password[second_index - 1];

  return a === letter && b !== letter || a !== letter && b === letter;
};

exports.parse_list_entry = parse_list_entry;
exports.is_valid_for_wrong_policy = is_valid_for_wrong_policy;
exports.is_valid_for_right_policy = is_valid_for_right_policy;
