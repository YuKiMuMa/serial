library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity serial is

    Port ( 	CLK : in std_logic;
			RX : in std_logic);
end serial;

architecture Behavioral of serial is

	signal bsy : std_logic :='0';
	signal count : std_logic_vector(18 downto 0);
	signal r_read : std_logic;
	signal b_count : std_logic_vector(2 downto 0);

begin


process(CLK)
begin
	if CLK'event and CLK='1' then
		if bsy = '1' then
			if count < "1010001011000" then
				count <= count + '1';
			elsif count = "1010001011000" then
				count <="0000000000000";
			end if;
		else 
			if RX = '0' then
				bsy <= '1';
			else
				bsy <= '0';
			end if;
		end if;
	end if;
end process;

process(count)
begin
	if count="1010001011000" then
		r_read <= '1';
	else
		r_read <= '0';
	end if;
end process;

process(r_read)
begin
	if r_read'event and r_read='1' then
		if b_count < "111" then
			if RX = '1' then
				s_result <= std_logic_vector(shift_right(unsigned(s_result), 1));
				s_result <= s_result + "10000000";
				b_count <= b_count + '1';
			else
				s_result <= std_logic_vector(shift_right(unsigned(s_result), 1));
				s_result <= s_result + "00000000";
				b_count <= b_count + '1';
			end if;
		elsif b_count = "111" then
			s_result <= "00000000";
			b_count <= "000";
			bsy <='0';
		end if;
	else
		r_read <= '0';
	end if;
end process;




end Behavioral;
