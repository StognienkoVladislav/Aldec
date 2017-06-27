  library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity avtomat is
generic (
TZ: time :=0ns);
port(
x : in STD_LOGIC_VECTOR(1 downto 0);
y : inout STD_LOGIC
);

end avtomat;

--}} End of automatically maintained section

architecture avtomat of avtomat is
function vecint (vec1: std_logic_vector)
return integer is
variable retval:integer:=0;

	begin
	
		for i in vec1'length-1 downto 0 loop
			if (vec1(i)='1') then retval:=retval*2+1;
			else retval:= retval*2; end if;
		end loop;
		return retval;
	end vecint;
type stab is array (0 to 6, 0 to 3) of integer;
type outtab is array (0 to 6) of std_logic;
constant tab_st: stab :=(
 (0,0,1,20)
,(2,20,1,20)
,(2,20,3,20)
,(4,20,3,20)
,(4,20,5,20)
,(5,20,5,6)
,(0,20,20,6));
Constant tab_z : outtab :=('0','1','0','0','1','0','1');
signal st,nexst: integer:=0;
begin
process
begin
y<=tab_z(st);
wait on x, st;
if st = 20 then null;
else
nexst<=tab_st(st,vecint(x));
wait for TZ;
end if;
end process;

st<= transport nexst after TZ;

end avtomat;
