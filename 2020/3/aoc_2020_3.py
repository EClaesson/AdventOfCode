import functools


def get_tree_count(input_lines, x_delta, y_delta):
  return [input_lines[y][x_delta * (y // y_delta) % len(input_lines[y])] for y in range(y_delta, (len(input_lines)), y_delta)].count('#')


def run_part_a(input_lines):
  return get_tree_count(input_lines, 3, 1)


def run_part_b(input_lines):
  return functools.reduce(lambda a, b: a * b, [get_tree_count(input_lines, slope[0], slope[1]) for slope in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]])


if __name__ == '__main__':
  with open('input') as input_file:
      input_lines = [line.strip('\n') for line in input_file.readlines()]
      print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
