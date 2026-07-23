-- =====================================================
-- Aquila16 CPU
-- Module: register_file
--
-- Banco de registros de propósito general
--
-- Registros:
--   R0-R7
--
-- Características:
--   - 8 registros de 16 bits
--   - 2 puertos de lectura
--   - 1 puerto de escritura
--   - R0 siempre es cero
--
-- FPGA objetivo:
--   Altera Cyclone IV EP4CE6E22C8N
--
-- =====================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity register_file is

    port(

        -- Reloj principal
        clk_i : in std_logic;

        -- Reset activo en alto
        reset_i : in std_logic;


        -- Puerto lectura A
        read_addr_a_i : in std_logic_vector(2 downto 0);
        read_data_a_o : out std_logic_vector(15 downto 0);


        -- Puerto lectura B
        read_addr_b_i : in std_logic_vector(2 downto 0);
        read_data_b_o : out std_logic_vector(15 downto 0);


        -- Puerto escritura
        write_enable_i : in std_logic;
        write_addr_i   : in std_logic_vector(2 downto 0);
        write_data_i   : in std_logic_vector(15 downto 0)

    );

end entity;



architecture rtl of register_file is


    -- Banco de 8 registros de 16 bits
    type register_array is array (0 to 7)
    of std_logic_vector(15 downto 0);


    signal registers : register_array :=
        (others => (others => '0'));


begin


    ----------------------------------------------------
    -- Lectura combinacional
    ----------------------------------------------------

    read_data_a_o <= 
        registers(to_integer(unsigned(read_addr_a_i)));


    read_data_b_o <= 
        registers(to_integer(unsigned(read_addr_b_i)));



    ----------------------------------------------------
    -- Escritura sincronizada
    ----------------------------------------------------

    process(clk_i)

    begin

        if rising_edge(clk_i) then


            -- Reset
            if reset_i = '1' then

                registers <=
                    (others => (others => '0'));


            else


                -- Escritura
                if write_enable_i = '1' then


                    -- R0 está reservado y siempre vale cero
                    if write_addr_i /= "000" then


                        registers(
                            to_integer(unsigned(write_addr_i))
                        )
                        <= write_data_i;


                    end if;


                end if;


            end if;


        end if;


    end process;



    ----------------------------------------------------
    -- R0 siempre en cero
    ----------------------------------------------------

    registers(0) <= (others => '0');


end architecture;
