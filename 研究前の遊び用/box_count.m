function box_count(n) 
set_appearance();
p=10;r=28;b=8/3;
h = 0.01; % step
X=linspace(0,0,n); 
Y=linspace(0,0,n);
Z=linspace(0,0,n);
X(1) = 1;
Y(1) = 1;
Z(1) = 1; 

for i=1:n-1
    X(i+1) =X(i)+h*(-p*X(i)+p*Y(i));
    Y(i+1) = Y(i)+h*(-Z(i)*X(i)+r*X(i)-Y(i));
    Z(i+1) =  Z(i)+h*(X(i)*Y(i)-b*Z(i)); 

end
plot3(X,Y,Z);
Xmax=max(X);
Xmin=min(X);
Ymax=max(Y);
Ymin=min(Y);
Zmax=max(Z);
Zmin=min(Z);
Xmax=ceil(Xmax);
Xmin=floor(Xmin);
Ymax=ceil(Ymax);
Ymin=floor(Ymin);
Zmax=ceil(Zmax);
Zmin=floor(Zmin);

Mcount=100;
Xdelta=(Xmax-Xmin)/Mcount;
Ydelta=(Ymax-Ymin)/Mcount;
Zdelta=(Zmax-Zmin)/Mcount;

count=0;
for x=Xmin:Xdelta:Xmax-Xdelta
   for y=Ymin:Ydelta:Ymax-Ydelta
      for z=Zmin:Zdelta:Zmax-Zdelta
          count_mode=0;
          for j=1:n-1
              if(X(j)>x && X(j)<x+Xdelta && Y(j)>y && Y(j)<y+Ydelta && Z(j)>z && Z(j)<z+Zdelta)
                  count_mode=1;
              end 
          end
          if count_mode == 1
             count=count+1; 
          end
      end    
   end
end


D_0=log(count)/log(Mcount)



