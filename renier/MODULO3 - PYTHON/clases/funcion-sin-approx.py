def run(x: float) -> float:
    op = ( 180 - x ) 
    up = ( 4 * x ) * op
    down = 40500 - x * op
    sin = up / down 
    return sin

print(run(90))
print(run(45))
print(run(50))
