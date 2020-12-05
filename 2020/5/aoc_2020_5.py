ROW_COUNT = 128
COL_COUNT = 8

def get_half(range, char):
  if char in ['F', 'L']:
    return (range[0], range[1] - (range[1] - range[0]) // 2 - 1)
  elif char in ['B', 'R']:
    return (range[0] + ((range[1] - range[0]) // 2) + 1, range[1])


def get_pass_id(line):
  row, col = line[:7], line[7:]
  row_range, col_range = (0, ROW_COUNT - 1), (0, COL_COUNT - 1)

  for row_item in row:
    row_range = get_half(row_range, row_item)

  for col_item in col:
    col_range = get_half(col_range, col_item)

  return row_range[0] * 8 + col_range[0]


def run_part_a(input_lines):
  return max([id for id in [get_pass_id(line) for line in input_lines]])


def run_part_b(input_lines):
  existing = [id for id in [get_pass_id(line) for line in input_lines]]
  return [id for id in range(max(existing)) if id not in existing][-1]


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [line.strip('\n') for line in input_file.readlines()]
      print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
