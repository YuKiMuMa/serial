library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity serial is

    Port ( 	CLK : in std_logic;
			RX : in std_logic);
end serial;

architecture Behavioral of serial is

	signal Adone : std_logic :='0';
	signal X_count_pos : std_logic_vector(18 downto 0);
	signal count : std_logic_vector(18 downto 0);

begin

process(CLK)
begin
	if CLK'event and CLK='1' then
		if DD < "10110001000000" then
			DD <= DD +'1';
		elsif DD = "10110001000000" then
			DD <= "00000000000000";
		end if;
	end if;
end process;

process(DD)
begin
	if DD="01011000100000" then
		CLK100 <= '1';
	elsif DD="00000000000000" then
		CLK100 <= '0';
	end if;
end process;




end Behavioral;
