% helmstaedter_to_swc
% Nathan Spencer 2017

if ~ exist('kn_e2006_ALLSKELETONS_FINAL2012', 'var')
    load Helmstaedter_et_al_Nature_2013_skeletons_contacts_matrices.mat;
end

skeletons = kn_e2006_ALLSKELETONS_FINAL2012;
cellIDs = kn_e2006_ALLSKELETONS_FINAL2012_cellIDs;
numberOfCells = max(cellIDs);
cellToSkeletonCount = zeros(numberOfCells);

for skeletonIndex = 1:length(skeletons)
    
    cellID = cellIDs(skeletonIndex);
    cellToSkeletonCount(cellID) = cellToSkeletonCount(cellID) + 1;
    
    nodeData = skeletons{1, skeletonIndex}.nodes;
    edgeData = skeletons{1, skeletonIndex}.edges;
    numberOfNodes = length(nodeData);
    output = cell(numberOfNodes, 7);
    
    % build lookup table for edges
    edgeLookup = zeros(max(max(edgeData)), 1);
    [edgeDataRows, edgeDataCols] = size(edgeData);
    
    for edgeIndex = 1:edgeDataRows
        child = edgeData(edgeIndex, 2);
        parent = edgeData(edgeIndex, 1);
        edgeLookup(child) = parent;
    end
    
    % root nodes in swc should have parent -1
    for edgeLookupIndex = 1:length(edgeLookup)
        if edgeLookup(edgeLookupIndex) == 0
            edgeLookup(edgeLookupIndex) = -1;
        end
    end
    
    fileName = strcat('cell', num2str(cellID), '_', ...
        num2str(cellToSkeletonCount(cellID)), '.swc');
    fileID = fopen(fileName', 'w');
    formatSpec = '%s %s %s %s %s %s %s\n';

    for nodeIndex = 1:numberOfNodes
        
        if nodeIndex > length(edgeLookup)
            continue
        end
        
        currentParent = edgeLookup(nodeIndex);
        
        if num2str(currentParent) == -1
            continue
        end
                
        currentNode = nodeData(nodeIndex, :);
        currentNode(1) = currentNode(1) - 1;
        
        % adjustment for root node
        if currentNode(1) == 0
            currentNode(1) = -1;
        end
        
        coordinateX = num2str(currentNode(1) / 1000, '%.4f');
        coordinateY = num2str(currentNode(2) / 1000, '%.4f');
        coordinateZ = num2str(currentNode(3) / 1000, '%.4f');
       
        output{nodeIndex, 1} = num2str(nodeIndex);              % index
        output{nodeIndex, 2} = '0';                             % type
        output{nodeIndex, 3} = coordinateX;                     % x
        output{nodeIndex, 4} = coordinateY;                     % y
        output{nodeIndex, 5} = coordinateZ;                     % z
        output{nodeIndex, 6} = num2str(currentNode(4) / 1000);  % radius
        output{nodeIndex, 7} = num2str(currentParent);          % parent
    
        fprintf(fileID, formatSpec, output{nodeIndex, :});
            
    end
    
    fclose(fileID);
    
end