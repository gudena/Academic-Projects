# search.py
# ---------
# Licensing Information:  You are free to use or extend these projects for
# educational purposes provided that (1) you do not distribute or publish
# solutions, (2) you retain this notice, and (3) you provide clear
# attribution to UC Berkeley, including a link to http://ai.berkeley.edu.
# 
# Attribution Information: The Pacman AI projects were developed at UC Berkeley.
# The core projects and autograders were primarily created by John DeNero
# (denero@cs.berkeley.edu) and Dan Klein (klein@cs.berkeley.edu).
# Student side autograding was added by Brad Miller, Nick Hay, and
# Pieter Abbeel (pabbeel@cs.berkeley.edu).


"""
In search.py, you will implement generic search algorithms which are called by
Pacman agents (in searchAgents.py).
"""

import util

class SearchProblem:
    """
    This class outlines the structure of a search problem, but doesn't implement
    any of the methods (in object-oriented terminology: an abstract class).

    You do not need to change anything in this class, ever.
    """

    def getStartState(self):
        """
        Returns the start state for the search problem.
        """
        util.raiseNotDefined()

    def isGoalState(self, state):
        """
          state: Search state

        Returns True if and only if the state is a valid goal state.
        """
        util.raiseNotDefined()

    def getSuccessors(self, state):
        """
          state: Search state

        For a given state, this should return a list of triples, (successor,
        action, stepCost), where 'successor' is a successor to the current
        state, 'action' is the action required to get there, and 'stepCost' is
        the incremental cost of expanding to that successor.
        """
        util.raiseNotDefined()

    def getCostOfActions(self, actions):
        """
         actions: A list of actions to take

        This method returns the total cost of a particular sequence of actions.
        The sequence must be composed of legal moves.
        """
        util.raiseNotDefined()


def tinyMazeSearch(problem):
    """
    Returns a sequence of moves that solves tinyMaze.  For any other maze, the
    sequence of moves will be incorrect, so only use this for tinyMaze.
    """
    from game import Directions
    s = Directions.SOUTH
    w = Directions.WEST
    return  [s, s, w, s, w, w, s, w]

#Represent node information in class
class Node():
    def __init__(self, state, direction, cost, h_score):
        self.state = state
        self.direction = direction
        self.cost = cost
        self.h_score = h_score

def getFringeActions(problem, fringe, search, heuristic=None):
    visited = []
    while not fringe.isEmpty():
        node = fringe.pop()
        actions = node.direction
        cost = node.cost
        if not node.state in visited:
            visited.append(node.state)

            if problem.isGoalState(node.state):
                return actions

            for child in problem.getSuccessors(node.state):
                child_node = child[0]
                direction = actions + [child[1]]
                cost = cost + child[2]
                temp_node = Node(child_node, direction, cost, 0)
                if search == 'ucs':
                    fringe.push(temp_node, problem.getCostOfActions(direction))
                elif search == 'astar':
                    newcost = problem.getCostOfActions(direction) + heuristic(child_node, problem)
                    fringe.push(temp_node, newcost)
                else:
                    fringe.push(temp_node)

def depthFirstSearch(problem):
    """
    Search the deepest nodes in the search tree first.

    Your search algorithm needs to return a list of actions that reaches the
    goal. Make sure to implement a graph search algorithm.

    To get started, you might want to try some of these simple commands to
    understand the search problem that is being passed in:


    print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    print "Start's successors:", problem.getSuccessors(problem.getStartState())
    """
    #print "Start state:", problem.getStartState()
    #print "Is the start a goal?", problem.isGoalState(problem.getStartState())
    #print "Start's successors:", problem.getSuccessors(problem.getStartState())

    fringe = util.Stack()
    fringe.push(Node(problem.getStartState(), [], 0, 0))
    return getFringeActions(problem, fringe, 'dfs')

def breadthFirstSearch(problem):
    """Search the shallowest nodes in the search tree first."""
    fringe = util.Queue()
    fringe.push(Node(problem.getStartState(), [], 0, 0))
    return getFringeActions(problem, fringe, 'bfs')


def uniformCostSearch(problem):
    """Search the node of least total cost first."""
    fringe = util.PriorityQueue()
    fringe.push(Node(problem.getStartState(),[],0, 0), 0)
    return getFringeActions(problem, fringe, 'ucs')

def nullHeuristic(state, problem=None):
    """
    A heuristic function estimates the cost from the current state to the nearest
    goal in the provided SearchProblem.  This heuristic is trivial.
    """
    return 0

def aStarSearch(problem, heuristic=nullHeuristic):
    """Search the node that has the lowest combined cost and heuristic first."""
    fringe = util.PriorityQueue()
    start_state = problem.getStartState()
    init_cost = heuristic(start_state, problem)
    fringe.push(Node(start_state, [], 0, 0), 0+init_cost)
    return getFringeActions(problem, fringe, 'astar', heuristic)



# Abbreviations
bfs = breadthFirstSearch
dfs = depthFirstSearch
astar = aStarSearch
ucs = uniformCostSearch