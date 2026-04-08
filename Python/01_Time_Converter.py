def convert_minutes(minutes):
    hours = minutes // 60
    remaining_minutes = minutes % 60
    return f"{hours} hrs {remaining_minutes} minutes"


# Test
num = int(input("Enter minutes: "))
print(convert_minutes(num))