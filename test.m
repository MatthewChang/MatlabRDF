A = [0 2 1;0 4 3;1 4 5;1 8 6;1 8 10; 4 8 14; 5 9 13];
mu = mean(A,1);
M = A - repmat(mu,7,1);
[U,S,V] = svd(M)
CLbasis = V(:,1:2)
MM = CLbasis*(CLbasis'*CLbasis)*CLbasis'*M';
MM = MM';
err = norm(MM-M)