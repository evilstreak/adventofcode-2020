const passwords = require('./passwords');

test('#parse_list_entry', () => {
  expect(
    passwords.parse_list_entry('1-3 a: abcde')
  ).toStrictEqual([1, 3, 'a', 'abcde']);
});

test('#is_valid_for_wrong_policy when valid', () => {
  expect(passwords.is_valid_for_wrong_policy(1, 3, 'a', 'abcde')).toBe(true);
});

test('#is_valid_for_wrong_policy when invalid', () => {
  expect(passwords.is_valid_for_wrong_policy(1, 3, 'b', 'cdefg')).toBe(false);
});

test('#is_valid_for_wrong_policy when valid (again)', () => {
  expect(passwords.is_valid_for_wrong_policy(2, 9, 'c', 'ccccccccc')).toBe(true);
});

test('#is_valid_for_right_policy when valid', () => {
  expect(passwords.is_valid_for_right_policy(1, 3, 'a', 'abcde')).toBe(true);
});

test('#is_valid_for_right_policy when invalid', () => {
  expect(passwords.is_valid_for_right_policy(1, 3, 'b', 'cdefg')).toBe(false);
});

test('#is_valid_for_right_policy when invalid (again)', () => {
  expect(passwords.is_valid_for_right_policy(2, 9, 'c', 'ccccccccc')).toBe(false);
});
