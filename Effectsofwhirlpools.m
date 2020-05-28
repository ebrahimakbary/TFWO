

function Whirlpool=Effectsofwhirlpools(Whirlpool, iter)

    global ProblemSettings;
    global TFWOSettings;
    
    CostFunction=ProblemSettings.CostFunction;
    VarMin=ProblemSettings.VarMin;
    VarMax=ProblemSettings.VarMax;
    nVar=ProblemSettings.nVar;

    
    for i=1:numel(Whirlpool)
        for j=1:Whirlpool(i).nObW
           
            if numel(Whirlpool)~=1

                J=[];
                S=[];
                E=[];
                D=[];
        AA = 1:numel(Whirlpool);
        AA(i)=[];
             for t=1:AA
 
J(t)=(abs(Whirlpool(t).Cost)^1)*((abs(sum(Whirlpool(t).Position))-(sum(Whirlpool(i).Objects(j).Position)))^0.5);

             end
              %%%%%%%%%%%%% min
             S=min(J);
             [ E D]=find(S==J);

             d=rand(1, nVar).*(Whirlpool(D(1)).Position-Whirlpool(i).Objects(j).Position);

             %%%%%%%%%%%%% max
             S2=max(J);
             [ E2 D2]=find(S2==J);
         d2=rand(1, nVar).*(Whirlpool(D2(1)).Position-Whirlpool(i).Objects(j).Position);  


                       end

             if numel(Whirlpool)==1
            
                 d=rand(1, nVar).*(Whirlpool(i).Position-Whirlpool(i).Objects(j).Position);
               d2=0;
               D(1)=i; 
             end



Whirlpool(i).Objects(j).delta=Whirlpool(i).Objects(j).delta+ (rand)*rand*pi;

  eee= Whirlpool(i).Objects(j).delta;
  fr0=(cos(eee));
  fr10=(-sin(eee));

x=((fr0.*(d))+(fr10.*(d2)))*(1+abs(fr0*fr10*1));
RR=(Whirlpool(i).Position-x);
   RR =min(max(RR,VarMin),VarMax);
         Cost=CostFunction(RR ) ;
         if  Cost<= Whirlpool(i).Objects(j).Cost
          Whirlpool(i).Objects(j).Cost=Cost;
           Whirlpool(i).Objects(j).Position=RR;
         end
%%%%%%%%%%Pseudo-code 3:
FE_i=(abs(cos(Whirlpool(i).Objects(j).delta)^2*sin(Whirlpool(i).Objects(j).delta)^2))^2;

%              Q=Q^(2);


    if rand<(FE_i)
          k=randi([1 nVar]);


Whirlpool(i).Objects(j).Position(k)=unifrnd(VarMin(k),VarMax(k));
Whirlpool(i).Objects(j).Cost=CostFunction(Whirlpool(i).Objects(j).Position);
    end

            
        end
    end
%%%%%%%%%% Pseudo-code 4:
    J2=[];
                      for t=1:numel(Whirlpool)
            J2(t)=(Whirlpool(t).Cost);

             end
            S2=min(J2);
             [ E2 D2]=find(S2==J2);
             d2=Whirlpool(D2(1)).Position;
    for i=1:numel(Whirlpool)
                
               J=[];
            E=[];
            D=[];

 for t=1:numel(Whirlpool)
 J(t)=Whirlpool(t).Cost*(abs((sum(Whirlpool(t).Position))-(sum(Whirlpool(i).Position))));

if t==i
    J(t)=inf;
end
             end
             S=min(J);
             [ E D]=find(S==J);
%%%%%%%%%%
Whirlpool(i).delta=Whirlpool(i).delta+ (rand)*rand*pi;
             d=Whirlpool(D(1)).Position-Whirlpool(i).Position;
             fr=abs(cos(Whirlpool(i).delta)+sin(Whirlpool(i).delta));
              x= fr*rand(1, nVar).*(d);


            Whirlpool1(i).Position=Whirlpool(D(1)).Position-x;
            
           Whirlpool1(i).Position=min(max(Whirlpool1(i).Position,VarMin),VarMax);
            
            Whirlpool1(i).Cost=CostFunction(Whirlpool1(i).Position);
            %%%%%%Pseudo-code 5:%%selection Whirlpool
            if Whirlpool1(i).Cost<=Whirlpool(i).Cost
                 Whirlpool(i).Position= Whirlpool1(i).Position;
              Whirlpool(i).Cost= Whirlpool1(i).Cost; 
            end
            
    end
      
                if S2<Whirlpool(D2(1)).Cost
                 Whirlpool(i).Position=  d2;
              Whirlpool(i).Cost= S2; 
            end
end

