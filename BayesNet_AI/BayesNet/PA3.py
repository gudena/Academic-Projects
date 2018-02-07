import sys
import re
import random

burglary = None
earthQuake = None
alarm = None
maryCalls = None
johnCalls = None

burglaryCPT = [{"B": True, "value": 0.001}, {"B": False, "value": 0.999}]

earthQuakeCPT = [{"E": True, "value": 0.002}, {"E": False, "value": 0.998}]

alarmCPT = [{"A": True, "B": True, "E": True, "value": 0.95}, {"A": True, "B": True, "E": False, "value": 0.94},
            {"A": True, "B": False, "E": True, "value": 0.29}, {"A": True, "B": False, "E": False, "value": 0.001},
            {"A": False, "B": True, "E": True, "value": 0.05}, {"A": False, "B": True, "E": False, "value": 0.06},
            {"A": False, "B": False, "E": True, "value": 0.71}, {"A": False, "B": False, "E": False, "value": 0.999}]

johnCallsCPT = [{"A": True, "J": True, "value": 0.9}, {"A": True, "J": False, "value": 0.1},
                {"A": False, "J": True, "value": 0.05}, {"A": False, "J": False, "value": 0.95}]

maryCallsCPT = [{"A": True, "M": True, "value": 0.7}, {"A": True, "M": False, "value": 0.3},
                {"A": False, "M": True, "value": 0.01}, {"A": False, "M": False, "value": 0.99}]


class Node:
    def __init__(self):
        self.name = ""
        self.parents = []
        self.child = []
        self.cpt = []
        self.value = None


def init():
    global burglary, earthQuake, alarm, maryCalls, johnCalls
    burglary = Node()
    earthQuake = Node()
    alarm = Node()
    maryCalls = Node()
    johnCalls = Node()

    burglary.name = "B"
    burglary.cpt = burglaryCPT
    burglary.child.append(alarm)

    earthQuake.name = "E"
    earthQuake.cpt = earthQuakeCPT
    earthQuake.child.append(alarm)

    alarm.name = "A"
    alarm.cpt = alarmCPT
    alarm.child.append(maryCalls)
    alarm.child.append(johnCalls)
    alarm.parents.append(burglary)
    alarm.parents.append(earthQuake)

    maryCalls.name = "M"
    maryCalls.cpt = maryCallsCPT
    maryCalls.parents.append(alarm)

    johnCalls.name = "J"
    johnCalls.cpt = johnCallsCPT
    johnCalls.parents.append(alarm)


def parseEvidence(evidence):
    split = re.split("[<>]+", evidence)
    split = filter(bool, split)
    evidence = []
    for info in split:
        infoSplit = re.split("[,]+", info)
        infoSplit = filter(bool, infoSplit)
        if (len(infoSplit) == 2):
            obj = Node()
            if (infoSplit[0].lower() == 'a'):
                obj = alarm
            elif (infoSplit[0].lower() == 'm'):
                obj = maryCalls
            elif (infoSplit[0].lower() == 'j'):
                obj = johnCalls
            elif (infoSplit[0].lower() == 'e'):
                obj = earthQuake
            elif (infoSplit[0].lower() == 'b'):
                obj = burglary
            obj.value = True if infoSplit[1].lower() == 't' else False
            evidence.append(obj)
    evidence = [i for i in evidence if i]
    return evidence


def parseQuery(query):
    queryVariables = []
    split = re.split("[,]+", query)
    split = filter(bool, split)
    for variable in split:
        if (variable.lower() == 'j'):
            queryVariables.append(johnCalls)
        elif (variable.lower() == 'm'):
            queryVariables.append(maryCalls)
        elif (variable.lower() == 'a'):
            queryVariables.append(alarm)
        elif (variable.lower() == 'b'):
            queryVariables.append(burglary)
        elif (variable.lower() == 'e'):
            queryVariables.append(earthQuake)
    return queryVariables


def parseInput(input):
    split = re.split("[\[\]]+", input)
    split = filter(bool, split)
    if (len(split) == 2):
        # parseEvidence(split[0])  # split[0] - evidence,
        # return parseQuery(split[1])  # split[1] - query
        return parseEvidence(split[0]), parseQuery(split[1])


def enumerate():
    global burglary, earthQuake, alarm, maryCalls, johnCalls
    sum = 0
    print (burglary.value)
    print (earthQuake.value)
    print (alarm.value)
    print (maryCalls.value)
    print (johnCalls.value)
    for bEach in burglaryCPT:
        if burglary.value is None or bEach["B"] == burglary.value:
            for eEach in earthQuakeCPT:
                if earthQuake.value is None or (eEach["E"] == earthQuake.value):
                    for aEach in alarmCPT:
                        if (alarm.value is None or aEach["A"] == alarm.value) and (
                                        aEach["B"] == bEach["B"] and aEach["E"] == eEach["E"]):
                            for jEach in johnCallsCPT:
                                if (johnCalls.value is None or jEach["J"] == johnCalls.value) and (
                                            jEach["A"] == aEach["A"]):
                                    for mEach in maryCallsCPT:
                                        if (maryCalls.value is None or mEach["M"] == maryCalls.value) and (
                                                    mEach["A"] == aEach["A"]):
                                            sum += (
                                                bEach["value"] * eEach["value"] * aEach["value"] * mEach["value"] *
                                                jEach[
                                                    "value"])
    return sum


def getBValue():
    # if (burglary.value is not None):
    #     return burglary.value
    prob = 0
    for row in burglaryCPT:
        if (row["B"] is True):
            prob = row["value"]
    rand = random.random()
    if (rand <= prob):
        return True
    else:
        return False


def getEValue():
    # if (earthQuake.value is not None):
    #     return earthQuake.value
    prob = 0
    for row in earthQuakeCPT:
        if (row["E"] is True):
            prob = row["value"]
    rand = random.random()
    if (rand <= prob):
        return True
    else:
        return False


def getAValue(bValue, eValue):
    # if (alarm.value is not None):
    #     return alarm.value
    prob = 0
    for row in alarmCPT:
        if (row["A"] is True and row["B"] == bValue and row["E"] == eValue):
            prob = row["value"]
    rand = random.random()
    if (rand <= prob):
        return True
    else:
        return False


def getMValue(aValue):
    # if (maryCalls.value is not None):
    #     return maryCalls.value
    prob = 0
    for row in maryCallsCPT:
        if (row["M"] is True and row["A"] == aValue):
            prob = row["value"]
    rand = random.random()
    if (rand <= prob):
        return True
    else:
        return False


def getJValue(aValue):
    # if (johnCalls.value is not None):
    #     return johnCalls.value
    prob = 0
    for row in johnCallsCPT:
        if (row["J"] is True and row["A"] == aValue):
            prob = row["value"]
    rand = random.random()
    if (rand <= prob):
        return True
    else:
        return False


def filterSamples(samples, evidence):
    output = []
    for sample in samples:
        add = True
        for variable in evidence:
            for sVar in sample:
                if add and variable.name in sVar and sVar[variable.name] != variable.value:
                    add = False
        if add:
            output.append(sample)
    return output


def calculatePriorSampling(query, evidence, size, rejection = False):
    samples = []
    output = "["
    for index in range(0, size, 1):
        b = getBValue()
        e = getEValue()
        a = getAValue(b, e)
        m = getMValue(a)
        j = getJValue(a)
        sample = [{"B": b}, {"E": e}, {"A": a}, {"M": m}, {"J": j}]
        samples.append(sample)
    samples = filterSamples(samples,evidence)
    for qVar in query:
        matched = 0
        for sample in samples:
            for sVar in sample:
                if qVar.name in sVar and sVar[qVar.name] is True:
                    matched += 1
        output += "<"
        if rejection:
            output += (qVar.name + "," + str(matched * 1.0 / len(samples)) + ">")
        else:
            output += (qVar.name + "," + str(matched*1.0/size) + ">")
    output += "]"
    return output

def calculateExactInference(query, index=0, rows=[], processed=[]):
    output = "["
    for variable in query:
        sum = 0
        result = 0
        for value in [True, False]:
            isNone = variable.value is None
            if (isNone):
                variable.value = value
            result = enumerate()
            sum += result
            if (isNone):
                variable.value = None
        prob = (sum - result) / sum
        output += "<"
        output += (variable.name + "," + str(prob) + ">")
    output += "]"
    return output

    # if (index < len(query)):
    #     variable = query[index]
    #     for value in [True,False]:
    #         variable.value = value
    #         processed.insert(0, variable)
    #         rows = calculateExactInference(query, index+1, rows, processed)
    #         processed.pop(0)
    #     if(len(processed) == 0):
    #         sum = 0
    #         for row in rows:
    #             sum += row["value"]
    #         for row in rows:
    #             row["value"] /= sum
    #     return rows
    # else:
    #     result = enumerate()
    #     row = {}
    #     for var in processed:
    #         row[var.name] = var.value
    #     row["value"] = result
    #     rows.append(row)
    #     return rows


if __name__ == "__main__":
    # print "Please enter Evidence set and Query in format [< N1, V 1 >, ..., < NN, V N >] [NQ1, ..., NQM]:"
    input = sys.argv[1]
    init()
    evidence, query = parseInput(input)
    print (evidence[1].name)
    print (query)
    print "Using Exact Inference by Enumeration:", calculateExactInference(query)
    print "Using Prior Sampling:", calculatePriorSampling(query, evidence, 50000, rejection = False)
    print "Using Rejection Sampling:", calculatePriorSampling(query, evidence, 50000, rejection = True)
