
def run_part_a(values):
    return len([values[i] for i in range(len(values)) if i > 0 and values[i] > values[i - 1]])


def run_part_b(values):
    return run_part_a([sum(values[i:i+3]) for i in range(len(values) - 2)])


if __name__ == '__main__':
    with open('../input') as input_file:
        input_values = [int(line) for line in input_file.readlines() if line]
        print(f'Part A: {run_part_a(input_values)}\nPart B: {run_part_b(input_values)}')
