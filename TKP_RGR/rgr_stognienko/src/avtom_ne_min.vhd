library IEEE;
use IEEE.STD_LOGIC_1164.all; 
entity a1ent is 
generic (TZ: time :=0ns); 
 port( 
	 X: in bit_vector (1 downto 0); 
	 Y: out bit_vector(0 downto 0) 
 	); 
end a1ent; 

architecture a1arc of a1ent is 
-- bit_vector to integer
function vecint (vec1: bit_vector) 
return integer is 
variable retval:integer:=0; 
begin 
 for i in vec1'length-1 downto 1 loop 
 if (vec1(i)='1') then retval:=(retval+1)*2; 
 else retval:= retval*2; end if; 
 end loop; 
 if vec1(0)='1' then retval:=retval+1; 
 else null; end if; 
 return retval; 
 end vecint; 
type stab is array (0 to 15, 0 to 3) of integer;
constant tab_st: stab :=(
 (0,1,16,16)
,(2,1,16,16)
,(2,16,3,16)
,(4,16,3,16)
,(4,16,5,16)
,(6,16,5,16)
,(6,16,7,16)
,(8,16,7,16)
,(8,16,9,16)
,(10,16,9,16)
,(10,16,11,16)
,(12,16,11,16)
,(12,16,16,13)
,(14,16,16,13)
,(14,15,16,16)
,(0,15,16,16)
); 
 		 		  
type outtab is array (0 to 15) of bit_vector(0 downto 0); 
constant tab_y : outtab :=("0","0","0","1","0","0","1","0", "0","0","0","0","0","1","0","0"); 
signal st,nexst: integer:=0; 
begin 
 process begin 
 wait on X, st; 
 if st=16 then null; 
 else 
 nexst<=tab_st(st,vecint(X)); 
 Y<=transport tab_y(st)after TZ; 
 end if; 
 end process; 
 st<= transport nexst after TZ; 
end a1arc;
