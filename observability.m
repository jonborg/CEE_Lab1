function [OM] = observability( A, C )
%controlability: Characterizes a system by its controlability
%   Assuming a system defined by space state equations:
%   dx/dt=Ax+Bu
%   y=Cx+Du
%   The function receives matrixes A and C and returns the observality
%   matrix of the system and tells if the system is observable
    dim=size(A);
    OM=zeros(dim);
    for i=1:dim(1)
        OM(i,:)=C*A^(i-1);
    end
    
    if rank(OM)<dim(1)
        display('The system is NOT observable');
    else
        display('The system IS observable');
    end
end

