# -*- coding: utf-8 -*-
import unittest
import scipy.stats as stat
import statistics


with open("answers.txt") as file:
    var = int(float(file.readline()))
    int_number1 = file.readline()
    Relative_frequency = int_number1.split('\t')
    int_number2 = file.readline()
    Teoretical_frequency = int_number2.split('\t')
    int_number3 = file.readline()
    int_number4 = file.readline()
    Charach = int_number3.split('\t')

with open("vriants.txt") as file:
    i = 0
    while  i != var:
        i = i + 1
        vriant = file.readline()
        f_exp = file.readline()


vriant = vriant.split(',')
f_exp = f_exp.split(',')
i = 0

for element in vriant:
    vriant[i]= int(element)
    f_exp[i] = round(float(f_exp[i]),4)
    i = 1 + i
    

x = stat.chisquare(vriant, f_exp)
X2_t = round(x[0],3)
n = sum(vriant)

if var % 2 == 1:
    alfa = 0.05#нечетный вриант
else:
    alfa = 0.025
value = stat.chi2.ppf(1-alfa,len(vriant)-3)
X2k_t = round(value,3)




class TestLab(unittest.TestCase):

    def test_Relative_frequency(self):
        i=0
        for element in vriant:
            self.assertEqual(float(Relative_frequency[i]), vriant[i], f'Should be {vriant[i]}')
            i=i+1


    def test_frequencies_in_procent(self):
        i=0
        for element in vriant:
            self.assertEqual(round(float(Teoretical_frequency[i]),3), round(f_exp[i],3), f'Should be {f_exp[i]}')
            i=i+1

    def test_X2(self):
        self.assertEqual(round(float(Charach[0]),3), X2_t, f"Should be {X2_t}ошибка в статистике Х2")

    def test_X2K(self):
        self.assertEqual(round(float(Charach[1]),3), X2k_t, f"Should be {X2k_t},ошибка в критической точке Х2")





if __name__ == '__main__':
    unittest.main()


