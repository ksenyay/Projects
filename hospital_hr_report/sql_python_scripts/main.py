import pandas as pd

file_path = 'C:\\Users\\kseny\\Desktop\\Absenteeism_at_work.csv'

df = pd.read_csv(file_path)

Q1 = df['Absenteeism time in hours'].quantile(0.25)
Q3 = df['Absenteeism time in hours'].quantile(0.75)

IQR = Q3-Q1

lower_bound = Q1 - 1.5 * IQR
upper_bound = Q3 + 1.5 * IQR

print(lower_bound,upper_bound)


# Identify outliers
outliers = df[(df['Absenteeism time in hours'] < lower_bound) | (df['Absenteeism time in hours'] > upper_bound)]

# Print outliers
print(outliers)

