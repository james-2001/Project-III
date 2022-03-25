data = open("data.txt", "r")
data = list(map(float, data.read().splitlines()))

m = 0
for i in range(len(data)):
    m = (i*m + data[i])/(i+1)

m2 = sum(data)/len(data)
print(m)
print(m2)
