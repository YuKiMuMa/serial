library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity serial is

    Port ( 	CLK : in std_logic;
			RX : in std_logic;
			result : out std_logic_vector(7 downto 0)
			result1 : out std_logic_vector(7 downto 0)
			result2 : out std_logic_vector(7 downto 0)
			result3 : out std_logic_vector(7 downto 0));
end serial;

architecture Behavioral of serial is

	signal bsy : std_logic;
	signal count : std_logic_vector(12 downto 0);
	signal r_read : std_logic;
	signal b_count : std_logic_vector(3 downto 0);
	signal s_result : std_logic_vector(7 downto 0):="00000000";

begin


process(CLK)
begin
	if CLK'event and CLK='1' then
		if bsy = '1' then
			if count < "0000000001010" then
				count <= count + '1';
			elsif count = "0000000001010" then
				if b_count < "1000" then
					if RX = '1' then
						s_result <= std_logic_vector(shift_right(unsigned(s_result), 1))+ "10000000";
						b_count <= b_count + '1';
					else
						s_result <= std_logic_vector(shift_right(unsigned(s_result), 1));
						b_count <= b_count + '1';
					end if;
				elsif b_count = "1000" then
					b_count <= "0000";
					result <= s_result;
					s_result <= "00000000";
					bsy <='0';
				end if;
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






end Behavioral;
