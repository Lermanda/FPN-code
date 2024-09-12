function [vc, flag] = cvIn(vc,dims)

  

      flag=uint32(0);
        if(vc(1,1)<1)
            vc(1,1)=1;
       
            flag=uint32(1);
        end
        if(vc(1,1)>dims(1))
            vc(1,1)=dims(1);
            flag=uint32(1);
        end 
        if(vc(2,1)<1)
            vc(2,1)=1;
           
            flag=uint32(1);
        end
        if(vc(2,1)>dims(2))
            vc(2,1)=dims(2);
            flag=uint32(1);
        end
        if(vc(3,1)<1)
           
            vc(3,1)=1;
            flag=uint32(1);
        end
        if(vc(3,1)>dims(3))
            vc(3,1)=dims(3);
            flag=uint32(1);
        end
        if(vc(4,1)<1)
          
            vc(4,1)=1;
            flag=uint32(1);
        end
        if(vc(4,1)>dims(4))
          
            vc(4,1)=dims(4);
            flag=uint32(1);
        end
   

