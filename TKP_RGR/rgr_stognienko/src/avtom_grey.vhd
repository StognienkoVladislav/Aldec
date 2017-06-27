library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity kod_grey is
	generic (Lin: integer :=1; 
	K: integer :=15; M: integer :=3;
	Lst : integer := 3;
	TZ: time :=0ns);
	 port(x: in bit_vector (Lin downto 0);y : inout STD_LOGIC);
end kod_grey;
architecture kod_grey of kod_grey is
function vecint (vec1: bit_vector) return integer is
		variable retval:integer:=0;
	begin
		for i in vec1'length-1 downto 1 loop
			if (vec1(i)='1') then retval:=(retval+1)*2;
			else  retval:= retval*2; end if;
		end loop;
		if vec1(0)='1' then 
			retval:=retval+1;
	   	else null; end if;
		return retval;
	end vecint;
	type stab is array (0 to K, 0 to M) of bit_vector(Lst downto 0);
	type outtab is array (0 to K) of std_logic;
constant tab_st: stab :=(		
("0000","0000","0001","1111"),	  
("0011","1111","0001","1111"),	  
("1111","1111","1111","1111"),	 
("0011","1111","1011","1111"), 	  
("0000","1111","1111","1111"),	  
("1111","1111","1111","1111"),	  
("1111","1111","1111","1111"),	  
("1111","1111","1111","1111"),	  
("1111","1111","1111","1111"),	  
("1001","1111","1101","1111"),	  
("1111","1111","1111","1111"), 	  
("1001","1111","1011","1111"),	  
("0100","1111","1111","1100"),	  
("1101","1111","1101","1100"),	  
("1111","1111","1111","1111"),	  
("1111","1111","1111","1111"));	   
constant tab_z : outtab :=('0', '1', '0', '0', '1', '0','0','0','0','1','0','0','1','0','0','0');
 signal st,nexst: bit_vector(Lst downto 0):="0000";
begin
	process 
	begin
		wait on x, st;
		if st="1111" then null; 	
		else 
			nexst<=tab_st(vecint(st),vecint(x));   
			y<=tab_z(vecint(st));
		end if;
end process;					 
	st<= transport nexst after TZ;	
end kod_grey;
