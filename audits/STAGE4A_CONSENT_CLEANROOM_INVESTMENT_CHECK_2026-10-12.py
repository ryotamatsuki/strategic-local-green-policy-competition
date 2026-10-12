"""Clean-room Stage-4A scalar-investment best-response audit (stdlib only).

For 300 random policy histories and targeted kink/monopoly boundaries, computes
the closed-form five-regime investment continuation and independently
enumerates each firm's global unilateral investment best response over u>=0.

This tests the Stage-2 continuation *numerically*; it is not a proof of the
entire Stage-1 Nash equilibrium correspondence.
"""
import math
import random

R=59/200

def game(w1,w2,t):
    L=2-4*R/(4-t*t)
    if t and t*w1>=(2-R)*w2:
        qa=w1/(2-R);qb=0.;ua=R*qa;ub=0.;region="M1"
    elif t and t*w2>=(2-R)*w1:
        qb=w2/(2-R);qa=0.;ub=R*qb;ua=0.;region="M2"
    elif t and t*w1>=L*w2:
        qa=w2/t;qb=0.;ua=2*qa-w1;ub=0.;region="K1"
    elif t and t*w2>=L*w1:
        qb=w1/t;qa=0.;ub=2*qb-w2;ua=0.;region="K2"
    else:
        qa=(L*w1-t*w2)/(L*L-t*t)
        qb=(L*w2-t*w1)/(L*L-t*t)
        ua=4*R*qa/(4-t*t);ub=4*R*qb/(4-t*t);region="D"
    return region,(qa,qb),(ua,ub)

def quantity(ui,wi,uj,wj,t):
    vi=wi+ui;vj=wj+uj
    if t and 2*vi<=t*vj:return 0.
    if t and 2*vj<=t*vi:return vi/2
    return (2*vi-t*vj)/(4-t*t)

def profit(ui,wi,uj,wj,t):
    q=quantity(ui,wi,uj,wj,t)
    return q*q-ui*ui/(2*R)

def global_best_value(wi,wj,uj,t):
    vj=wj+uj
    # Investment changes own effective market intercept linearly.
    stops=[0.]
    if t>0:
        stops.extend([max(0.,t*vj/2-wi),max(0.,2*vj/t-wi)])
    stops=sorted(set(stops))
    best=(-math.inf,None)
    for index,left in enumerate(stops):
        right=stops[index+1] if index+1<len(stops) else math.inf
        if right<=left:continue
        probe=left+1 if not math.isfinite(right) else (left+right)/2
        if t>0 and 2*(wi+probe)<=t*vj:
            alpha,beta=0.,0.
        elif t>0 and 2*vj<=t*(wi+probe):
            alpha,beta=.5,wi/2
        else:
            alpha,beta=2/(4-t*t),(2*wi-t*vj)/(4-t*t)
        denom=1/R-2*alpha*alpha
        assert denom>0
        vertex=2*alpha*beta/denom
        candidate=max(left,vertex)
        if math.isfinite(right):candidate=min(right,candidate)
        for x in (left,candidate):
            value=profit(x,wi,uj,wj,t)
            if value>best[0]:best=(value,x)
    return best

def verify(w1,w2,t):
    region,qs,us=game(w1,w2,t)
    for i in (0,1):
        v,u=(w1,us[0]) if i==0 else (w2,us[1])
        other,uo=(w2,us[1]) if i==0 else (w1,us[0])
        best,best_u=global_best_value(v,other,uo,t)
        gain=best-profit(u,v,uo,other,t)
        assert gain<1e-8,(t,w1,w2,region,i,gain,best_u,u)
        assert abs(qs[i]-quantity(u,v,uo,other,t))<1e-8
    return region

def main():
    rng=random.Random(517)
    counts={}
    total=0
    for t in (.1,.3,.5,.9,1.):
        for _ in range(60):
            s1,h1,s2,h2=[rng.uniform(0,40) for _ in range(4)]
            w1=2+.05*s1+1.2*h1
            w2=2+.05*s2+1.2*h2
            region=verify(w1,w2,t)
            counts[region]=counts.get(region,0)+1
            total+=1
    # Target both distinct downstream regime boundaries, approached on
    # either side, with both active firms' policies feasible nonnegative.
    for t in (.3,.9,1.):
        L=2-4*R/(4-t*t)
        w2=4.
        for coefficient in (L/t,(2-R)/t):
            for scale in (1-1e-8,1,1+1e-8):
                region=verify(w2*coefficient*scale,w2,t)
                counts[region]=counts.get(region,0)+1
                total+=1
    assert counts["K1"]>0 and counts["K2"]>0
    assert counts["M1"]>0 and counts["M2"]>0 and counts["D"]>0
    print("independent firm-investment histories:",total)
    print("five regimes represented:",counts)
    print("PASS numerical: no profitable unilateral scalar-investment deviation")
if __name__=="__main__":
    main()
