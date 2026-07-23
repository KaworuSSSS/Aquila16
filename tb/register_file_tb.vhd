-- =====================================================
-- Aquila16 CPU
-- Testbench: register_file
--
-- Prueba del banco de registros
--
-- Pruebas:
-- 1. Reset
-- 2. Escritura en R3
-- 3. Lectura de R3
-- 4. Verificación de R0 fijo en cero
--
-- =====================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file_tb is
end entity;


architecture sim of register_file_tb is


    -- Señales del reloj
    signal clk : std_logic := '0';


    -- Reset
    signal reset : std_logic := '0';


    -- Lecturas
    signal read_addr_a : std_logic_vector(2 downto 0);
    signal read_addr_b : std_logic_vector(2 downto 0);

    signal read_data_a : std_logic_vector(15 downto 0);
    signal read_data_b : std_logic_vector(15 downto 0);


    -- Escritura
    signal write_enable : std_logic;
    signal write_addr   : std_logic_vector(2 downto 0);
    signal write_data   : std_logic_vector(15 downto 0);



begin


    ----------------------------------------------------
    -- Generador de reloj 50 MHz simulado
    ----------------------------------------------------

    clk <= not clk after 10 ns;



    ----------------------------------------------------
    -- Instancia del módulo a probar
    ----------------------------------------------------

    DUT: entity work.register_file

    port map(

        clk_i => clk,

        reset_i => reset,


        read_addr_a_i => read_addr_a,
        read_data_a_o => read_data_a,


        read_addr_b_i => read_addr_b,
        read_data_b_o => read_data_b,


        write_enable_i => write_enable,

        write_addr_i => write_addr,

        write_data_i => write_data

    );



    ----------------------------------------------------
    -- Proceso de prueba
    ----------------------------------------------------

    process

    begin


        -- Estado inicial

        write_enable <= '0';

        write_addr <= "000";

        write_data <= x"0000";


        read_addr_a <= "000";

        read_addr_b <= "000";



        -- Reset

        reset <= '1';

        wait for 40 ns;


        reset <= '0';

        wait for 20 ns;



        -- Escribir 1234h en R3

        write_enable <= '1';

        write_addr <= "011";

        write_data <= x"1234";


        wait for 20 ns;



        -- Quitar escritura

        write_enable <= '0';


        -- Leer R3

        read_addr_a <= "011";


        wait for 20 ns;



        -- Leer R0

        read_addr_b <= "000";


        wait for 20 ns;



        -- Fin simulación

        wait;


    end process;


end architecture;
