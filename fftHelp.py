def ffthelper(lst):
    L=[]
    W=[]
    I=[]
    M=[]
    N=[]
    A=[]
    L.append(lst[0]+lst[4])
    L.append(lst[0]-lst[4])
    L.append(lst[2]+lst[6])
    L.append(lst[2]-lst[6])
    L.append(lst[1]+lst[5])
    L.append(lst[1]-lst[5])
    L.append(lst[3]+lst[7])
    L.append(lst[3]-lst[7])
    
    W.append(1)
    W.append(0.7071-0.7071j)
    W.append(-1j)
    W.append(-0.7071-0.7071j)
    W.append(-1)
    W.append(-0.7071+0.7071j)
    W.append(1j)
    W.append(0.7071+0.7071j)
    
    I.append(L[2]*W[0])
    I.append(L[3]*W[2])
    I.append(L[2]*W[4])
    I.append(L[3]*W[6])
    I.append(L[6]*W[0])
    I.append(L[7]*W[2])
    I.append(L[6]*W[4])
    I.append(L[7]*W[6])
    
    M.append(L[0]+I[0])
    M.append(L[1]+I[1])
    M.append(L[0]+I[2])
    M.append(L[1]+I[3])
    M.append(L[4]+I[4])
    M.append(L[5]+I[5])
    M.append(L[4]+I[6])
    M.append(L[5]+I[7])
 
    N.append(M[4]*W[0])
    N.append(M[5]*W[1])
    N.append(M[6]*W[2])
    N.append(M[7]*W[3])
    N.append(M[4]*W[4])
    N.append(M[5]*W[5])
    N.append(M[6]*W[6])
    N.append(M[7]*W[7])
    
    A.append(M[0]+N[0])
    A.append(M[1]+N[1])
    A.append(M[2]+N[2])
    A.append(M[3]+N[3])
    A.append(M[0]+N[4])
    A.append(M[1]+N[5])
    A.append(M[2]+N[6])
    A.append(M[3]+N[7])
    
    print("printing L...")
    print(L)
    
    print()
    print("printing I...")
    print(I)
    
    print()
    print("printing M...")
    print(M)
    
    print()
    print("printing N...")
    print(N)
    
    print()
    print("printing Output...")
    print(A)
