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
      nearby_people = []

      nearby_people << generation[r - 1][c - 1] if r > 0 && c > 0
      nearby_people << generation[r - 1][c] if r > 0
      nearby_people << generation[r - 1][c + 1] if r > 0 && c < max_col_index
      nearby_people << generation[r][c - 1] if c > 0
      nearby_people << generation[r][c + 1] if c < max_col_index
      nearby_people << generation[r + 1][c - 1] if r < max_row_index && c > 0
      nearby_people << generation[r + 1][c] if r < max_row_index
      nearby_people << generation[r + 1][c + 1] if r < max_row_index && c < max_col_index

      people_count = nearby_people.count('#')

      case seat
      when 'L'
        people_count == 0 ? '#' : 'L'
      when '#'
        people_count >= 4 ? 'L' : '#'
      when '.'
        '.'
      end
    }
  }

  # puts next_generation.map { |row| row.join }.join("\n"), "\n"
end

puts 'Occupied seats:', generation.flatten.count('#')
