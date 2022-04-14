% this function calculate the distance between the point i on the UPO
% and punto

function dist = distanza_punto_traiettoria(punto,UPO_traj, i)
dist = norm(UPO_traj(i,:)-punto);
end