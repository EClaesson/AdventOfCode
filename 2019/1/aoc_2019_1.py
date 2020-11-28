def get_needed_fuel(mass):
    return (mass // 3) - 2


def get_total_needed_fuel(mass):
    sum = 0
    last = get_needed_fuel(mass)
    
    while last > 0:
        sum += last
        last = get_needed_fuel(last)

    return sum


def run_part_a(input_line):
    return sum([get_needed_fuel(int(input_line)) for input_line in input_lines])


def run_part_b(input_lines):
    return sum([get_total_needed_fuel(int(input_line)) for input_line in input_lines])


if __name__ == '__main__':
    with open('input') as input_file:
        input_lines = [line.strip('\n') for line in input_file.readlines()]
        print(f'Part A: {run_part_a(input_lines)}\nPart B: {run_part_b(input_lines)}')
