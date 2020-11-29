def get_orbits(input_lines):
  orbits = {}

  for orbit in input_lines:
    orbits[orbit[1]] = orbit[0]

  return orbits


def get_path_to_root(orbits, start):
  path = [start]
  cursor = start

  while True:
    if cursor in orbits:
      path.append(orbits[cursor])
      cursor = orbits[cursor]
    else:
      break

  return path


def get_distance(orbits, start, destination):
  path_start_to_root = get_path_to_root(orbits, start)
  path_destination_to_root = get_path_to_root(orbits, destination)
  path_start_to_root.reverse()
  path_destination_to_root.reverse()

  common_length = len(set(path_start_to_root).intersection(path_destination_to_root))
  return (len(path_start_to_root) - common_length) + (len(path_destination_to_root) - common_length)


def run_part_a(input_lines):
  total_count = 0

  orbits = get_orbits(input_lines)
    
  for orbit in input_lines:
    cursor = orbit[1]

    while True:
      if cursor in orbits:
        total_count += 1
        cursor = orbits[cursor]
      else:
        break

  return total_count


def run_part_b(input_lines):
  orbits = get_orbits(input_lines)

  start = orbits['YOU']
  destination = orbits['SAN']
  
  return get_distance(orbits, start, destination)


if __name__ == '__main__':
    with open('input') as input_file:
        input_lines = [[part.strip('\n') for part in line.split(')')] for line in input_file.readlines()]
        print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
