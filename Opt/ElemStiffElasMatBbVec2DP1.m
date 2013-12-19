function [Kg]=ElemStiffElasMatBbVec2DP1(q,me,areas,lambda,mu)
% function [Kg]=ElemStiffElasMatBbVec2DP1(q,me,areas,lambda,mu)
% Global Computation of the element stiffness elasticity matrix
% Block numbering
%
% Parameters:
%  q: Array of vertices coordinates, 2-by-nq array.
%     q(il,j) is the il-th coordinate of the j-th vertex, il in {1,2}
%     and j in {1,...,nq}.
%  me: Connectivity array, 3-by-nme array.
%      me(jl,k) is the storage index of the jl-th  vertex 
%      of the k-th triangle in the array q of vertices coordinates,
%  areas: Array of areas, 1-by-nme array. areas(k) is the area 
%         of the k-th triangle.
%  lambda: the first Lame coefficient in Hooke's law. Supposed to be constant in the domain
%  mu: the second Lame coefficient in Hooke's law. Supposed to be constant in the domain
%
%
% Return values:
%  Kg: `36\times \nme` global element stiffness elasticity matrix
%
%
% Copyright (C) 2013  CJS (LAGA)
%   see README for details
order=1;
ndf=(order+1)*(order+2)/2;
dim=2*ndf;
ndf2=dim*dim;
u=q(:,me(2,:))-q(:,me(3,:));
G1=[u(2,:);-u(1,:)];
u=q(:,me(3,:))-q(:,me(1,:));
G2=[u(2,:);-u(1,:)];
u=q(:,me(1,:))-q(:,me(2,:));
G3=[u(2,:);-u(1,:)];
clear u
coef=ones(2,1)*(0.5./sqrt(areas));
G1=G1.*coef;
G2=G2.*coef;
G3=G3.*coef;
clear coef
Kg=zeros(ndf2,size(me,2));
Kg(1,:)=(lambda + 2.*mu).*G1(1,:).^2 + mu.*G1(2,:).^2;
Kg(2,:)=(lambda + 2.*mu).*G1(1,:).*G2(1,:) + mu.*G1(2,:).*G2(2,:);
Kg(3,:)=(lambda + 2.*mu).*G1(1,:).*G3(1,:) + mu.*G1(2,:).*G3(2,:);
Kg(4,:)=lambda.*G1(1,:).*G1(2,:) + mu.*G1(1,:).*G1(2,:);
Kg(5,:)=lambda.*G1(1,:).*G2(2,:) + mu.*G1(2,:).*G2(1,:);
Kg(6,:)=lambda.*G1(1,:).*G3(2,:) + mu.*G1(2,:).*G3(1,:);
Kg(8,:)=(lambda + 2.*mu).*G2(1,:).^2 + mu.*G2(2,:).^2;
Kg(9,:)=(lambda + 2.*mu).*G2(1,:).*G3(1,:) + mu.*G2(2,:).*G3(2,:);
Kg(10,:)=lambda.*G1(2,:).*G2(1,:) + mu.*G1(1,:).*G2(2,:);
Kg(11,:)=lambda.*G2(1,:).*G2(2,:) + mu.*G2(1,:).*G2(2,:);
Kg(12,:)=lambda.*G2(1,:).*G3(2,:) + mu.*G2(2,:).*G3(1,:);
Kg(15,:)=(lambda + 2.*mu).*G3(1,:).^2 + mu.*G3(2,:).^2;
Kg(16,:)=lambda.*G1(2,:).*G3(1,:) + mu.*G1(1,:).*G3(2,:);
Kg(17,:)=lambda.*G2(2,:).*G3(1,:) + mu.*G2(1,:).*G3(2,:);
Kg(18,:)=lambda.*G3(1,:).*G3(2,:) + mu.*G3(1,:).*G3(2,:);
Kg(22,:)=(lambda + 2.*mu).*G1(2,:).^2 + mu.*G1(1,:).^2;
Kg(23,:)=(lambda + 2.*mu).*G1(2,:).*G2(2,:) + mu.*G1(1,:).*G2(1,:);
Kg(24,:)=(lambda + 2.*mu).*G1(2,:).*G3(2,:) + mu.*G1(1,:).*G3(1,:);
Kg(29,:)=(lambda + 2.*mu).*G2(2,:).^2 + mu.*G2(1,:).^2;
Kg(30,:)=(lambda + 2.*mu).*G2(2,:).*G3(2,:) + mu.*G2(1,:).*G3(1,:);
Kg(36,:)=(lambda + 2.*mu).*G3(2,:).^2 + mu.*G3(1,:).^2;
Kg([7, 13, 14, 19, 20, 21, 25, 26, 27, 28, 31, 32, 33, 34, 35],:)=Kg([2, 3, 9, 4, 10, 16, 5, 11, 17, 23, 6, 12, 18, 24, 30],:);
