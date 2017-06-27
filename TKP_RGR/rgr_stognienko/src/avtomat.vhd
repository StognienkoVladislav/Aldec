library IEEE;
use IEEE.STD_LOGIC_1164.all;
entity karno is
	generic (Lin: integer :=1; Lst : integer := 3); 
	port(x: in STD_LOGIC_vector (Lin downto 0); z: out STD_LOGIC);
end karno;

architecture karno of karno is
	signal r3,s3,r2,s2,r1,s1,r0,s0 : STD_LOGIC := '0';
	signal q:STD_LOGIC_vector(Lst downto 0):="0000";
begin
	process   	--F1
	begin	 
		wait on q(0),q(1),q(2),q(3),x(0),x(1) ;	 
		r3 <= (not q(0)) and (not x(1));
		s3 <= q(1) and x(1);
		r2 <= not q(3);
		s2 <= x(1) and q(3) and not q(1);
		r1 <= q(3) and (not x(1));
		s1 <= (not q(3)) and q(0) and (not x(1));		 
		r0 <= x(0);  
		s0 <= x(1) and (not x(0));
	end process; 
	
	z<= (q(2) and (not  q(0))) or ((not  q(2)) and (not q(1)) and q(0)); -- F2            
	
	--memory register (RS-latches)
	process
	begin
		wait on r0,s0,r1,s1,r2,s2,r3,s3;
		q(0)<=s0 or (not(r0) and q(0)); q(1)<=s1 or (not(r1) and q(1));	
		q(2)<=s2 or (not(r2) and q(2)); q(3)<=s3 or (not(r3) and q(3));	
	end process;   
end karno;
