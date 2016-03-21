function [CM] = controlability( A, B )
%controlability: Characterizes a system by its controlability
%   Assuming a system defined by space state equations:
%   dx/dt=Ax+Bu
%   y=Cx+Du
%   The function receives matrixes A and B and returns the controlability
%   matrix of the system and tells if the system is controlable
    dim=size(A);
    CM=zeros(dim);
    for i=1:dim(1)
        CM(:,i)=A^(i-1)*B;
    end
    
    if rank(CM)<dim(1)
        display('The system is NOT controlable');
    else
        display('The system IS controlable');
    end
end

