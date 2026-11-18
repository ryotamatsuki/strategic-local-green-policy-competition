from pathlib import Path
import re
import sys
import sympy as sp
from sympy.parsing.sympy_parser import parse_expr, standard_transformations, implicit_multiplication_application, convert_xor
sys.path.insert(0,str(Path.cwd()))
from scripts.verify_stage10 import general_switching_polynomial

obj = general_switching_polynomial()
th, kx, kg, mu, nu, kappa, d, e, beta, xi = obj['symbols']
symbols = {str(s): s for s in obj['symbols']}
src = Path('sections/appendix.tex').read_text()
p = sp.Poly(obj['P_th'], th)
printed = {}
for i in reversed(range(5)):
    start = src.index(f'A_{i}={{}}&')+len(f'A_{i}={{}}&')
    end_options = [x for stop in (r'\end{align}',r'\\'+'\n'+f'A_{i-1}') if (x:=src.find(stop,start))!=-1]
    end = min(end_options)
    s=src[start:end]
    s=s.replace(r"\left", "").replace(r"\right", "")
    s=s.replace(r"\Big[", "(").replace(r"\Big]", ")")
    for a,b in [(r'\quad',''),(r'\\',''),('&',''),(r'\[','('),(r'\]',')'),
                ('k_x','kx'),('k_g','kg'),(r'\beta','beta'),(r'\nu','nu'),(r'\xi','xi'),
                (r'\mu','mu'),('{','('),('}',')')]:
        s=s.replace(a,b)
    s=' '.join(re.findall(r'kg|kx|beta|mu|nu|xi|d|e|\d+|[+\-^()]',s))
    parsed=parse_expr(s,local_dict=symbols,transformations=standard_transformations+(convert_xor,implicit_multiplication_application))
    printed[i]=sp.expand(parsed)
    diff=sp.expand(printed[i]-p.nth(2*i))
    print(f'A_{i}', diff)
    assert diff == 0
expected_minus=kx*kg*(4-th**2)*(2-th)-4*(kg+kx*mu**2)
expected_plus=-kx*kg*(4-th**2)*(2+th)+4*(kg+kx*mu**2)
assert sp.factor(obj['den']-2*expected_minus**2*expected_plus**2)==0
print('Appendix A.2 all five printed coefficients and denominator normalization PASS')
