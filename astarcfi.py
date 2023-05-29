import heapq

def astar(grid, start_x, start_y, goal_x, goal_y):
    # Define the possible movements (up, down, left, right, diagonals)
    movements = [(0, 1), (0, -1), (1, 0), (-1, 0), (1, 1), (1, -1), (-1, 1), (-1, -1)]

    # Get the dimensions of the grid
    rows = len(grid)
    cols = len(grid[0])

    # Define a helper function to calculate the heuristic (Manhattan distance)
    def heuristic(x1, y1, x2, y2):
        return abs(x1 - x2) + abs(y1 - y2)

    # Define a Node class to represent each position on the grid
    class Node:
        def __init__(self, x, y, g_cost=float('inf'), h_cost=0, parent=None):
            self.x = x
            self.y = y
            self.g_cost = g_cost
            self.h_cost = h_cost
            self.parent = parent

        def __lt__(self, other):
            return self.g_cost + self.h_cost < other.g_cost + other.h_cost

    # Initialize the start and goal nodes
    start_node = Node(start_x, start_y, 0, heuristic(start_x, start_y, goal_x, goal_y))
    goal_node = Node(goal_x, goal_y)

    # Create a priority queue (open_set) to store the nodes to be explored
    open_set = []
    heapq.heappush(open_set, start_node)

    # Create a set (closed_set) to store the nodes that have been visited
    closed_set = set()

    # Create a 2D array to store the g_cost of each node
    g_costs = [[float('inf')] * cols for _ in range(rows)]
    g_costs[start_x][start_y] = 0

    # Start the A* algorithm
    while open_set:
        current_node = heapq.heappop(open_set)

        # Check if the current node is the goal
        if current_node.x == goal_node.x and current_node.y == goal_node.y:
            path = []
            while current_node:
                path.append((current_node.x, current_node.y))
                current_node = current_node.parent
            return path[::-1]  # Reverse the path to get it from start to goal

        closed_set.add((current_node.x, current_node.y))

        # Explore the neighbors of the current node
        for dx, dy in movements:
            new_x = current_node.x + dx
            new_y = current_node.y + dy

            # Check if the new position is within the grid
            if 0 <= new_x < rows and 0 <= new_y < cols:
                # Check if the new position is an obstacle or has been visited
                if grid[new_x][new_y] > 0 or (new_x, new_y) in closed_set:
                    continue

                # Calculate the new g_cost for the neighbor
                new_g_cost = current_node.g_cost + 1

                # Check if the new g_cost is better than the current g_cost for the neighbor
                if new_g_cost < g_costs[new_x][new_y]:
                    # Update the g_cost and parent for the neighbor
                    g_costs[new_x][new_y] = new_g_cost
                    neighbor = Node(new_x, new_y, new_g_cost, heuristic(new_x, new_y, goal_x, goal_y), current_node)

                    # Add the neighbor to the open_set
                    heapq.heappush(open_set, neighbor)

    # No path found
    return []
#sample
grid = [
    [0, 0, 0, 0, 0],
    [0, 1, 1, 0, 0],
    [0, 0, 0, 0, 1],
    [0, 1, 0, 0, 0],
    [0, 0, 0, 0, 0]
]

start_x, start_y = 0, 0
goal_x, goal_y = 4, 4

path = astar(grid, start_x, start_y, goal_x, goal_y)
print(path)
