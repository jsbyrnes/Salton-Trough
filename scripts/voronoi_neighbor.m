function [vn] = voronoi_neighbor(model)
%Code taken from
%https://people.sc.fsu.edu/~jburkardt/presentations/voronoi_neighbors.pdf

x = [ model.xCell model.zCell ];

[ n, ~ ] = size ( x );

%
% V contains the Voronoi vertices,
% C contains indices of Voronoi vertices that form the (finite sides of the)
% Voronoi cells.
%
[ ~, C ] = voronoin ( x );
%
% Two nodes are neighbors if they share an edge, that is, two Voronoi
% vertices.
%
vn = sparse ( n, n );

for i = 1 : n

    for j = i + 1 : n

        s = size ( intersect ( C{i}, C{j} ) );

        if ( 1 < s(2) )

            vn(i,j) = 1;
            vn(j,i) = 1;

        end

    end

end

