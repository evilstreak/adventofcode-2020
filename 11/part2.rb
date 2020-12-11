input = $stdin.read

generation = nil
next_generation = input.split(/\n/).map { |row|
  row.split(//)
}

# puts next_generation.map { |row| row.join }.join("\n"), "\n"

max_row_index = next_generation.count - 1
max_col_index = next_generation.first.count - 1

while generation != next_generation
  generation = next_generation

  next_generation = generation.map.with_index { |row, r|
    row.map.with_index { |seat, c|
      visible_people = 0

      visible_people += 1 if (r - 1).downto(0).map { |r| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (r - 1).downto(0).zip((c + 1).upto(max_col_index)).reject { |_, c| c.nil? }.map { |r, c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (c + 1).upto(max_col_index).map { |c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (r + 1).upto(max_row_index).zip((c + 1).upto(max_col_index)).reject { |_, c| c.nil? }.map { |r, c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (r + 1).upto(max_row_index).map { |r| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (r + 1).upto(max_row_index).zip((c - 1).downto(0)).reject { |_, c| c.nil? }.map { |r, c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (c - 1).downto(0).map { |c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'
      visible_people += 1 if (r - 1).downto(0).zip((c - 1).downto(0)).reject { |_, c| c.nil? }.map { |r, c| generation[r][c] }.find { |s| s == '#' || s == 'L' } == '#'

      case seat
      when 'L'
        visible_people == 0 ? '#' : 'L'
      when '#'
        visible_people >= 5 ? 'L' : '#'
      when '.'
        '.'
      end
    }
  }

  # puts next_generation.map { |row| row.join }.join("\n"), "\n"
end

puts 'Occupied seats:', generation.flatten.count('#')
