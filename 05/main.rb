require 'ostruct'

boarding_passes = $stdin
  .read
  .split(/\n/)
  .map { |pass_input|
    row = pass_input[0..6].gsub('F', '0').gsub('B', '1').to_i(2)
    col = pass_input[7..9].gsub('L', '0').gsub('R', '1').to_i(2)

    OpenStruct.new(
      row: row,
      col: col,
      seat_id: row * 8 + col,
    )
  }

puts "Highest seat ID:", boarding_passes.map(&:seat_id).max

puts "Your seat ID", boarding_passes.map(&:seat_id).sort.each_cons(2).find { |a, b|
  a + 1 != b
}[0] + 1
