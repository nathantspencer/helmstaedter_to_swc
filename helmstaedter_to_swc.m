% Nathan Spencer 2017

if ~ exist('kn_e2006_ALLSKELETONS_FINAL2012', 'var')
    load Helmstaedter_et_al_Nature_2013_skeletons_contacts_matrices.mat;
end

skeletons = kn_e2006_ALLSKELETONS_FINAL2012;

for skeletonIndex = 1:1
    
    scaleX = str2double(skeletons{1, skeletonIndex}.parameters.scale.x);
    scaleY = str2double(skeletons{1, skeletonIndex}.parameters.scale.y);
    scaleZ = str2double(skeletons{1, skeletonIndex}.parameters.scale.z);
    
    nodeData = skeletons{1, skeletonIndex}.nodesNumDataAll;
    numberOfNodes = length(nodeData);
    output = zeros(numberOfNodes, 7);

    for nodeIndex = 1:numberOfNodes
        
        currentNode = nodeData(nodeIndex, :);
        
        coordinateX = currentNode(3) .* scaleX;
        coordinateY = currentNode(4) .* scaleY;
        coordinateZ = currentNode(5) .* scaleZ;
       
        output(nodeIndex, 1) = nodeIndex;           % index
        output(nodeIndex, 2) = currentNode(6);      % type
        output(nodeIndex, 3) = coordinateX;         % x coordinate
        output(nodeIndex, 4) = coordinateY;         % y coordinate
        output(nodeIndex, 5) = coordinateZ;         % z coordinate
        output(nodeIndex, 6) = currentNode(2);      % radius
        output(nodeIndex, 7) = currentNode(1) - 1;  % parent
            
    end
    
    dlmwrite(strcat('skeleton', num2str(skeletonIndex), '.swc'), ...
        output, 'delimiter', ' ');
    
end