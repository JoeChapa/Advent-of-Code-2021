#First, let's get our input data
file = open("Day 12 Input.txt", 'r')
input_data = file.readlines()
file.close()



def find_connection(input_line):
    directions = input_line.strip().split("-")
    return directions

def generate_map(connections):
    paths={}
    for connection in connections:
        start, end = find_connection(connection)

        #We have to check if the value is in paths already. If yes, we append a path, if not, we must add the value
        if start not in paths.keys():
            paths[start] = [end]
        else:
            paths[start] = paths[start] + [end]
        '''
        #If start is_upper() we have to have end point back to start
        if start.isupper():
            if end not in paths.keys():
                paths[end] = [start]
            else:
                paths[end] = paths[end] + [start]
        '''
    return paths

cave_map = generate_map(input_data)
print(cave_map)

#Next we have to walk through the map. I think we should create a generate_paths() and then a valid_path(paths)? and lastly count the paths len of valid_paths

def generate_paths(map, start_point):
    path = [start_point]
    for i in map[start_point]:
        try:
            path.append(generate_paths(map, i))
        except:
            if i == 'end':
                path.append(i)
    return path

def un_nest_paths(map, start_point):
    path_list = []
    #'start' for s in map[start_point]
    for i in map[start_point]:
        n_path = [start_point, map[i]]
        while is_end != 'end':
            n_path.append()


    return path


list_of_paths = generate_paths(cave_map, 'start')
#print(list_of_paths)

test_paths = un_nest_paths(cave_map, 'start')
print(f'test_paths: {test_paths}')

#Takes a list of paths and only returns the valid ones
#We are going to filter the list multiple times
#First, to only find paths that start and end with start and end
#Next, remove duplicates
#secondly to make sure no small cave is repeated twice
'''
valid_path(paths_list):
    valid_paths = []
    for path in paths_list:
        if path[1] == 'start and path[-1] == 'end'
        valid_paths.append(path)
        

'''
