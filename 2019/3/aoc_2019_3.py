def get_all_points(wire):
  points = []
  point_steps = {}
  coord = (0, 0, 0)
  step = 0

  for turn in wire:
    direction = {'U': (0, 1), 'D': (0, -1), 'L': (-1, 0), 'R': (1, 0)}[turn[0]]
    value = int(turn[1:])

    while value > 0:
      step += 1
      coord = (coord[0] + direction[0], coord[1] + direction[1])

      if coord[0] not in point_steps:
        point_steps[coord[0]] = {}

      if coord[1] not in point_steps[coord[0]]:
        point_steps[coord[0]][coord[1]] = step
        points.append(coord)

      value -= 1

  return (points, point_steps)


def get_intersections(wire_a, wire_b):
  points_a, steps_a = get_all_points(wire_a)
  points_b, steps_b = get_all_points(wire_b)

  intersections = [(point[0], point[1], (steps_a[point[0]][point[1]] + steps_b[point[0]][point[1]])) for point in set(points_a).intersection(points_b)]

  return intersections


def get_distance_to_origin(point):
  return abs(point[0]) + abs(point[1])


def get_closest_to_origin(points):
  closest_distance = 0

  for point in points:
    distance = get_distance_to_origin(point)

    if distance < closest_distance or closest_distance == 0:
      closest_distance = distance

  return closest_distance


def get_shortest_intersection(intersections):
  steps = 0

  for intersection in intersections:
    if intersection[2] < steps or steps == 0:
      steps = intersection[2]

  return steps


def run_part_a(wire_a, wire_b):
  return get_closest_to_origin(get_intersections(wire_a, wire_b))


def run_part_b(wire_a, wire_b):
  return get_shortest_intersection(get_intersections(wire_a, wire_b))


if __name__ == '__main__':
    with open('input') as input_file:
        input_lines = [line.split(',') for line in input_file.readlines()]
        print(f'Part A: {run_part_a(input_lines[0], input_lines[1])}\nPart B: {run_part_b(input_lines[0], input_lines[1])}')
