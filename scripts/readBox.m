function [xyz,scd]=readBox(pbin,pcd)
% input: 
% pbin: directory to the file *.pbin, which contains the coords of the sampled points written by the solver
% pcd:  directory to the file *.TIMESTEP.pcd, which is the actual sampled data at a timestep

% output:
% xyz:  coordinates in matrix of size [Npoints, 3]
% scd:  data formated as matrix of size [Nvar, Npoints]

fh = fopen(pbin,'r');
endian = 'l';
magic_number = fread(fh,1,'int64',endian); % magic number
if magic_number ~= 1235813
    endian = 'b';
end
fread(fh,1,'int64',endian); % skip version
np = fread(fh,1,'int64',endian); % number of points
assert(2 == fread(fh,1,'int64',endian)); % 0:no data, 1:delta, 2:index
buf = fread(fh,3*np,'double',endian); % always double for consistency w/ other pbins
ind = fread(fh,np,'int64',endian); % global index (should equal ordering in ascii file)
fclose(fh);

xyz = zeros(np,3);
for i=1:np
    for j=1:3
        xyz(1+ind(i),j) = buf(3*(i-1)+j);
    end
end

fh = fopen(pcd,'r');
endian = 'l';
magic_number = fread(fh,1,'int64',endian); % magic number
if magic_number ~= 1235813
    endian = 'b';
end
fread(fh,1,'int64',endian); % skip version
assert(np == fread(fh,1,'int64',endian)); % number of points
nv = fread(fh,1,'int64',endian); % number of variables
prec = fread(fh,1,'int64',endian); % 0 float/ 1 doubleNx

if (prec == 1)
    buf = fread(fh,nv*np,'double',endian); % note that each scalar gets a row
else
    buf = fread(fh,nv*np,'float',endian);
end

scd = zeros(nv,np);
for j = 1:nv
    for i = 1:np
        scd(j,1+ind(i)) = buf(i+(j-1)*np);
    end
end
fclose(fh);
end

% %scatter3(xyz(:,1),xyz(:,2),xyz(:,3),100*abs(scd(1,:))); % create scatter plot sized by first scalar data member
% figure();
% plot(1:size(ind),ind); % plot ascii order